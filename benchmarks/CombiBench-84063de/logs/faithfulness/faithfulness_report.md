# Faithfulness audit of `proofnet_verified/`

For each Lean file we asked Claude to read the full file content (informal statement + Lean theorem signature) and decide whether the Lean encoding is a *strictly faithful* formalization (neither stronger nor weaker).

## Summary

| verdict | count |
|---|---|
| faithful | 72 |
| weaker | 5 |
| stronger | 3 |
| incomparable | 14 |
| unclear | 0 |
| error | 0 |
| **total** | **100** |

## faithful (72)

### apmo_1991_p2

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. "997 points in a plane" becomes `points : Fin 997 → ℝ × ℝ` with `Function.Injective points`, which makes explicit the standard implicit convention that "997 points" means 997 distinct points—a premise needed for the statement to be true (if all points coincide, there is only 1 red point). The `red_points` definition correctly takes midpoints (via Mathlib's `midpoint ℝ`, which on `ℝ × ℝ` is the usual Euclidean midpoint) over all pairs (i, j) with i ≠ j (by removing the diagonal from `Finset.univ`), and `Finset.card ≥ 1991` correctly expresses "at least 1991 distinct red points." The bound 1991 = 2·997 − 3 is the standard tight bound for this APMO problem. No hypotheses are silently added or dropped beyond the implicit distinctness premise.

### balticway_2015_p7

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal problem. `Ladies := Fin 100` matches the 100-member club. `had_tea.degree l = 56` uses Mathlib's `degree = #(G.neighborFinset v)`, which correctly counts the number of distinct other ladies adjacent to `l` (no self-loops in `SimpleGraph`), matching "tea with exactly 56 of the other members". The existence of a 50-clique captures "the Board of 50 ladies all had tea with one another" — the Lean existential form is mathematically equivalent to the informal naming of a specific set with that property. The conclusion `group1 ∪ group2 = univ ∧ Disjoint group1 group2 ∧ IsClique group1 ∧ IsClique group2` encodes a partition of the club into two tea-cliques, matching "split into two groups so that within each group any lady has had tea with any other." While the Lean version technically allows one group to be empty whereas "split into two groups" might suggest non-emptiness, this edge case is impossible under the degree-56 hypothesis (the other group would need to be a 100-clique, requiring degree 99), so the two readings coincide.

### brualdi_ch10_31

**Verdict:** `faithful`

**Reasoning**

The Lean definition `isDifferenceSet` correctly captures the standard combinatorial notion of a difference set. The expression `List.count x [i - j]` is an indicator function (returns 1 if `x = i - j`, else 0), so the double sum counts the number of ordered pairs $(i, j)$ with $i, j \in B$, $i \neq j$, and $i - j = x$. The definition asserts the existence of a constant $k$ (the parameter $\lambda$) such that every non-zero element of $\mathbb{Z}_n$ has exactly $k$ such representations — which is exactly the classical definition of a $(v, k, \lambda)$-difference set. The restriction $j \in B \setminus \{i\}$ (i.e., $i \neq j$) matches the standard convention. For the specific claim, $|B| = 5$ gives $20$ ordered differences, matching the $20$ non-zero elements of $\mathbb{Z}_{21}$ with $\lambda = 1$. The Lean theorem is a logically equivalent formalization.

### brualdi_ch10_60

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. The `LatinSquare n` structure correctly encodes a Latin square (n×n array with distinct entries in each row/column, entries in ZMod n which is {0,...,n-1}). `IsIdempotent` correctly says L(i,i) = i (via the standard Fin n → ZMod n coercion), matching Brualdi's definition. `L.1.IsSymm` uses Mathlib's `Matrix.IsSymm` (Aᵀ = A), which is the standard matrix symmetry. `Odd n` correctly expresses "odd order". The added hypothesis `hn : n > 0` is an implicit premise made explicit: without it, n = 0 is a counterexample (the empty 0×0 array vacuously satisfies both predicates but `Odd 0` is false in Mathlib), so the literal informal statement is false without this assumption. Any mathematician reading about Latin squares implicitly assumes n ≥ 1, so per the system prompt's guidance this is faithful, not weaker.

### brualdi_ch11_20

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal claim: V has cardinality n (graph of order n), the edge count via `(SimpleGraph.edgeSet G).ncard` equals the usual number of edges (V is a Fintype so this is well-defined), and Mathlib's `G.Connected` captures standard graph connectivity. The formula `(n-1)*(n-2)/2 + 1` in natural subtraction gives the correct bound for all n ≥ 2 (and the statement holds vacuously for smaller n). The added hypothesis `n ≥ 1` is a mild surfacing of the common convention that "a graph of order n" is non-empty; for n = 0, the hypothesis `1 ≤ |E|` is unsatisfiable, so the informal claim would be vacuously true anyway — no non-trivial content is lost. This qualifies as a faithful formalization.

### brualdi_ch11_5

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully formalizes the informal claim. `SimpleGraph (Fin n)` with `n ≥ 2` encodes "a graph of order n ≥ 2" (order = number of vertices). The conclusion `∃ v1 v2, v1 ≠ v2 ∧ G.degree v1 = G.degree v2` correctly asserts "two vertices of the same degree" (with distinctness). The `DecidableRel G.Adj` typeclass is a technical requirement for Mathlib's `G.degree` definition (which uses `#(G.neighborFinset v)`) and doesn't restrict the class of graphs considered — every SimpleGraph on Fin n admits decidable adjacency classically. The formalization is logically equivalent to the informal statement.

### brualdi_ch12_37

**Verdict:** `faithful`

**Reasoning**

The informal statement asks to determine the domination number of Q_3, the 3-dimensional cube graph. The Lean formalization correctly defines: (1) Q_3 as the box product of three copies of pathGraph 2, which equals K_2 □ K_2 □ K_2 — the standard 3-hypercube (since pathGraph 2 = ⊤ in Mathlib); (2) IsDominatingSet by the standard condition that every non-member has a neighbor in the set; (3) dominationNum as the minimum cardinality of a finite dominating set via an iInf over Finset V with .toNat. The "determine" problem is encoded using the standard pattern of an abbreviated solution constant (brualdi_ch12_37_solution : ℕ := sorry) that the solver will instantiate with the numeric answer. This is a faithful encoding of the informal statement.

### brualdi_ch14_33

**Verdict:** `faithful`

**Reasoning**

The informal statement asks to prove that a permutation and its inverse have the same (cycle) type — "type" of a permutation in combinatorics (e.g., Brualdi) standardly means cycle type. The Lean theorem asserts exactly `σ.cycleType = σ⁻¹.cycleType` for an arbitrary `σ : Equiv.Perm α`. The `[Fintype α]` and `[DecidableEq α]` instances are required by Mathlib's definition of `Equiv.Perm.cycleType` (which uses `cycleFactorsFinset`), so they are necessary implicit premises rather than scope-narrowing hypotheses. The universal quantification over α and σ matches the informal claim, and Mathlib even has `Equiv.Perm.cycleType_inv` stating precisely this equality. Hence the formalization is logically equivalent to the informal statement.

### brualdi_ch14_45

**Verdict:** `faithful`

**Reasoning**

The Lean signature uses `finRotate n : Equiv.Perm (Fin n)`, which is exactly ρ_n (the rotation 1→2→...→n→1), and `Finset.Icc 1 n = {1,...,n}` matches the informal list {ρ_n, ρ_n^2, ..., ρ_n^n}. The only potential mismatch is `IsCycle` vs. "n-cycle": Mathlib's `IsCycle f` just means f is some cycle of length ≥ 2, not necessarily of length n. However, for n odd prime and i ∈ {1,...,n-1}, gcd(i,n)=1, so orderOf((finRotate n)^i) = n, and by `IsCycle.orderOf` the support equals n, making it a full n-cycle. Conversely, an n-cycle on Fin n is `IsCycle`. At i = n, (finRotate n)^n = identity, which fails `IsCycle` (by `not_isCycle_one`) and also fails "is an n-cycle" informally — both statements share this edge case. Hence the formulations are logically equivalent under the hypothesis that n is an odd prime.

### brualdi_ch1_10

**Verdict:** `faithful`

**Reasoning**

The Lean `IsMagicSquare` structure correctly captures the standard definition of a magic square: `mem` says entries lie in {1,...,n²}; `pairwise` says entries at distinct positions are distinct (combined with mem and Fin n × Fin n having exactly n² positions, this means entries are a permutation of {1,...,n²}); and `same_sum` asserts that all row sums, all column sums, the main diagonal (∑ i, M i i), and the anti-diagonal (∑ i, M i i.rev, where Fin.rev maps i ↦ n-1-i) all equal a common value s. The theorem asserts there is no 2×2 such matrix over ℕ, exactly matching "no magic square of order 2". The matrix type `Matrix (Fin 2) (Fin 2) ℕ` correctly encodes a 2×2 square, and ℕ is the natural ambient for entries in {1,...,4}. No hypotheses are added or dropped, and the conclusion matches.

### brualdi_ch1_16

**Verdict:** `faithful`

**Reasoning**

The Lean `IsMagicSquare` structure faithfully captures the standard magic square definition: entries lie in {1,...,n²} (`mem`), all distinct (`pairwise`), and the common sum s is shared by every row, every column, the main diagonal (`∑ i, M i i`), and the anti-diagonal (`∑ i, M i i.rev`, using `Fin.rev : i ↦ n-1-i`). Since n² distinct values in [1, n²] must be exactly {1,...,n²}, this matches the traditional definition. The `replace` function implements a ↦ n²+1-a as specified; with entries in [1,n²], natural subtraction causes no truncation. The theorem asserts for any matrix M that `IsMagicSquare M → IsMagicSquare (replace M)`, which is exactly the informal claim. No hypothesis is silently added or dropped, and the quantifier structure correctly ranges over all magic squares of order n.

### brualdi_ch1_5

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures "the number of perfect covers of a 3-by-4 chessboard by dominoes." `PerfectCover 3 2` uses board `Fin 3 × Fin 4` (3-by-4). A `Domino` is defined as a 2-cell Finset where the two cells are horizontally or vertically adjacent — the standard domino shape. A `PerfectCover` requires exactly `n*k = 6` distinct dominoes whose union covers all 12 cells. Although disjointness isn't stated explicitly, it is forced by counting: 6 dominoes × 2 cells = 12 cell-slots for 12 board cells, so every cell being covered forces each to be covered exactly once (disjoint tiling). The statement `Fintype.card (PerfectCover 3 2) = brualdi_ch1_5_solution` correctly asks for the count of such tilings.

### brualdi_ch2_11

**Verdict:** `faithful`

**Reasoning**

The Lean statement counts 3-element subsets of Icc 1 20 = {1, ..., 20} satisfying the filter ∀ a ∈ S, a-1 ∉ S ∧ a+1 ∉ S. This condition is logically equivalent to "no two consecutive integers in S": forward, if two consecutive elements x, x+1 existed in S, taking a = x+1 would violate a-1 ∉ S; backward, the condition is directly implied by non-consecutiveness. The natural subtraction edge cases are harmless: a ∈ S ⊆ Icc 1 20 ensures a ≥ 1 so a-1 is genuine subtraction, and a-1 = 0 or a+1 = 21 are trivially not in S. The type (ℕ), the range {1..20}, the cardinality 3, and the non-consecutive constraint all match the informal problem. This is a faithful formalization.

### brualdi_ch2_36

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the total number of sub-multisets (combinations of any size) of a multiset with k types having repetition numbers n_1,...,n_k. A sub-multiset corresponds to choosing a_i objects of type i with 0 ≤ a_i ≤ n_i. The Lean formalization encodes this precisely: `sols : Finset (Fin k → ℕ)` is characterized by the biconditional `f ∈ sols ↔ (∀ i, f i ≤ n i)`, and since `f i : ℕ` automatically ensures `0 ≤ f i`, this exactly captures the set of sub-multiset choices including the empty combination and the full multiset (i.e., "any size"). The conclusion `sols.card = brualdi_ch2_36_solution n` asks for the cardinality, which matches "determine the total number". The indexing by `Fin k` correctly reflects the k distinct types. This is a faithful formalization.

### brualdi_ch2_6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures each condition of the informal statement precisely: `n > 5400` matches "greater than 5400"; `(Nat.digits 10 n).Nodup` matches "digits are distinct" (in base 10); and `2 ∉ (Nat.digits 10 n) ∧ 7 ∉ (Nat.digits 10 n)` matches "digits 2 and 7 do not occur". Using ℕ instead of ℤ is inconsequential since any integer > 5400 is positive. Using `Finset ℕ` with the characterizing iff is appropriate because the set is finite (digits must come from {0,1,3,4,5,6,8,9} and be distinct, so at most 8 digits). The cardinality `s.card` therefore counts exactly the integers described in the informal statement.

### brualdi_ch3_18

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. `EuclideanSpace ℝ (Fin 2)` (defined as `PiLp 2 (fun _ : Fin 2 => ℝ)`) gives the standard Euclidean plane, and `dist` is the standard Euclidean distance. The square of side length 2 is encoded as the concrete axis-aligned square [0,2]×[0,2] via coordinate bounds in `h_points`; since the problem is isometry-invariant, using a specific representative square is a standard and faithful encoding. `points : Fin 5 → ...` encodes exactly 5 (possibly coincident) points. The conclusion `∃ i j, i ≠ j ∧ dist (points i) (points j) ≤ √2` correctly expresses "two [distinct] points whose distance apart is at most √2" — the closed interval and non-strict inequality both match "within" and "at most". No hypotheses are silently added or dropped, and the quantifier structure matches.

### brualdi_ch3_27

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes the informal claim. The type `Set (Set (Set.Icc 1 n))` represents a collection of subsets of {1,...,n}. The condition `∀ S ∈ subsets, ∀ T ∈ subsets, (S ∩ T).Nonempty` is the standard intersecting family condition (any two sets, possibly equal, share a common element), which is the conventional combinatorial reading. The conclusion `∃ m, m ≤ 2^(n-1) ∧ Nonempty (Fin m ≃ subsets)` is logically equivalent to saying |subsets| ≤ 2^(n-1), since the bijection with `Fin m` captures finiteness and cardinality m, and the collection is automatically finite (being a subcollection of the finite powerset of {1,...,n}). The hypothesis `n ≥ 1` is a reasonable implicit premise given the notation "{1, 2, ..., n}" — without it, ℕ-truncated subtraction makes 2^(n-1) behave oddly, though the theorem still holds trivially when n = 0.

### brualdi_ch3_4

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes the informal claim. S : Finset ℕ ensures distinctness (matching "n+1 integers chosen"), the elem_range hypothesis encodes membership in {1,...,2n}, and card = n+1 matches the count. The conclusion ∃ s ∈ S, ∃ s' ∈ S, s = s' + 1 captures "two which differ by 1": since s = s' + 1 in ℕ forces s ≠ s', the two witnesses are automatically distinct, and "one is successor of the other" is exactly what "differ by 1" means. No hypothesis is added, removed, or changed, and the quantifier structure matches.

### brualdi_ch4_59

**Verdict:** `faithful`

**Reasoning**

The hypothesis n ≥ 2 matches the informal "Let n ≥ 2". The custom `invNum σ` correctly counts inversions: `finPairsLT n` contains pairs (a,b) with b < a, and we count those where σ(a) ≤ σ(b), which (since σ is a bijection) is σ(a) < σ(b), i.e., pairs (i=b, j=a) with i < j and σ(i) > σ(j) — the standard inversion count. The summation `∑ σ : Equiv.Perm (Fin n), invNum σ` totals inversions over all n! permutations. The right-hand side `n! * n * (n-1) / 4` equals (1/2)·n!·C(n,2) = n!·n(n-1)/4 and the ℕ division is exact for n ≥ 2 (verified: n=2→1, n=3→9, n=4→72). The formalization matches the informal statement exactly.

### brualdi_ch4_9

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully formalizes the informal claim. `invNum σ` uses Mathlib's `finPairsLT n` (pairs ⟨a, b⟩ with b < a) and counts those with σ(a) ≤ σ(b); since σ is injective, this is equivalent to σ(b) > σ(a), i.e., the standard count of inversions (pairs (i, j) with i < j and σ(i) > σ(j)) after relabeling i=b, j=a. `IsGreatest {k | ∃ σ, k = invNum σ} (n*(n-1)/2)` expresses exactly that n(n-1)/2 is the maximum inversion count: it is attained by some permutation and is an upper bound. The identification of "permutations of {1,...,n}" with `Equiv.Perm (Fin n)` is the standard encoding of S_n, preserving inversion counts. Edge cases (n=0, n=1) work correctly under truncated natural subtraction.

### brualdi_ch5_26

**Verdict:** `faithful`

**Reasoning**

The Lean theorem mirrors the informal statement component-by-component: the outer "Let n, k be integers with 1 ≤ k ≤ n" matches `(n k : ℕ) (h1 : 1 ≤ k) (h2 : k ≤ n)` (with the outer k unused in the conclusion, shadowed by the bound summation index, as in the informal); the summation range k=1..n becomes `Finset.Icc 1 n`; the summand C(n,k)·C(n,k-1) matches `Nat.choose n k * Nat.choose n (k - 1)`; and the RHS (1/2)·C(2n+1, n+1) - C(2n, n) is rendered as `(1/2 : ℚ) * Nat.choose (2*n+1) (n+1) - Nat.choose (2*n) n`, with the rational cast consistent with the 1/2 factor. Note: the informal identity as literally written is actually false for n ≥ 1 (correct identity would be C(2n+1,n+1) - C(2n,n), or equivalently (1/2)·C(2n+2,n+1) - C(2n,n)) — but the Lean preserves the same literal form, including the apparent 1/2 typo. Since faithfulness judges whether the Lean captures the informal claim as stated, the formalization is faithful.

### brualdi_ch5_51

**Verdict:** `faithful`

**Reasoning**

The Lean encoding matches the informal statement. `R < S` on `Rel X X = X → X → Prop` is exactly "R ⊆ S pointwise and R ≠ S" (i.e. proper subset as sets of ordered pairs). `IsPartialOrder X R/S` matches "R and S are partial orders on X". The conclusion `∃ p q, S p q ∧ ¬R p q ∧ IsPartialOrder X (R ⊔ fun x y ↦ if x = p ∧ y = q then true else false)` asserts existence of (p,q) ∈ S \ R such that R ∪ {(p,q)} is a partial order; the inner lambda (via Bool→Prop coercion / elaboration) represents the singleton relation {(p,q)}, and `R ⊔ ...` is pointwise union, so this encodes R ∪ {(p,q)} exactly. The only extra ingredient is `[DecidableEq X]`, which is a purely technical requirement for the if-then-else elaboration and not a genuine mathematical restriction (every type admits decidable equality classically), so this is standard Mathlib practice rather than a weakening.

### brualdi_ch5_9

**Verdict:** `faithful`

**Reasoning**

The Lean statement asserts exactly what the informal problem asks: evaluate the sum $\sum_{k=0}^{n}(-1)^{k}\binom{n}{k}10^{k}$. The range `Finset.range (n+1)` gives the indices $\{0,1,\ldots,n\}$, matching the bounds $k=0$ to $n$. The summand `(-1 : ℤ) ^ k * (n.choose k) * 10 ^ k` literally matches $(-1)^k \binom{n}{k} 10^k$ in the integers. The "evaluate" task is encoded by requiring the sum to equal `brualdi_ch5_9_solution n`, a function that must be given a concrete closed-form definition — this is the standard faithful formalization of "evaluate" problems. No hypotheses are added or dropped, and the type ℤ is appropriate for the alternating-sign sum.

### brualdi_ch6_11

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal counting problem. `Equiv.Perm (Finset.Icc 1 8)` coerces via `CoeSort` to permutations of the subtype `{x // x ∈ Finset.Icc 1 8}`, which is exactly the 8-element set {1,...,8}. The hypothesis `∀ σ, σ ∈ sols ↔ (∀ i, Even i.1 → σ i ≠ i)` uniquely determines `sols` as the set of permutations such that no even-valued element is fixed (i.e., in its natural position). Since the underlying type has decidable equality and is finite, this iff uniquely determines the Finset, so `sols.card` is well-defined. The condition `σ i ≠ i` captures "not in natural position" exactly, and `Even i.1` correctly extracts the underlying ℕ and tests parity. The formulation correctly leaves odd positions unconstrained, matching the informal statement which only restricts even integers.

### brualdi_ch6_21

**Verdict:** `faithful`

**Reasoning**

The Lean statement uses `numDerangements n`, which is Mathlib's standard derangement number $D_n$ defined by the recurrence $D_0=1$, $D_1=0$, $D_{n+2}=(n+1)(D_n + D_{n+1})$ (confirmed in `Mathlib/Combinatorics/Derangements/Finite.lean`). The formalization quantifies universally over `n : ℕ` and asserts `Even (numDerangements n) ↔ Odd n`, which exactly matches the informal iff claim about parity of $D_n$ versus parity of $n$. The types, the universal quantifier (implicit via `(n : ℕ)`), and the biconditional all align with the informal reading. No hypotheses are added or dropped, and no stronger/weaker variant is introduced.

### brualdi_ch6_9

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the counting problem. Using `Fin 4 → ℕ` instead of ℤ does not change the count because all constraints have non-negative lower bounds ($x_1 \geq 1$, $x_2 \geq 0$, $x_3 \geq 4$, $x_4 \geq 2$), so integer solutions and natural-number solutions coincide. The sum `∑ i, x i = 20` matches $x_1+x_2+x_3+x_4=20$, and `x i ∈ Icc a b` unfolds via `mem_Icc` to `a ≤ x i ∧ x i ≤ b`, matching each constraint exactly. The indexing 0-3 in `Fin 4` corresponds to $x_1$ through $x_4$. Using `.ncard` equal to a `sorry` abbrev is the standard pattern for "determine the number of" problems. The formalization is logically equivalent to the informal claim.

### brualdi_ch7_15

**Verdict:** `faithful`

**Reasoning**

The informal statement asks to determine the generating function for the sequence (n³)_{n≥0}. The Lean encoding uses the standard "solution placeholder" pattern: `brualdi_ch7_15_solution` is an abbrev of type `PowerSeries ℝ` left as `sorry` to be filled with the closed form, and the theorem asserts that the power series with coefficients n³ (i.e., `PowerSeries.mk (fun n => (n : ℝ)^3)`, whose nth coefficient is n³ per Mathlib's `coeff_mk`) equals this solution. This correctly captures "find a closed-form expression equal to ∑ n³ Xⁿ." The ring ℝ is a reasonable standard choice for the coefficient ring, matching the textbook convention for such generating function problems. The formalization is faithful.

### brualdi_ch7_27

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all aspects of the informal statement. The predicate `(Nat.digits 10 m).length = n` combined with `m < 10^n` correctly characterizes n-digit base-10 numbers (Nat.digits is in little-endian with no trailing zeros, so length equals the digit count for m ≥ 1). The condition `∀ i : Fin (...).length, Odd (... .get i)` correctly encodes "all digits odd". The conjunction of `Even (count 1)`, `count 1 ≠ 0`, `Even (count 3)`, `count 3 ≠ 0` precisely matches "1 and 3 each occur a nonzero, even number of times". The cardinality being equated to `brualdi_ch7_27_solution n` (a `sorry` placeholder) is a standard formalization convention for "Determine the number of ..." problems. No hypotheses are added or dropped beyond what the informal claim requires.

### brualdi_ch7_7

**Verdict:** `faithful`

**Reasoning**

The Lean statement directly formalizes the informal claim. `m n d : ℕ+` captures "positive integers"; `hmd : d = Nat.gcd m n` (via PNat→ℕ coercion) states "d is the gcd of m and n"; the conclusion `Nat.gcd (Nat.fib m) (Nat.fib n) = Nat.fib d` says "gcd(f_m, f_n) = f_d". Mathlib's `Nat.fib` satisfies `fib 1 = 1, fib 2 = 1, fib 3 = 2, ...`, matching the standard Brualdi Fibonacci convention for positive indices. Indeed, Mathlib proves essentially this exact theorem as `Nat.fib_gcd : fib (gcd m n) = gcd (fib m) (fib n)`. There are no added/dropped hypotheses, no quantifier change, and no type mismatch—the formalization is logically equivalent to the informal statement.

### brualdi_ch8_30

**Verdict:** `faithful`

**Reasoning**

`Nat.Partition n` in Mathlib is defined as a multiset of positive integers summing to `n` (the standard notion of an integer partition), and it carries a `Fintype` instance, so `Fintype.card (Nat.Partition n)` equals the partition function p(n). The hypothesis `2 ≤ n` matches the informal "when 2 ≤ n", and the conclusion `Fintype.card (Nat.Partition (n-1)) < Fintype.card (Nat.Partition n)` is exactly `p(n-1) < p(n)`, i.e., `p(n) > p(n-1)`. Since `n ≥ 2`, the truncated `ℕ`-subtraction `n - 1` behaves as ordinary subtraction, so there is no hidden issue. The Lean statement is logically equivalent to the informal claim.

### brualdi_ch8_6

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal problem. The sum $\sum_{k=0}^{n} h_k$ is correctly represented as `∑ i ∈ Finset.range (n + 1), h i` (since `Finset.range (n+1) = {0, 1, ..., n}`). The function $h_n = 2n^2 - n + 3$ is introduced abstractly via `h : ℕ → ℝ` with the defining hypothesis `h' : ∀ i, h i = 2 * i ^ 2 - i + 3`, which is logically equivalent to defining `h` directly. Since `h` maps to ℝ, the expression `2 * i ^ 2 - i + 3` is computed in ℝ with real subtraction, avoiding any truncation issue. The universal quantification over `n` matches "find a formula" valid for all n ≥ 0. The `brualdi_ch8_6_solution` placeholder is the standard pattern for the requested formula. No hypotheses have been silently added or dropped.

### brualdi_ch8_9

**Verdict:** `faithful`

**Reasoning**

The Lean formalization uses Mathlib's `fwdDiff 1` which is defined as `fun n ↦ f (n + 1) - f n`, i.e., exactly the forward difference operator Δ with step 1. The k-th iterate `(fwdDiff 1)^[k]` corresponds to Δ^k. The RHS `∑ j ∈ Finset.range (k + 1), (-1)^(k-j) * Nat.choose k j * h (n + j)` matches the informal `∑_{j=0}^{k}(-1)^{k-j}\binom{k}{j} h_{n+j}` component-for-component: range (k+1) encodes j=0..k, the signs, binomial coefficients, and shifted sequence values all align. This also mirrors Mathlib's existing `fwdDiff_iter_eq_sum_shift` theorem. The sequence is typed as `ℕ → ℤ`, which is the standard and natural interpretation for a "sequence" in combinatorial difference calculus, and the statement is universally quantified over h, k, n as expected.

### brualdi_ch9_11

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. The hypothesis `n > 1` matches. The family A is indexed by Fin n (0-indexed), with `A i = Finset.Icc 1 n \ {i.1 + 1}` — the `+1` shift correctly maps Fin n values (0 to n-1) to the 1-indexed exclusion values (1 to n), giving a bijective relabeling of the informal A_i. The SDR structure encodes a function f : Fin n → α with f(i) ∈ A i and pairwise distinctness, which is the standard definition of a System of Distinct Representatives. The conjunction `Nonempty (SDR A) ∧ Fintype.card (SDR A) = numDerangements n` faithfully captures both "has an SDR" and "the number of SDRs equals D_n". Mathlib's `numDerangements` is verified to be the standard derangement number D_n.

### brualdi_ch9_13

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all elements of the informal statement: a matrix with m rows and n columns, entries in {1,...,k} (via `Finset.Icc 1 k`), the hypothesis that each i ∈ S occurs exactly n*r_i times in A, and the conclusion of row-wise permutations producing a matrix where each i ∈ S appears r_i times in each column (encoded via `rσ : Fin m → Equiv.Perm (Fin n)` with the count `∑ x, if A x (rσ x j) = i then 1 else 0 = r i`). The extra positivity hypotheses `hn : n > 0`, `hm : m > 0`, and `hk : k ≥ 1` make explicit the implicit premises a mathematician would assume (a meaningful matrix with a non-empty index set); excluding these degenerate cases removes only vacuously-true cases, so the statement is logically equivalent to the informal one. Using `r : ℕ → ℕ` is consistent with "r_i is an integer" since counts force r_i ≥ 0.

### brualdi_ch9_8

**Verdict:** `faithful`

**Reasoning**

The `SDR` structure matches the standard definition of a System of Distinct Representatives (a choice function with `toFun i ∈ A i` and pairwise distinctness). The family `A : Fin 6 → Finset ℕ` is defined by pattern matching on numeric literals: since `Fin 6`'s `OfNat` mod-reduces, pattern `6` matches index `0`, giving `A 0 = {6,1}, A 1 = {1,2}, ..., A 5 = {5,6}`. This is a cyclic reindexing of the informal $A_1, \ldots, A_6$, but SDR counts are invariant under permutations of the index set, so `Fintype.card (SDR A)` equals the number of SDRs of the informal family. Structure instances are equal iff their `toFun` fields agree (the two proof fields are propositionally equal), so `Fintype.card` correctly counts distinct SDRs. The "determine" question is formalized in the standard way via a placeholder `brualdi_ch9_8_solution : ℕ`. This is a faithful formalization.

### bxmo_2017_p2

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the game precisely: n = m + 2 covers all n ≥ 2; the two factory islands are fixed as F1 = 0 and F2 = 1 (WLOG by symmetry); the initial state is the empty graph; `isValidMove` requires distinct non-adjacent endpoints with at least one being reachable from F1 or F2 (and `Reachable` being reflexive covers "or has a factory itself"); `is_losing_state` correctly uses `Reachable F1 F2` to capture the F1–F2 path. The turn structure in `aliceWins` correctly has Alice moving first and alternating, with a player losing immediately if they produce an invalid move (equivalent to the convention that a player with no valid moves loses) or if their move connects F1 to F2. The solution is encoded as `ℕ → Fin 2` (0 = Alice, 1 = Bob) and the conjunction correctly asserts that the solution function identifies the winner for each n. The quantifier structure (`∃ strategyA, ∀ strategyB` and `∃ strategyB, ∀ strategyA, ¬ aliceWins`) faithfully renders "has a winning strategy" for each player.

### egmo_2022_p5

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal statement. The `Domino` structure properly defines a 2×1 domino as a 2-element Finset with adjacent cells (horizontally or vertically). The `PerfectCover` structure requires n*k dominoes covering every cell — by pigeonhole (2nk cell-incidences equaling 2nk total cells with each cell covered at least once), this forces each cell to be covered exactly once, correctly encoding a perfect tiling. The Fintype instances make `Fintype.card (PerfectCover n k)` equal to f(n, 2k). The set `{n | n > 0 ∧ ∀ k > 0, Odd (...)}` exactly matches "all positive integers n such that for every positive integer k, f(n, 2k) is odd". The board dimensions `Fin n × Fin (2 * k)` match n × 2k. No hypotheses are added or dropped beyond what's in the informal statement.

### hackmath_1

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the number of ways to select a group of 6 students from 13, which is the combination C(13, 6) = 1716. The Lean encoding represents each selection as a characteristic function f : Fin 13 → Fin 2, where the condition (List.ofFn f).count 0 = 6 means exactly 6 of the 13 positions map to 0 (the "selected" indicator). The set of such functions is in bijection with 6-element subsets of a 13-element set, so sols.card = C(13, 6), matching the intended answer. The iff in h_sols precisely characterizes sols, and the use of Finset (Fin 13 → Fin 2) with the count condition is a standard and correct encoding of k-element subsets. The word "group" in the informal statement rules out ordered arrangements, matching the unordered-selection semantics of the Lean encoding.

### hackmath_10

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the number of ways 3 people can divide 7 pears and 5 apples. The Lean encoding uses `Fin 3 → (ℕ × ℕ)` (3 distinguishable people, each assigned a pair of natural numbers representing pear count and apple count) with constraints that the pear counts sum to 7 and apple counts sum to 5. This correctly captures the standard combinatorial interpretation: distinguishable people, identical pears, identical apples, all items distributed (sums match the totals), and allowing zero items per person (standard stars-and-bars reading). The cardinality `sols.card` is then the count of such distributions. The Finset is characterized extensionally via `h_sols`, uniquely determining it as exactly the set of valid distributions. The types (ℕ), quantifier structure, and conditions all match the intended meaning, giving the expected answer of C(9,2)·C(7,2) = 756.

### hackmath_2

**Verdict:** `faithful`

**Reasoning**

The Lean encoding uses `f : Fin 8 → Fin 4` where values 0, 1, 2 represent the three rankings (1st, 2nd, 3rd) and value 3 represents "not ranked". Since `List.ofFn f` has length 8 and the hypotheses force exactly one occurrence each of 0, 1, and 2, the remaining 5 entries are forced to be 3 (the only other element of Fin 4). This correctly characterizes assignments where exactly one athlete is 1st, one is 2nd, and one is 3rd. The cardinality of this set is 8·7·6 = 336 = P(8,3), which is exactly what the informal statement asks to count. The `sols`/`h_sols` framing simply defines the set via its characteristic predicate, and the theorem asserts its cardinality equals the to-be-filled-in numeric answer. This is a faithful formalization.

### hackmath_3

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the count of 4-digit numbers formed from {3,5,8,9} without repetition (answer: 4! = 24). The Lean formalization defines `sol` as the Finset of naturals `s` with 1000 ≤ s ≤ 9999 and `(Nat.digits 10 s).toFinset = {3, 5, 8, 9}`. Since any s in [1000, 9999] has exactly 4 base-10 digits, and the Finset {3,5,8,9} has exactly 4 distinct elements, the condition `toFinset = {3,5,8,9}` forces each of 3, 5, 8, 9 to appear exactly once by pigeonhole — precisely capturing "formed from 3,5,8,9 without repetition". The cardinality equation `sol.card = hackmath_3_solution` correctly asks for the count. The encoding via a hypothesis characterizing `sol` uniquely determines the Finset, so the statement is logically equivalent to the informal claim.

### hackmath_4

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the minimum number of people needed to guarantee that at least two share a birth month (classic pigeonhole with 12 months, answer 13). The Lean formalization uses `IsLeast` on the set of n such that every function `f : Fin n → Fin 12` has two distinct inputs mapping to the same output. This precisely captures: (1) "people" as elements of `Fin n` and "months" as elements of `Fin 12`, (2) "at least two share a month" as `∃ a b, a ≠ b ∧ f a = f b`, (3) "how many must be" as the least n such that the collision is forced for all assignments. `IsLeast` unfolds to membership plus being a lower bound, which correctly encodes the minimum. The formalization is logically equivalent to the informal question.

### hackmath_5

**Verdict:** `faithful`

**Reasoning**

The informal statement asks for the probability of drawing a red marble from a box with 10 red, 6 green, and 4 blue marbles (20 total). The Lean formalization models this as `Fin 20` (20 marbles) with the uniform measure `uniformOn ⊤` (equivalent to counting measure conditioned on the universal set, giving each element probability 1/20), and asks for the measure of the event `{i | i.1 < 10}` — i.e., 10 out of 20 elements. This computes to 10/20 = 1/2, matching the answer. The specific labeling of which indices represent "red" is irrelevant to the probability, and the green/blue counts are captured implicitly as "the other 10 marbles." The quantifier structure and mathematical content faithfully reflect the informal problem.

### hackmath_7

**Verdict:** `faithful`

**Reasoning**

The Lean statement uses Mathlib's `Finpartition` (a partition into disjoint nonempty parts whose union is the whole set) of `Finset.univ : Finset (Fin 10)`, correctly representing 10 distinguishable girls. The conditions `f.parts.card = 2` (exactly two groups) and `∀ i ∈ f.parts, i.card ≥ 4` (each group has at least 4 girls) precisely match "divided into two groups with at least four girls in each group." Since `parts` is a `Finset`, the two groups are unordered — matching the standard combinatorial reading of "divide into two groups." The theorem asserts the cardinality of all such partitions equals the solution constant, which is exactly the counting problem posed. No implicit premises are altered or introduced beyond what's standard.

### hackmath_8

**Verdict:** `faithful`

**Reasoning**

The Lean encoding represents each arrangement as an assignment of 13 men and 7 women to one of 2 trips (Fin 2). It enforces (a) all women on trip 0 (first group), and (b) each trip has exactly 10 people. Given 20 total people and capacity 10 per trip, "at most 10 per trip in 2 trips" necessarily means "exactly 10 per trip", so this is the natural reading. The count then equals C(13,3) = 286, which is the standard answer to this hackmath problem. The assumptions of "2 trips" and "each trip at capacity" are the standard implicit premises needed for the problem to have a clean combinatorial answer — this is surfacing standard implicit premises rather than narrowing the claim. The men and women are treated as distinguishable, which is the conventional combinatorial reading.

### hackmath_9

**Verdict:** `faithful`

**Reasoning**

The Lean statement encodes exactly the stars-and-bars counting problem from the informal text. Each function `f : Fin 6 → ℕ` represents an assignment of ball-counts to the 6 distinguishable sons (indexed by `Fin 6`), with `f i` being the number of identical balls son i receives. The condition `∀ i, f i > 0` faithfully encodes "everyone gets at least one", and `∑ i, f i = 10` encodes that all 10 balls are distributed. The set `sols` is defined by an iff specification to be exactly the set of such distributions, and `sols.card` counts them. The treatment of sons as distinguishable (via indexing) and balls as identical (just numerical counts) matches the informal problem precisely. No hypotheses are added or omitted.

### imo_2000_p4

**Verdict:** `faithful`

**Reasoning**

The Lean formalization accurately captures IMO 2000 P4: (1) `Cards := Finset.Icc 1 100` coerces to the subtype of ℕ with values 1-100; (2) `Boxes := Fin 3` gives three boxes; (3) `Function.Surjective f` encodes "each box contains at least one card"; (4) `∃ t : ℕ → Boxes, trick_works f t` captures that the sum determines the unused box, since any such function t exists iff the unused box is uniquely determined by the sum. The three cases in `trick_works` (0,1→2), (0,2→1), (1,2→0) suffice because `∀ c₁ c₂` plus commutativity of addition covers the symmetric orderings. The `good_allocations` Finset is uniquely determined (up to equality) by the hypothesis `h`, so `good_allocations.card` is a well-defined count equal to the intended answer. The placeholder `imo_2000_p4_solution := sorry` is standard encoding for the numeric answer. Distinct-card concerns are vacuously resolved since two cards in different boxes cannot be equal. No semantic mismatch detected.

### imo_2001_p3

**Verdict:** `faithful`

**Reasoning**

The Lean formalization accurately captures the IMO 2001 P3 statement. The types (`Fin 21 → Finset ℕ`) correctly model 21 girls/boys each with their set of solved problems. The hypotheses correctly encode "at most 6 problems" (via `.card ≤ 6`) and "each girl-boy pair shares a problem" (via nonempty intersection, equivalent to `≠ ∅` for Finsets). The helper `solved_by_at_least_three` uses three existentially-quantified indices with pairwise distinctness (a≠b, b≠c, a≠c), which correctly encodes "three distinct contestants," and membership in the triple intersection correctly asserts the problem is solved by all three. The conclusion's conjunction asserts the same problem is solved by at least three girls and at least three boys, matching the informal conclusion exactly.

### imo_2001_p4

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes the informal IMO 2001 P4 statement. The index set `Finset.Icc 1 m` (subtype of ℕ) corresponds to $\{1, \ldots, m\}$, `Equiv.Perm (Finset.Icc 1 m)` is the group of permutations on these integers, and `n : Finset.Icc 1 m → ℤ` gives the integer sequence $n_1, \ldots, n_m$. The definition `f n x = ∑ i, x i * n i` computes $\sum_{i=1}^m x(i) \cdot n_i$ (with `x i` coerced from the subtype to ℤ), matching the informal $f(x) = x_1 n_1 + \cdots + x_m n_m$ where $x_i$ denotes the $i$-th component of the permutation. Both hypotheses `h_m_pos : m > 1` and `h_m_odd : Odd m` appear explicitly, and the conclusion `∃ a b, a ≠ b ∧ ↑(m!) ∣ (f n a - f n b)` precisely captures "for some distinct permutations $a, b$, $f(a) - f(b)$ is a multiple of $m!$". No hypotheses are added or dropped, and no types or quantifiers are changed.

### imo_2003_p1

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly encodes each component of the informal statement. `S := Finset.Icc 1 1000000` (on ℕ) represents {1,...,1000000}. `A : Finset S` with `A.card = 101` represents a 101-element subset of S (via the CoeSort instance giving the subtype {x // x ∈ S}). `Function.Embedding (Fin 100) S` provides exactly 100 distinct elements of S via the injection property. The set comprehension `{ a.1 + (x i).1 | a ∈ A }` correctly forms the sets {a + x_i | a ∈ A} as sets of natural numbers by extracting underlying values via `.1`. The pairwise disjointness is correctly expressed with `∀ i j, i ≠ j → Disjoint ...`. No hypotheses are silently added or dropped, and the quantifier structure matches the informal claim.

### imo_2005_p6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all components of IMO 2005 P6. The `solved` function maps each of 6 problems to the set of participants who solved it. Hypothesis `h` uses strict `>` and ordered pairs (which is equivalent to unordered pairs since intersection is symmetric) to say each pair of problems was jointly solved by more than 2/5 of participants, with proper ℝ coercion. Hypothesis `h'` correctly encodes "no contestant solved all 6 problems" as "every participant missed some problem". The conclusion states there exists a Finset `s` of contestants with `s.card ≥ 2` (at least 2 distinct contestants) and each element of `s` has a size-5 Finset `p` that exactly equals their set of solved problems — equivalent to "solved exactly 5 problems". The `∃ p, p.card = 5 ∧ ∀ j, j ∈ p ↔ i ∈ solved j` formulation is a roundabout but logically equivalent way of saying the number of problems i solved is exactly 5.

### imo_2006_p2

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures IMO 2006 P2. The `Diagonal N` type includes both sides and diagonals of the polygon, making 2*N-3 = 4009 the correct count (2006 sides + 2003 diagonals). The maximum non-crossing chord family in a convex N-gon has exactly 2N-3 elements and must include all sides, so the encoding implicitly enforces triangulation. `Good` using `Odd (a+b)` is equivalent to "both boundary arcs have odd length" precisely because N = 2006 is even (arc length |b-a| has same parity as a+b). The `Intersect` relation via SBtw₄ correctly detects chord crossing as "alternating endpoints in cyclic order". The isosceles condition checks all three pairwise arc equalities, which is equivalent to two equal chord lengths since the arcs sum to N and cannot produce sin-symmetry matches. The "two good sides" condition encoded as the disjunction of all three pairs matches "at least 2 of the 3 sides are good". Each unordered triangle is counted exactly once via the a < b < c ordering. The `IsGreatest` formulation correctly asks for the maximum over all valid dissections.

### imo_2009_p6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all hypotheses of IMO 2009 P6: distinct positive integers via `Function.Injective a` and `∀ i, a i > 0`; the set $M$ of $n-1$ positive integers via `M.card = n - 1` and `∀ m ∈ M, m > 0`; and $s \notin M$ via `haM : ∑ n, (a n) ∉ M` (the bound `n` correctly sums over `Fin n`). The conclusion `∃ σ : Equiv.Perm (Fin n), ∀ k, (∑ i ≤ k, (a ∘ σ) i) ∉ M` uses `Finset.Iic k` to capture all landing points after 1 through $n$ jumps, as $k$ ranges over `Fin n`. The starting point 0 is not a landing point and is excluded from $M$ by positivity anyway. The extra hypothesis `hn : n ≥ 1` surfaces the standard implicit premise from the notation $a_1, \ldots, a_n$ (the original IMO problem explicitly states $n$ is positive), so this is a faithful rendering rather than a weakening.

### imo_2011_p4

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly encodes IMO 2011 P4. The permutation σ : Equiv.Perm (Fin n) represents the placement order (σ j = step at which weight 2^j is placed), place_left : Fin n → Bool encodes the pan choice for each weight, and weight_of_left_pan/weight_of_right_pan correctly compute the cumulative weights on each pan after step "step" by summing 2^j.1 over weights with σ j ≤ step. The is_valid_placement predicate quantifies over step : Fin n (giving n checks, covering the state after each of the n placements from step 0 to step n-1), which correctly captures "the right pan is never heavier than the left pan". The count over pairs (σ, place_left) in valid_placements matches "the number of ways in which this can be done" — i.e., total ways to order placements AND assign pans. The imo_2011_p4_solution being `sorry` is the natural encoding of a "determine the count" problem and does not affect faithfulness of the theorem statement itself.

### imo_2013_p2

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures IMO 2013 Problem 2. The `Colombian_config` structure enforces 2013 red + 2014 blue disjoint points with no-three-collinear (the `t ≠ 0, t·(q-p) = (r-p)` condition correctly characterizes collinearity of three distinct points since the distinctness hypotheses ensure the difference vectors are non-zero). Lines are encoded as triples `(a, b, c)` representing `ax + by + c = 0` with `a ≠ 0 ∨ b ≠ 0` excluding degenerate cases. `Good_arrange` correctly captures condition (1) (no line passes through a configuration point) and condition (2) (no region contains both colors — two points are in the same region iff they have matching sign of the linear form for every line, and `Real.sign` with ±1 values when points avoid all lines correctly represents "same side"). The triple encoding doesn't change the minimum k because scalar-multiple duplicates don't affect the Good_arrange condition, so L.card = k triples give ≤ k geometric lines and the minimum matches. `IsLeast` over ℕ correctly expresses "the least value of k".

### imo_2013_p6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures each part of IMO 2013 P6. The IsBeautiful definition's six disjunctive cases precisely enumerate all 16 non-interleaving orderings (2+2+2+2+4+4) of the four positions e(a), e(b), e(c), e(d) on the circle, which is exactly the condition that the chord joining labels a,d doesn't intersect the chord joining labels b,c. M(n) = #{beautiful permutations}/(n+1) correctly counts beautiful labelings up to rotation (rotation acts freely with orbits of size n+1, and IsBeautiful is rotation-invariant since chord intersection depends only on cyclic order). N(n) counts pairs (x,y) ∈ Icc 1 n × Icc 1 n with x+y ≤ n and gcd(x,y)=1 — the Icc 1 n bounds are automatic since x+y ≤ n with y ≥ 1 forces x ≤ n-1, matching "positive integers x,y with x+y ≤ n and gcd(x,y)=1". The hypothesis n ≥ 3 and conclusion M n = N n + 1 exactly match the informal statement.

### imo_2015_p1

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures both parts of IMO 2015 P1 faithfully. The `balanced` predicate matches the informal "for any two different A, B ∈ S, ∃ C ∈ S with AC=BC". The `centre_free` predicate matches "for any three points A, B, C ∈ S, no P ∈ S has PA=PB=PC" — the added distinctness hypotheses (A ≠ B, B ≠ C, A ≠ C) are the standard reading of "three points" needed for the definition to be non-trivial (otherwise A=B=C would always violate it via P=A). Part (1) is encoded as `∀ n ≥ 3, ∃ (S : Finset ...), balanced S ∧ S.card = n`, where the Finset coerces to a Set and `S.card = n` means exactly n points. Part (2) is encoded as a set equality against `imo_2015_p1_solution`, which is the standard "determine all n such that P(n)" formalization. The plane is encoded as `EuclideanSpace ℝ (Fin 2)`, and the two subproblems are joined with `∧` as is conventional. No semantic drift detected.

### imo_2015_p6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal IMO 2015 Problem 6 statement. The sequence `a : ℕ+ → ℤ` correctly encodes integer-valued sequence indexed from 1. Condition (i) `1 ≤ a j ∧ a j ≤ 2015` for all j : ℕ+ faithfully captures "1 ≤ a_j ≤ 2015 for all j ≥ 1". Condition (ii) `∀ k l, k < l → k + a k ≠ l + a l` over ℕ+ matches "k+a_k ≠ ℓ+a_ℓ for all 1 ≤ k < ℓ" (with automatic coercion from ℕ+ to ℤ for the addition). The conclusion quantifies over positive integers `b N : ℕ+`, and the inner universal over `m n : ℕ+` is equivalent to "all integers m, n with n > m ≥ N" since m ≥ N ≥ 1 already forces positivity. The sum `Finset.Icc (m+1) n` over ℕ+ correctly represents $\sum_{j=m+1}^n$, and `|·| ≤ 1007^2` in ℤ matches the stated bound. No hypotheses have been added or dropped, and types are consistent with standard Mathlib conventions.

### imo_2016_p2

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the IMO 2016 P2 statement. The row/column conditions `n = 3 * #{j | A i j = Letters.I}` correctly express that exactly 1/3 of each row/column is each letter (forcing n divisible by 3). The diagonal conditions use the exact conditional from the informal statement: `3 ∣ #(diagonal_I_set n k) → ...`. The diagonal ranges are correctly translated from 1-indexed (i+j ∈ [2, 2n]) to 0-indexed (i+j ∈ [0, 2n-2]) using `Finset.range (2*n-1)`, and similarly for type II using `Finset.Icc (-(n:ℤ)+1) (n-1)`, giving exactly 2n-1 diagonals of each type (matching the informal 4n-2 total). The use of ℕ for n is the standard interpretation since n is a table size. The existential over matrices A : Matrix (Fin n) (Fin n) Letters correctly encodes "can be filled".

### imo_2017_p5

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes IMO 2017 P5: `height : Perm (Fin (N*(N+1)))` models N(N+1) players with distinct heights (bijection → all distinct), indexed by position in the row. `kept : Fin (2*N) ↪o Fin (N*(N+1))` is an order-preserving embedding, correctly representing the 2N remaining players in their original row order (with N(N−1) removed since 2N + N(N−1) = N(N+1)). The count `#{l | height (kept l) < height (kept i)}` is the 0-indexed height rank of the i-th kept player within the kept set. Requiring this to be even and rank(j) = rank(i)+1 enumerates exactly the N pairs (shortest & 2nd shortest), (3rd & 4th shortest), …, (2nd tallest & tallest) — equivalent to the N conditions about consecutive pairs of tallest players. The symmetric disjunction `(i<k ∧ k<j) ∨ (j<k ∧ k<i)` correctly captures "no kept player positioned between them" regardless of which of the pair appears first in the row. The statement is logically equivalent to the informal claim.

### imo_2018_p4

**Verdict:** `faithful`

**Reasoning**

The Lean formalization carefully encodes the IMO 2018 P4 game: Site = Fin 20 × Fin 20 with asPoint shifting to coordinates 1..20, valid_Amy_move requires unoccupied site and distance ≠ √5 to all existing red stones, valid_Ben_move requires only unoccupied. updateOneTurn applies Amy's move then Ben's (Amy first), and CanPlaceKRedStones a b k correctly states that k-1 complete rounds finished and Amy can make her k-th move (without requiring Ben to respond). The two clauses ∃a∀b(≥K) and ∀a∃b(¬≥K+1) correctly characterize the greatest K that Amy can guarantee. If Ben cannot move before K+1 is reached, updateGame returns None and CanPlaceKRedStones is correctly false, matching the informal "they stop as soon as a player cannot place a stone." Distance is standard Euclidean in EuclideanSpace ℝ (Fin 2), so dist = √5 captures the intended constraint. The encoding is logically equivalent to the informal claim.

### imo_2020_p3

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes IMO 2020 P3. The weight condition—stated as "weights 1, 2, ..., 4n" informally—is equivalent in Lean via three combined facts: PebbleSet has cardinality 4n, all weights lie in Finset.Icc 1 (4*n) (a set of exactly 4n values), and h_ne_weight ensures distinct pebbles have distinct weights; together these force the weights to be exactly {1, 2, ..., 4n}. The coloring condition (h_color) directly matches "four pebbles of each color" quantified over all i : Fin n. The conclusion's partition (P1 ∪ P2 = PebbleSet ∧ P1 ∩ P2 = ∅) correctly expresses "arrange into two piles", and the equal-sums plus "2 pebbles of each color in each pile" match conditions (1) and (2) exactly. No hypothesis is silently added or removed, and the quantifier structure is preserved.

### imo_2022_p1

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures IMO 2022 P1. `initial n` uses `List.permutations` on `replicate n 0 ++ replicate n 1`, which by `List.mem_permutations` gives exactly all orderings of n 0s and n 1s. `checkList` correctly identifies the longest chain containing the k-th coin (verified by tracing the AABBBABA example: returns (2,4) for the BBB chain). `action` correctly moves this chain to the front (produces [1,1,1]++[0,0]++[0,1,0] = BBBAAABA, matching the informal example). `pown k m` iterates m times, and `checkLeft n` tests whether the first n elements are all equal to L[0]. The existential `∃ m : ℕ` correctly captures "at some moment during the process". The `n > 0` hypothesis is a reasonable implicit premise. The `n = n'` clause makes the pair structure redundant but well-defined; `imo_2022_p1_solution : ℕ → Set (ℕ × ℕ)` matches the same shape. No semantic drift from the informal statement.

### imo_2024_p3

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes IMO 2024 P3 under a standard 0-indexed re-encoding, which is explicitly documented in the file's comment. Under the correspondence Lean `a i` ↔ informal $a_{i+1}$: (a) positivity `∀ i, 0 < a i` matches; (b) the Lean recursion `a n = #{i ∈ Finset.range n | a i = a (n-1)}` for Lean `n > N` is equivalent to the informal recursion for informal index $n+1 > N+1$, and since $N$ is universally quantified, Lean's range `N : ℕ` (≥0) biject with informal "positive $N$" (≥1); (c) the conclusion's `a (2*i)` and `a (2*i+1)` correspond precisely to the informal odd- and even-indexed subsequences $a_1, a_3, \ldots$ and $a_2, a_4, \ldots$; (d) `EventuallyPeriodic` matches the informal definition (the existential quantifier on $M$ makes the $M \geq 1$ vs $M \geq 0$ distinction irrelevant). The `#` notation is `Finset.card` and the filter syntax correctly counts indices where $a_i = a_{n-1}$, matching "number of times $a_{n-1}$ appears". No hypothesis or conclusion is weakened, strengthened, or substituted.

### imo_2024_p5

**Verdict:** `faithful`

**Reasoning**

The Lean statement encodes IMO 2024 Problem 5 exactly matching the official Mathlib archive formalization. With N = 2022: the board has N+2 = 2024 rows and N+1 = 2023 columns; InteriorRow N contains exactly the N = 2022 interior rows (each with one monster); MonsterData is an injection from interior rows to columns, capturing "at most one monster per column"; Path enforces starting in row 0, ending in row N+1, and moves between cells with Nat.dist sum = 1 (adjacency by side), permitting revisits; Strategy depends on prior firstMonster outcomes (modeling the "Turbo remembers" and adaptive play); WinsIn asserts some attempt returns `none` (no monster encountered, so last row reached); ForcesWinIn is universally quantified over monster placements; and IsLeast gives precisely "the minimum value of n". The encoding `(cells.getLast _).1 = N + 1` matches `Fin.last (N+1)` (same element of Fin (N+2)). All hypotheses and the conclusion faithfully match the informal claim with no weakening or strengthening.

### imosl_2011_c6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures IMO SL 2011 C6. (1) "Positive integer n" → ℕ+. (2) Periodic word over {a,b} → W : ℤ → Fin 2. (3) "Minimal period N > 2^n" → hN : 2^n.1 < N combined with hW : Function.Periodic W N and hW' : no smaller positive integer is a period — correctly captures minimality. (4) "appears": the def ∃ k, ∀ i : Fin U.1, U.2 i = W (k+i) encodes U = x_k...x_{k+|U|−1}. (5) "ubiquitous": Fin.snoc with 0/1 produces Ua, Ub; Fin.cons with 0/1 produces aU, bU; all required to appear. (6) "At least n ubiquitous finite nonempty words": encoded as an embedding Fin n ↪ (Σ k, Fin k → Fin 2) (giving n distinct elements) with constraints (x i).1 ≠ 0 (nonempty) and ubiquitous W (x i). The embedding form is logically equivalent to "there exist n distinct...", so no drift in strength.

### imosl_2015_c6

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. The `clean` definition uses `∃!` for "unique representation," `Finset ℕ+` for "distinct positive integer elements," `(S' : Set _) ⊆ S` for "from S," `Odd S'.card` for "odd number of elements," and `∑ s ∈ S', (s : ℕ) = n` for "sum equals n" — all matching the informal predicate. The conclusion `∀ N : ℕ, ∃ m : ℕ, N < m ∧ ¬ clean S m` is the standard idiomatic encoding of "there are infinitely many m with property P" — since m > N ≥ 0 implies m ≥ 1, every such m is a positive integer, matching "infinitely many positive integers that are not clean." The `hS : S.Nonempty` matches "nonempty set." The coercion `(s : ℕ)` for the sum is necessary since ℕ+ lacks an additive monoid structure; this is a standard encoding, not a semantic shift. Using `n : ℕ` vs `ℕ+` does not affect the theorem because n=0 is trivially not clean (no odd-cardinality subset of ℕ+ sums to 0) and the quantifier `N < m` guarantees m ≥ 1.

### imosl_2019_c2

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes the informal statement. The n blocks are represented as `blocks : Fin n → ℝ`, each weighing at least 1 (`h1`), with total weight 2n (`h2`, with natural coercion to ℝ). The conclusion quantifies over all real r in [0, 2n-2] and asserts the existence of a subset (as `Finset (Fin n)`) whose total weight lies in [r, r+2]. The inequalities `≥ r` and `≤ r + 2` correctly encode "at least r but at most r+2". The encoding of "subset of blocks" as `Finset (Fin n)` is standard, and both the empty subset and full subset are allowed, matching the informal reading. No hypotheses are added or dropped, quantifier structure matches, and types are appropriate.

### imosl_2021_c5

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes IMOSL 2021 C5. The bounds $n > k \geq 1$ are exactly captured by `n k : ℕ+` together with `h : k < n`. The circle of $2n+1$ students is `Fin (2*n+1)` with `finRotate` providing cyclic adjacency. Girls are encoded as 1 and boys as 0 in `ZMod 2`, with hypotheses fixing $n$ boys and $n+1$ girls. The `leftNeighbors`/`rightNeighbors` definitions produce `Fin k → ZMod 2` whose values are the genders at positions $i \pm 1, i \pm 2, \ldots, i \pm k$, which are the $2k$ closest neighbors (distinct since $2k < 2n+1$). The conclusion states ∃ i with `people i = 1` (a girl) such that the sum of 1s over both neighbor lists ≥ $k$, exactly matching "at least $k$ girls among her neighbors". The left/right labeling convention doesn't matter since both counts are summed.

### izho_2014_p3

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal statement. `Fin 100 ↪ ℕ+` represents 100 distinct positive integers. The `goodPairs` structure counts ordered pairs `(i, j)` with `s i = 2 * s j ∨ s i = 3 * s j`; by proof irrelevance on `Prop`, each such pair contributes exactly one element. Since `ℕ+` excludes 0, `i = j` is impossible, and each unordered "good pair" `{a, b}` with ratio 2 or 3 corresponds to exactly one ordered pair (the one with larger first, since `b = 2a` etc. is impossible for positive `a`). Thus `Fintype.card (goodPairs s)` equals the number of unordered good pairs as in the informal problem. `IsGreatest (Set.range ...)` correctly expresses the maximum over all possible 100-element configurations. The formalization matches the informal semantics exactly.

### izho_2019_p1

**Verdict:** `faithful`

**Reasoning**

The Lean statement uses `Nat.Partition (100!)` (via `100!.Partition` dot notation and the `open Nat` factorial notation), which by Mathlib's definition is a multiset of positive integers summing to 100! — this exactly captures "partitions where order doesn't matter and parts can repeat." The filter `∀ i ∈ p.parts, ∃ k ∈ Finset.Icc 1 99, i = Nat.factorial k` says every part equals k! for some k with 1 ≤ k ≤ 99, which precisely matches "summands from {1!, 2!, …, 99!}". The conclusion `.card ≥ 100!` matches "at least 100! ways". The positivity requirement in `Nat.Partition` is automatically satisfied since k! ≥ 1 for k ≥ 1. All quantifier structure, types, and counts align with the informal statement.

### usamo_2000_p4

**Verdict:** `faithful`

**Reasoning**

The set valid_n captures exactly: "every n-subset of the 1000×1000 grid contains three distinct points forming a right triangle with axis-parallel legs" — where a is the right-angle vertex (a.1 = b.1 gives a vertical leg to b, a.2 = c.2 gives a horizontal leg to c, and the distinctness conditions force non-degenerate legs). IsLeast valid_n k (from Mathlib) means k ∈ valid_n and k is a lower bound, matching "smallest n". Since 0, 1, 2 are trivially not in valid_n (can't select 3 distinct elements), the minimum over ℕ coincides with the smallest positive integer, so specifying the witness as ℕ+ (and using .1) does not introduce semantic divergence. The types (Fin 1000 × Fin 1000, Finset, card = n) correctly encode the chessboard and coloring. The formalization is logically equivalent to the informal statement.

## weaker (5)

### brualdi_ch10_34

**Verdict:** `weaker`

**Reasoning**

The Lean conclusion `∃ I, Nonempty (SteinerTripleSystem 2 3 (v^t) I)` is trivially satisfiable by choosing I = 0 and blocks = ∅. With I = 0, the `block_inner` condition requires only `∃ f : Fin 0 ↪ blocks, ∀ i, s ⊆ f i`, which is vacuously true (the empty function is trivially an embedding, and the universal over Fin 0 is vacuous). The hypothesis `Nonempty (SteinerTripleSystemOfIndOne 2 3 v)` forces v ≥ 1 (for carrier : Fin v), so v^t ≥ 1 and the carrier Fin (v^t) is inhabited. Thus the Lean theorem is trivially provable, whereas the informal statement asserts a substantive construction of an actual Steiner-type design on v^t varieties (a product construction from Brualdi Ch. 10). Any proof of the informal claim yields the Lean claim, but not vice versa, so the Lean formalization is strictly weaker.

### imo_2007_p3

**Verdict:** `weaker`

**Reasoning**

The informal IMO problem asks for a partition of vertices V = V₁ ⊔ V₂ such that ω(G[V₁]) = ω(G[V₂]), where each "room" carries the induced friendship subgraph inherited from G. The Lean encoding uses `∃ a : SimpleGraph.Subgraph G, a.coe.cliqueNum = aᶜ.coe.cliqueNum`. While `aᶜ.coe` (computed via the Heyting complement in the CompletelyDistribLattice of Subgraphs) is indeed the induced subgraph on V \ a.verts, `a.coe` uses `a.Adj` — which is only required to satisfy `a.Adj ≤ G.Adj` and is NOT required to equal G.Adj restricted to a.verts. Thus a can drop edges and `a.coe.cliqueNum` can be strictly less than ω(G[a.verts]). This gives extra witnesses: e.g., in K₃, take a with a.verts = {1,2} and a.Adj = ⊥, giving a.coe.cliqueNum = 1 = aᶜ.coe.cliqueNum, yet no partition of K₃ yields equal induced ω. Hence informal ⟹ Lean (take a = induced subgraph), but Lean ⇏ informal, so the Lean statement is strictly weaker.

### imo_2010_p5

**Verdict:** `weaker`

**Reasoning**

The informal statement explicitly requires that operations be applied only to non-empty boxes (both Type 1 and Type 2 say "Choose a non-empty box"). The Lean formalization encodes boxes as `ℕ` and uses truncated subtraction (`b1 - 1`), which silently permits applying an operation when the source box is empty: e.g. `op11` on `⟨0, b2, ...⟩` returns `⟨0, b2+2, ...⟩`, creating 2 coins out of nothing. Since no operation adds coins to `b1`, such invalid ops cannot be simulated by valid ones, so the Lean existential quantifies over a strictly larger set of sequences than the informal one. This means informal ∃ ⇒ Lean ∃ but not vice versa, so the Lean statement encodes a strictly weaker existential condition by dropping the explicit non-empty hypothesis that the informal statement requires.

### imo_2016_p6

**Verdict:** `weaker`

**Reasoning**

The `FrogSystem N` structure bundles both the geometric configuration (intersection points with betweenness constraints) and the direction/ordering choice (`otherSegment`) into a single object. The informal problem states a configuration is given and Geoff chooses directions. Thus part (a) — "Geoff can always fulfill his wish if n is odd" — should read "∀ configuration, ∃ direction choice, GeoffsWish". However, the Lean formalization writes part (a) as `∃ F : FrogSystem n, F.GeoffsWish`, which existentially quantifies over both configuration and direction together. This only requires exhibiting one (configuration, direction) pair per odd n, which is strictly weaker than showing that for every valid configuration there exists a direction choice that works. Part (b), `∀ F, ¬F.GeoffsWish`, correctly captures the informal "∀ configuration, ∀ direction, wish fails." Since the conjunction is weaker than the informal statement because of the mismatch in part (a), the overall formalization is weaker.

### imo_2019_p3

**Verdict:** `weaker`

**Reasoning**

The Lean statement fails to connect `users` to the initial graph of the sequence `seq`. The conclusion `∃ seq : ExpectSeq, ∀ i, ((final_state seq).neighborFinset i).card ≤ 1` merely asserts the existence of *some* valid update-sequence ending in a graph with maximum degree 1, but the `ExpectSeq` structure has no field requiring `seq.l[0].1 = users`. Thus the theorem is trivially provable by constructing a tiny ExpectSeq (e.g., a single-step sequence on some artificial graph) that ignores `users` and the degree hypothesis entirely. The informal IMO 2019/P3 problem explicitly requires the sequence of events to be applied starting from the given `users` graph with the specified degree distribution — that connection is the entire mathematical content of the problem. Since the informal claim implies the Lean claim but not vice versa, the Lean statement is strictly weaker.

## stronger (3)

### brualdi_ch11_59

**Verdict:** `stronger`

**Reasoning**

Mathlib's `IsTree G` requires `G.Connected`, which means `G.Preconnected` (every pair of vertices in V is reachable) plus `Nonempty V`. The Lean statement declares `T1 T2 : SimpleGraph V`, so `IsTree T1` forces T1 to be connected on ALL of V. When `|V| ≥ 2` (which is forced by `e ∈ T.edgeSet`), a connected graph on V must have every vertex in its support, so `T1.support = T2.support = V`. Then `Disjoint T1.support T2.support` forces `V = ∅`, contradicting `Nonempty V`. Thus the Lean statement is vacuously unprovable under its own hypotheses. The informal statement describes T\e as a forest of two trees where each tree lives on its own component's vertex set, but the Lean encoding demands each tree to span all of V — a strictly stronger (and unsatisfiable) requirement. The correct formalization would typically use subgraphs or restrict each tree to its connected component's vertex subset.

### brualdi_ch12_34

**Verdict:** `stronger`

**Reasoning**

In Mathlib, `SimpleGraph.Connected` is defined as a structure requiring both `Preconnected` and `Nonempty V` (Mathlib/Combinatorics/SimpleGraph/Connectivity/Connected.lean, lines 253-255). This means for `V = Empty`: `G.Connected` is false (fails `Nonempty`), so `¬ G.Connected` holds, but `Gᶜ.Connected` also fails (same reason), making the Lean implication false and unprovable at this edge case. The informal statement about "complement of a disconnected graph" classically presumes a non-empty graph (indeed, "disconnected" typically means "has ≥2 components," which implicitly requires V to have vertices). The Lean formalization quantifies over all `V : Type*` without a `[Nonempty V]` hypothesis, thereby claiming the result for the extra V = Empty case that the informal statement does not cover. The Lean claim logically implies the informal one (by specialization) but not conversely, matching the definition of "stronger"—it drops an implicit hypothesis needed for truth and claims the result for extra cases.

### brualdi_ch13_10

**Verdict:** `stronger`

**Reasoning**

Two issues make the Lean claim stronger than the informal one. (1) The custom `Digraph.Walk` definition has `nil` requiring `h : G.Adj u u`, so every walk in this inductive type must bottom out at a self-loop. In a tournament (`irrefl : ∀ u, ¬G.Adj u u`), there are no self-loops, so `T.Walk u x` is the empty type for all u, x. Thus `∃ p : T.Walk u x, p.IsPath ∧ p.length ≤ 2` is unsatisfiable, making the Lean statement false in every tournament, whereas the informal "king" theorem is a standard true result. (2) The informal says "for every other vertex x" (x ≠ u), but the Lean writes `∀ (x : V)`, which includes x = u — a case the informal does not claim, and which would additionally require a self-loop at u under this Walk definition. Since a false statement vacuously implies a true one but not conversely, the Lean formulation is strictly stronger than (and inconsistent with) the informal claim.

## incomparable (14)

### apmo_2023_p1

**Verdict:** `incomparable`

**Reasoning**

The predicate `touches_only_vertices s1 s2` is vacuously true for disjoint squares (the ∀ over an empty intersection is trivially satisfied) — it only fails when squares have non-vertex intersection points. Thus it means "does not interior-overlap with", not "actually shares a vertex with". Condition 1 correctly encodes the informal hypothesis. However, condition 2 counts squares S with `touches_only_vertices ⟨position m, m+1⟩ S`, which — given condition 1 and the fact that `touches_only_vertices s s` is false for nondegenerate s — forces this count to be exactly n−1 (all other squares). Requiring ncard = 2 for n ≥ 5 is therefore unsatisfiable, while the informal statement (APMO 2023 P1, count of squares sharing a vertex = 2) is satisfiable. The Lean measures a structurally different quantity (non-overlap count) than the informal (vertex-sharing count), so the two statements are not equivalent.

### brualdi_ch12_62

**Verdict:** `incomparable`

**Reasoning**

The Lean predicate `G'.coe.IsCycles` (from Mathlib.Combinatorics.SimpleGraph.Matching) means "every non-isolated vertex has exactly 2 neighbors", which describes a disjoint union of cycles (possibly with isolated vertices), NOT a single cycle as the informal statement requires. Counterexample: let G = K₃ ∪ {isolated d}. Then TwoConnected G is FALSE (not connected), and the informal RHS is also FALSE (no cycle contains the isolated d), so informal iff holds (F↔F). But Lean RHS is TRUE: for any (x,e) we can take G' = K₃ ∪ {d}, which satisfies IsCycles vacuously at d and with ncard=2 at the triangle vertices. So Lean iff is F↔T = FALSE. Letting A = "cycle through x,e" and B = "subgraph containing x,e with IsCycles", we have A → B but not B → A. Hence informal's forward direction (TwoConnected → A) is strictly stronger than Lean's forward, while Lean's backward (B → TwoConnected) is strictly stronger than informal's backward. Each iff implies only half of the other, so the claims are incomparable. The formalization needed a connectedness requirement on G'.coe (or a Walk.IsCycle-based encoding) to capture "a single cycle".

### brualdi_ch13_6

**Verdict:** `incomparable`

**Reasoning**

The Walk inductive type requires G.Adj u u (a self-loop) for its nil base case, making Walk G u u uninhabitable for any graph without self-loops. Since inductive types in Lean 4 must be well-founded, no closed walk (Walk u u) can be constructed without a self-loop somewhere in the graph. This fundamentally changes the meaning of "closed directed walk" compared to the standard definition. Many strongly connected digraphs have no self-loops, making the Lean iff statement false while the informal theorem is true.

### brualdi_ch13_9

**Verdict:** `incomparable`

**Reasoning**

The Walk inductive type requires G.Adj u u (a self-loop) for its nil base case. Combined with IsTournament requiring irreflexivity (¬ G.Adj u u for all u), Walk G u u is uninhabitable for ALL tournaments — no closed walk can exist. The RHS of the iff is therefore always False, reducing the statement to ¬StronglyConnected for all tournaments. This contradicts the known result that strongly connected tournaments have Hamiltonian cycles, making the Lean statement false while the informal theorem is true.

### brualdi_ch14_26

**Verdict:** `incomparable`

**Reasoning**

The `color` condition in `PreNecklaces` is `∃ S : Finset (Fin 7), S.card = 4 ∧ ∀ i ∈ S, c i = 0`, which asserts only that there exists some 4-element subset of positions that are all red (value 0). This is equivalent to "at least 4 red beads", not "exactly 4 red beads". For instance, the all-red sequence (7 red, 0 blue) satisfies this condition by taking S = {0,1,2,3}. The informal statement specifies necklaces with "four red and three blue beads", meaning exactly 4 red and exactly 3 blue. Computing both counts under the D_7 action via Burnside: the informal answer is 4 (counting only 4R/3B necklaces), but `Fintype.card Necklaces` as defined equals 9 (including all necklaces with ≥ 4 reds: the 4R/3B ones plus 5R/2B, 6R/1B, and 7R/0B classes). The Lean counts a strictly larger set, so the two assertions refer to different cardinalities and neither implies the other.

### brualdi_ch4_35

**Verdict:** `incomparable`

**Reasoning**

The Lean formalization uses `List.Lex (fun x1 x2 => x1 ≤ x2)` instead of the standard `List.Lex (· < ·)`. This is semantically broken: `List.Lex`'s `rel` constructor fires whenever `r a b` holds, so with `r = (· ≤ ·)` and equal heads (`a ≤ a`), the relation holds in both directions. For strictly-increasing sorted lists of the same length, `List.Lex (· ≤ ·) L M` degenerates to `L[0] ≤ M[0]`, which is not a lex order. Concrete counterexample: n=3, r=2, A_i = {0,2}, A_j = {0,1}. The premise `List.Lex (· ≤ ·) [0,2] [0,1]` holds via `rel` with `0 ≤ 0`, but the conclusion `List.Lex (· ≤ ·) [2] [1]` fails (2 ≤ 1 is false). Thus the Lean statement is FALSE as a proposition, while the informal statement is TRUE. The informal uses strict lex order on subsets; replacing `<` by `≤` inside `List.Lex` produces a genuinely different (and broken) relation — neither the premise-weakened version implies the informal, nor does the informal imply the Lean claim.

### imo_2002_p1

**Verdict:** `incomparable`

**Reasoning**

The informal statement defines a type 1 subset as having "n blue elements with different first member," which naturally describes a subset consisting of n blue elements with distinct first coordinates (matching the standard IMO 2002 C5 formulation). The Lean definition `is_type_1`, however, only checks that the image of first coordinates of blue elements has cardinality n — equivalently, that every first coordinate in Fin n is represented by at least one blue element in the subset. This allows arbitrary finsets of any size (including ones with red elements, or multiple blue elements sharing the same first coordinate). For example, with n=2 and all-blue coloring, Lean counts 3 type-1 subsets while the natural reading counts only 2 (since the full 3-element subset {(0,0),(0,1),(1,0)} does not consist of n=2 elements with distinct first coordinates). Therefore the Lean theorem asserts equality of different counts than the informal statement, and neither assertion implies the other in general.

### imo_2012_p3

**Verdict:** `incomparable`

**Reasoning**

The informal statement specifies that "among any k+1 consecutive answers, at least one answer must be truthful" (window size k+1, so Alice may lie at most k consecutive times). The Lean `AliceStrategy.IsValid` uses `∃ t ∈ Finset.Ico t₀ (t₀ + k)`, which encodes "every k consecutive answers contain a truth" (window size k, so Alice may lie at most k-1 consecutive times). This off-by-one in the window size creates a genuine semantic mismatch that is not compensated elsewhere. For part (a), at the same k the Lean's Alice is strictly more restricted than the informal's Alice, so Lean's claim "n ≥ 2^k → Bob wins" is strictly weaker than the informal claim (informal (a) → Lean (a), but not vice versa, since the Lean would need n ≥ 2^{k+1} to recover informal (a)). For part (b), the Lean's existential Alice is drawn from a strictly smaller set of valid strategies, making the claim "∃ Alice who beats Bob" strictly stronger than the informal (Lean (b) → informal (b), but not vice versa, since informal only provides an n ≥ 1.99^k against an Alice that need not be Lean-valid). Since (a) is weaker and (b) is stronger, the conjunction is incomparable to the informal statement.

### imo_2014_p2

**Verdict:** `incomparable`

**Reasoning**

The Lean statement has a typo: the conjuncts `i.val + k - 1 < n ∧ i.val + k - 1 < n` duplicate the constraint on i, with no analogous constraint on j. Since `i + m` and `j + n` are modular additions in `Fin n`, absence of a `j.val + k - 1 < n` constraint allows the "k×k square" to wrap around in the column direction — not a standard chessboard k×k square. This changes the mathematical content: the Lean set S_lean ⊋ S_inf in general. Concretely, for n=4 with rooks at (0,0),(1,2),(2,1),(3,3), there is no non-wrapping 2×2 rook-free block (so k=2 ∉ S_inf), yet the wrap-around block at (i,j)=(1,3) is rook-free. A covering argument shows that every peaceful 4×4 config has some wrap-OK 2×2 rook-free block, giving max(S_lean)=2 while max(S_inf)=⌈√4⌉−1=1. Since the Lean asserts IsGreatest of a different set from the informal, the two claims are about different quantities and neither implies the other.

### imo_2014_p6

**Verdict:** `incomparable`

**Reasoning**

The Lean conclusion `∃ B ≤ L, B.card ≥ √n ∧ ∀ S ≤ B, ∀ R, ¬finite_regions R S` is broken: taking S = ∅ (a valid Finset subset of any B), the predicate `finite_regions R ∅` only requires R to be nonempty and bounded, since the sign-equality condition quantifies vacuously over the empty set of lines. So R = {(0,0)} satisfies `finite_regions R ∅`, making `¬finite_regions R ∅` false and thus the whole conclusion false. More fundamentally, the informal statement is about finite regions of the arrangement of the full line set L whose entire boundary consists of blue lines, whereas the Lean `finite_regions R S` encodes "R is a nonempty bounded subset of a single cell of the S-arrangement", and the theorem quantifies over arbitrary Finset subsets S ≤ B and arbitrary sets R — a completely different structure. The Lean statement is provably false (for sufficiently large n, general-position configurations exist), while the informal IMO 2014 P6 claim is true; the two claims are not comparable as encodings of the same mathematical content.

### imo_2017_p3

**Verdict:** `incomparable`

**Reasoning**

The Lean formalization has multiple severe structural errors that make it not comparable to the informal claim. (1) The hunter's causal strategy is not captured: `∃ B` appears inside `∀ A`, letting the hunter see the entire rabbit path in advance, whereas IMO 2017 P3 requires an online/adaptive strategy depending only on past tracking reports. (2) The tracking device is existentially quantified `(∃ P, ...)` as a hypothesis, trivially satisfied by P = A; the informal problem requires universal quantification (the device is adversarial). (3) The outer `∀ n` combined with the implication makes the step-size hypothesis effectively `∃ n, dist(A n)(A(n+1)) = 1`, not the intended `∀ n`; this lets A(10^9) be arbitrarily far from start, making the conclusion sometimes unsatisfiable regardless of any hunter choice. (4) The starting point `fun x => if x = 0 then start 1 else start 2` is a bizarre coordinate swap (since `2 : Fin 2 = 0`). These differences create a Lean Prop that neither implies nor is implied by the IMO claim — it's a different mathematical statement altogether.

### imo_2018_p3

**Verdict:** `incomparable`

**Reasoning**

The informal statement defines an anti-Pascal triangle as one where each non-bottom entry equals the absolute value of the DIFFERENCE of the two entries below it: |a - b|. However, in the Lean `IsAntiPascal` definition, the expression is written as `abs (values A - - values B)`. In Lean 4, binary `-` has precedence 65 and unary `-` has precedence 75, so `a - -b` parses as `a - (-b) = a + b`. Thus the Lean predicate requires `values(i,j) = |values(i+1,j) + values(i+1,j+1)|` (absolute value of the SUM), not the difference. This is a different mathematical property: even the 4-row example in the informal statement (e.g., the top entry 4 = |2−6| but ≠ |2+6|=8) does not satisfy `IsAntiPascal`. Since the truth value of "does there exist a 2018-row Lean-IsAntiPascal triangle containing 1..T_2018" may differ from the original IMO question, the Lean statement is incomparable to the informal one.

### imo_2019_p5

**Verdict:** `incomparable`

**Reasoning**

The `updateMultipleTimes` definition has an off-by-one issue relative to the informal `L(C)`. Tracing for c = THT: `updateMultipleTimes THT N` yields some state for N=0,1,2,3 and only returns `none` at N=4, so `Nat.find` = 4, whereas informally L(THT) = 3. More generally, Nat.find = L(c) + 1 for L(c) > 0, and Nat.find = 0 only for the all-T configuration (L=0). Consequently, the Lean sum ∑ Nat.find(c)/2^n equals avg L + (2^n−1)/2^n, not avg L. Concrete check: for n=1, Lean gives (0+2)/2 = 1, but the true average of L is 1/2 (= n(n+1)/4). Thus the theorem is asserting `solution n` equals a different quantity than the informal "average of L(C)"; the two equalities neither imply each other.

### imo_2020_p4

**Verdict:** `incomparable`

**Reasoning**

The Lean formalization diverges from the informal statement in multiple fundamental ways. (1) The informal problem has n² stations; the Lean uses Fin n (only n stations) as station identifiers. (2) The informal requires monotonicity ("a cable car that starts higher also finishes higher"); Iscompanies only requires distinct endpoints with a<b for each individual car, allowing non-monotone configurations like (1,4),(2,3). (3) The Islinked definition has a paren-scoping bug: the List.foldl = (a,b) condition sits inside `∀ i ∈ s`, so choosing s = [] makes the ∀ vacuously true, rendering Islinked trivially true for all a,b,car_set. (4) Most critically, the informal asks for the smallest k that GUARANTEES linked stations (∀ companyA, companyB, ∃ a,b linked in both), but Condition uses ∃ companyA, companyB, turning a universal guarantee into a mere existence claim. These are entirely different questions with different answers; the Lean statement is neither logically implied by nor implies the informal statement.
