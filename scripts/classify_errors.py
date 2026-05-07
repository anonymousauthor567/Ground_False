#!/usr/bin/env python3
"""
Classify ground-truth errors in `proofnet_original-4.28/` by comparing each file
against the corrected golden ground truth in `proofnet_verified/`.

For each file, an LLM agent answers 4 questions:
  1. Is the informal statement mathematically true and unambiguous?
  2. Is the original formalization faithful/stronger/weaker/incomparable to the
     informal statement?
  3. If unfaithful, is the original formalization still provably true, or false/unprovable?
  4. If unfaithful, what is the error type?

Drives the `claude` CLI in `--print` mode with 24 parallel workers.
Each result is written to `<out_dir>/per_file/<stem>.json` (resumable).

Usage:
    python3 scripts/classify_errors.py
    python3 scripts/classify_errors.py --workers 24
    python3 scripts/classify_errors.py --only proofnet-185 --force
"""

from __future__ import annotations

import argparse
import concurrent.futures as cf
import json
import os
import re
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path
from typing import Optional

SCRIPT_ROOT = Path(__file__).resolve().parent.parent

CLAUDE_BIN = os.environ.get("CLAUDE_BIN", "claude")
MODEL = os.environ.get("CLAUDE_MODEL", "global.anthropic.claude-opus-4-7")
EFFORT = os.environ.get("CLAUDE_EFFORT", "max")
CLAUDE_TIMEOUT_S = int(os.environ.get("CLAUDE_TIMEOUT_S", "1800"))
MAX_RETRIES = int(os.environ.get("CLAUDE_MAX_RETRIES", "10"))

VERDICTS = ["faithful", "weaker", "stronger", "incomparable", "nl_ambiguous", "nl_wrong"]
ERROR_TYPES = [
    "misunderstanding_of_mathlib",
    "misunderstanding_of_lean",
    "misunderstanding_of_informal_statement",
    "adding_extra_case",
    "adding_extra_conclusion",
    "missing_implicit_premise",
    "missing_premise",
    "nl_ambiguous",
    "nl_mathematically_wrong",
    "other",
]
PROVABILITY = ["true", "false", "unprovable", "unknown", "independent"]

SYSTEM_PROMPT_TEMPLATE = """You are an expert in Lean 4 / Mathlib formalization and in
mathematical logic. You are given TWO versions of a Lean 4 formalization for the
same informal mathematical statement:

1. **Original formalization** — the one under review, which may contain errors.
2. **Corrected formalization** — the golden ground truth, which is known to be
   absolutely correct and faithful to the informal statement.

Your job is to classify the error (if any) in the ORIGINAL formalization by
answering 4 questions:

## Question 1: Is the informal statement mathematically true and unambiguous?
- "true_and_unambiguous" — the informal statement is mathematically true and has
  a clear, unambiguous meaning (implicit premises that are obvious from context
  don't count as ambiguity)
- "ambiguous" — the informal statement has genuinely ambiguous wording that could
  be reasonably interpreted in multiple incompatible ways
- "mathematically_wrong" — the informal statement as literally written is
  mathematically false (even accounting for reasonable implicit premises)

## Question 2: Faithfulness of the ORIGINAL formalization
Compare the ORIGINAL formalization against the informal statement:
- "faithful" — logically equivalent to the informal statement
- "weaker" — implied by the informal claim but does not imply it
- "stronger" — implies the informal claim but asserts more than asked
- "incomparable" — neither implies nor is implied by the informal claim

NOTE: Use the corrected formalization as a reference for what the informal
statement actually means. If the original and corrected are logically equivalent,
the original is faithful.

## Question 3: Provability of the ORIGINAL formalization
If the original is NOT faithful, is the original statement still:
- "true" — provably true (a valid mathematical theorem, just not what was asked)
- "false" — provably false (there exists a counterexample)
- "unprovable" — independent or undecidable
- "unknown" — you cannot determine provability
If the original IS faithful, answer "true".

## Question 4: Error type
If the original is NOT faithful, classify the error:
- "misunderstanding_of_mathlib" — used a Mathlib definition/lemma incorrectly
  (e.g., wrong API, confused `≃*` with `=`, used `Surjective` vs `SurjOn`)
- "misunderstanding_of_lean" — Lean syntax/type error in encoding (not Mathlib-specific)
- "misunderstanding_of_informal_statement" — misread what the math statement asks
- "adding_extra_case" — added hypotheses/cases not in the informal statement
- "adding_extra_conclusion" — proved more than asked
- "missing_implicit_premise" — failed to include an implicit premise needed for truth
- "missing_premise" — dropped an explicit premise from the informal statement
- "nl_ambiguous" — the informal statement is genuinely ambiguous
- "nl_mathematically_wrong" — the informal statement is mathematically wrong
- "other" — none of the above
If the original IS faithful, answer "none".

## Important guidelines
- Focus on the SEMANTIC difference between original and corrected formalizations.
- The corrected version is ALWAYS correct — use it as your reference for what the
  informal statement means.
- Look carefully at type differences, hypothesis differences, conclusion
  differences, and Mathlib API choices.
- Do NOT let theorem names influence your judgement.

You **MUST** judge impartially and objectively!!! **ultra think**, and do **deep research** in the local {{project_root}}/.lake/packages/mathlib folder to confirm specific Mathlib API usage!!!

Even if you're confident, you **MUST** use the search and bash tools to double check by looking into the local mathlib files!!!

If you are not sure about some mathematical terminology or convention, you **MUST** use the web search tool to confirm!!!

You MUST reply with a single JSON object matching the provided schema, and
nothing else.
"""

USER_PROMPT_TEMPLATE = """Please carefully compare the following two Lean 4 formalizations of the same
informal mathematical statement. The ORIGINAL may contain errors; the CORRECTED
is known to be absolutely correct and faithful.

## Informal Statement (from the comment block)
```
{informal_statement}
```

## ORIGINAL Formalization (under review)
```lean
{original_file}
```

## CORRECTED Formalization (golden ground truth)
```lean
{corrected_file}
```

Classify the error (if any) in the ORIGINAL formalization by answering the 4
questions described in the system prompt. Reply with a single JSON object.
"""

JSON_SCHEMA = {
    "type": "object",
    "additionalProperties": False,
    "required": [
        "q1_informal_status",
        "q2_faithfulness",
        "q3_provability",
        "q4_error_type",
        "reasoning",
    ],
    "properties": {
        "q1_informal_status": {
            "type": "string",
            "enum": ["true_and_unambiguous", "ambiguous", "mathematically_wrong"],
        },
        "q2_faithfulness": {
            "type": "string",
            "enum": VERDICTS,
        },
        "q3_provability": {
            "type": "string",
            "enum": PROVABILITY,
        },
        "q4_error_type": {
            "type": "string",
            "enum": ERROR_TYPES + ["none"],
        },
        "reasoning": {"type": "string"},
    },
}


# ---------------------------------------------------------------------- #
# Helpers                                                                  #
# ---------------------------------------------------------------------- #


def normalize_for_compare(content: str) -> str:
    lines = content.splitlines()
    # Remove 'noncomputable section' line, normalize whitespace
    lines = [l for l in lines if l.strip() != "noncomputable section"]
    # Collapse multiple blank lines, strip trailing whitespace per line
    result = []
    prev_blank = False
    for l in lines:
        stripped = l.rstrip()
        is_blank = not stripped
        if is_blank and prev_blank:
            continue
        result.append(re.sub(r'\s+', ' ', stripped) if stripped else '')
        prev_blank = is_blank
    return '\n'.join(result).strip()


def extract_informal(content: str) -> str:
    m = re.search(r"/-\s*Informal Statement\s*\n(.*?)-/", content, re.DOTALL)
    if m:
        return m.group(1).strip()
    m = re.search(r"/-\s*(.*?)-/", content, re.DOTALL)
    if m:
        return m.group(1).strip()
    return ""


# ---------------------------------------------------------------------- #
# Claude call                                                             #
# ---------------------------------------------------------------------- #


class ClaudeError(RuntimeError):
    pass


def call_claude(user_prompt: str, project_root: Path) -> dict:
    system_prompt = SYSTEM_PROMPT_TEMPLATE.replace(
        "{{project_root}}", str(project_root)
    )
    cmd = [
        CLAUDE_BIN,
        "-p",
        "--effort", EFFORT,
        "--system-prompt", system_prompt,
        "--disable-slash-commands",
        "--no-session-persistence",
        "--output-format", "json",
        "--input-format", "text",
        "--json-schema", json.dumps(JSON_SCHEMA),
        "--model", MODEL,
    ]
    try:
        proc = subprocess.run(
            cmd,
            input=user_prompt,
            cwd=str(project_root),
            capture_output=True,
            text=True,
            timeout=CLAUDE_TIMEOUT_S,
        )
    except subprocess.TimeoutExpired as e:
        raise ClaudeError(f"claude timeout after {CLAUDE_TIMEOUT_S}s") from e

    if proc.returncode != 0:
        raise ClaudeError(
            f"claude exited {proc.returncode}; stderr:\n{proc.stderr[-2000:]}"
        )

    try:
        envelope = json.loads(proc.stdout)
    except json.JSONDecodeError as e:
        raise ClaudeError(
            f"could not parse claude envelope: {e}\nstdout head:\n{proc.stdout[:500]}"
        ) from e

    verdict_obj = envelope.get("structured_output")
    if verdict_obj is None:
        text = envelope.get("result") or ""
        if not text:
            raise ClaudeError(
                f"no structured_output and empty result. raw: "
                f"{json.dumps(envelope)[:500]}"
            )
        try:
            verdict_obj = json.loads(text)
        except json.JSONDecodeError:
            m = re.search(r"\{.*\}", text, re.DOTALL)
            if not m:
                raise ClaudeError(f"no JSON in claude output: {text[:500]}")
            verdict_obj = json.loads(m.group(0))

    return {
        "q1_informal_status": verdict_obj["q1_informal_status"],
        "q2_faithfulness": verdict_obj["q2_faithfulness"],
        "q3_provability": verdict_obj["q3_provability"],
        "q4_error_type": verdict_obj["q4_error_type"],
        "reasoning": verdict_obj["reasoning"],
        "duration_ms": envelope.get("duration_ms"),
        "cost_usd": envelope.get("total_cost_usd"),
    }


# ---------------------------------------------------------------------- #
# Driver                                                                  #
# ---------------------------------------------------------------------- #


def proofnet_key(path: Path) -> tuple:
    m = re.match(r"proofnet-(\d+)", path.stem)
    return (int(m.group(1)),) if m else (10**9, path.stem)


def process_file(
    original_path: Path,
    corrected_path: Path,
    out_dir: Path,
    force: bool,
    counter: dict,
    counter_lock: threading.Lock,
    project_root: Path,
) -> dict:
    per_file = out_dir / "per_file" / f"{original_path.stem}.json"
    if per_file.exists() and not force:
        try:
            cached = json.loads(per_file.read_text())
            with counter_lock:
                counter["cached"] += 1
            return cached
        except Exception:
            pass

    original_content = original_path.read_text()
    corrected_content = corrected_path.read_text()

    informal = extract_informal(corrected_content) or extract_informal(original_content)

    record = {
        "file": original_path.name,
        "stem": original_path.stem,
    }

    if not original_content.strip():
        record.update({
            "q1_informal_status": "true_and_unambiguous",
            "q2_faithfulness": "unclear",
            "q3_provability": "unknown",
            "q4_error_type": "other",
            "reasoning": f"empty file: {original_path.name}",
        })
    elif normalize_for_compare(original_content) == normalize_for_compare(corrected_content):
        record.update({
            "q1_informal_status": "true_and_unambiguous",
            "q2_faithfulness": "faithful",
            "q3_provability": "true",
            "q4_error_type": "none",
            "reasoning": "Original and corrected formalizations are identical (modulo whitespace/formatting).",
        })
    else:
        prompt = USER_PROMPT_TEMPLATE.format(
            informal_statement=informal,
            original_file=original_content,
            corrected_file=corrected_content,
        )
        last_err: Optional[ClaudeError] = None
        for attempt in range(1, MAX_RETRIES + 1):
            try:
                judgement = call_claude(prompt, project_root=project_root)
                record.update(judgement)
                last_err = None
                break
            except ClaudeError as e:
                last_err = e
                if attempt < MAX_RETRIES:
                    backoff = 2 ** attempt
                    print(
                        f"  retry {attempt}/{MAX_RETRIES} for {original_path.stem} "
                        f"(backoff {backoff}s): {e}",
                        file=sys.stderr,
                        flush=True,
                    )
                    time.sleep(backoff)
        if last_err is not None:
            record.update({
                "q1_informal_status": "true_and_unambiguous",
                "q2_faithfulness": "unclear",
                "q3_provability": "unknown",
                "q4_error_type": "other",
                "reasoning": f"claude error after {MAX_RETRIES} retries: {last_err}",
            })

    per_file.parent.mkdir(parents=True, exist_ok=True)
    per_file.write_text(json.dumps(record, indent=2, ensure_ascii=False))

    with counter_lock:
        counter["done"] += 1
        n = counter["done"] + counter["cached"]
        total = counter["total"]
        print(
            f"[{n:>3}/{total}] {original_path.stem:<20} -> {record['q2_faithfulness']}",
            file=sys.stderr,
            flush=True,
        )
    return record


def render_summary(records: list[dict], out_path: Path) -> None:
    lines: list[str] = []
    lines.append("# Error Classification of `proofnet_original-4.28/`")
    lines.append("")
    lines.append("Compared against golden ground truth `proofnet_verified/`.")
    lines.append("")

    # Count faithfulness
    by_faith: dict[str, int] = {}
    for r in records:
        v = r.get("q2_faithfulness", "unclear")
        by_faith[v] = by_faith.get(v, 0) + 1

    lines.append("## Faithfulness Summary")
    lines.append("")
    lines.append("| verdict | count |")
    lines.append("|---|---|")
    for v in VERDICTS:
        lines.append(f"| {v} | {by_faith.get(v, 0)} |")
    lines.append(f"| **total** | **{len(records)}** |")
    lines.append("")

    # Count error types (excluding faithful)
    by_err: dict[str, int] = {}
    for r in records:
        if r.get("q2_faithfulness") != "faithful":
            et = r.get("q4_error_type", "other")
            by_err[et] = by_err.get(et, 0) + 1

    if by_err:
        lines.append("## Error Types (unfaithful only)")
        lines.append("")
        lines.append("| error type | count |")
        lines.append("|---|---|")
        for et in sorted(by_err, key=lambda x: -by_err[x]):
            lines.append(f"| {et} | {by_err[et]} |")
        lines.append("")

    # Count provability (excluding faithful)
    by_prov: dict[str, int] = {}
    for r in records:
        if r.get("q2_faithfulness") != "faithful":
            p = r.get("q3_provability", "unknown")
            by_prov[p] = by_prov.get(p, 0) + 1

    if by_prov:
        lines.append("## Provability (unfaithful only)")
        lines.append("")
        lines.append("| provability | count |")
        lines.append("|---|---|")
        for p in PROVABILITY:
            if by_prov.get(p, 0) > 0:
                lines.append(f"| {p} | {by_prov[p]} |")
        lines.append("")

    # Detailed list of unfaithful entries
    unfaithful = [r for r in records if r.get("q2_faithfulness") != "faithful"]
    if unfaithful:
        lines.append("## Unfaithful Entries")
        lines.append("")
        unfaithful.sort(key=lambda r: proofnet_key(Path(r["file"])))
        for r in unfaithful:
            m = re.match(r"proofnet-(\d+)", r["stem"])
            idx = m.group(1) if m else r["stem"]
            lines.append(
                f"- **{idx}** | {r['q2_faithfulness']} | "
                f"provable={r['q3_provability']} | "
                f"error={r['q4_error_type']}"
            )
            lines.append(f"  - {r.get('reasoning', '')[:200]}")
            lines.append("")

    out_path.write_text("\n".join(lines))


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--original", type=Path, required=True,
        help="Folder containing original .lean files to classify",
    )
    p.add_argument(
        "--corrected", type=Path, required=True,
        help="Folder containing corrected golden .lean files",
    )
    p.add_argument(
        "--project-root", type=Path, required=True,
        help="Root directory of the Lean project (where .lake/ lives)",
    )
    p.add_argument(
        "--out-dir", type=Path, default=None,
        help="Output directory (default: <script-root>/logs/classify-errors)",
    )
    p.add_argument("--workers", type=int, default=24)
    p.add_argument("--limit", type=int, default=None)
    p.add_argument("--only", action="append", default=[])
    p.add_argument("--force", action="store_true")
    p.add_argument("--render-only", action="store_true")
    args = p.parse_args()

    project_root = args.project_root.resolve()
    original_dir = args.original.resolve()
    corrected_dir = args.corrected.resolve()

    if args.out_dir is None:
        args.out_dir = SCRIPT_ROOT / "logs" / "classify-errors"

    if shutil.which(CLAUDE_BIN) is None and not args.render_only:
        print(
            f"claude CLI not found on PATH (looked for {CLAUDE_BIN!r}). "
            f"Install it or set CLAUDE_BIN.",
            file=sys.stderr,
        )
        return 2

    # Find files that exist in BOTH original and corrected
    original_files = sorted(original_dir.glob("*.lean"), key=proofnet_key)
    corrected_stems = {f.stem for f in corrected_dir.glob("*.lean")}
    pairs = [
        (f, corrected_dir / f.name)
        for f in original_files
        if f.stem in corrected_stems
    ]

    if args.only:
        wanted = set(args.only)
        pairs = [(o, c) for o, c in pairs if o.stem in wanted]
    if args.limit:
        pairs = pairs[: args.limit]

    if not pairs:
        print("no input file pairs matched", file=sys.stderr)
        return 1

    print(f"Processing {len(pairs)} file pairs...", file=sys.stderr)

    args.out_dir.mkdir(parents=True, exist_ok=True)
    (args.out_dir / "per_file").mkdir(exist_ok=True)
    summary_path = args.out_dir / "summary.md"
    jsonl_path = args.out_dir / "results.jsonl"

    if args.render_only:
        records = []
        for o, c in pairs:
            per = args.out_dir / "per_file" / f"{o.stem}.json"
            if per.exists():
                records.append(json.loads(per.read_text()))
    else:
        counter = {"done": 0, "cached": 0, "total": len(pairs)}
        counter_lock = threading.Lock()

        records = []
        t0 = time.time()
        with cf.ThreadPoolExecutor(max_workers=args.workers) as ex:
            futures = {
                ex.submit(
                    process_file, o, c, args.out_dir, args.force,
                    counter, counter_lock, project_root,
                ): o
                for o, c in pairs
            }
            for fut in cf.as_completed(futures):
                f = futures[fut]
                try:
                    records.append(fut.result())
                except Exception as e:
                    print(f"!! {f.name}: {e}", file=sys.stderr)
                    records.append({
                        "file": f.name,
                        "stem": f.stem,
                        "q1_informal_status": "true_and_unambiguous",
                        "q2_faithfulness": "unclear",
                        "q3_provability": "unknown",
                        "q4_error_type": "other",
                        "reasoning": f"worker exception: {e}",
                    })
        dt = time.time() - t0
        print(
            f"\nprocessed {counter['done']} (+{counter['cached']} cached) "
            f"in {dt:.1f}s",
            file=sys.stderr,
        )

    records.sort(key=lambda r: proofnet_key(Path(r["file"])))
    with jsonl_path.open("w") as fh:
        for r in records:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")

    render_summary(records, summary_path)
    print(f"\nwrote {summary_path}", file=sys.stderr)
    print(f"wrote {jsonl_path}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
