import Lake
open Lake DSL

package ProofNetVerified

@[default_target]
lean_lib ProofNetVerified

lean_lib BridgeSandbox where
  srcDir := "equivalence_sandbox"
  roots := #[`BridgeSandbox]

lean_lib EquivCheck where
  srcDir := "equivCheck"
  roots := #[`EquivCheck]

lean_lib Proofnet1Whitelist where
  srcDir := "equivCheck"
  roots := #[`Proofnet1Whitelist]

lean_lib NatAddWhitelist where
  srcDir := "equivCheck"
  roots := #[`NatAddWhitelist]

lean_lib Proofnet1Positive where
  srcDir := "equivCheck"
  roots := #[`Proofnet1Positive]

lean_lib Proofnet1Negative where
  srcDir := "equivCheck"
  roots := #[`Proofnet1Negative]

lean_lib NatAddTests where
  srcDir := "equivCheck"
  roots := #[`NatAddTests]


require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.28.0"

require Canonical from git
  "https://github.com/chasenorman/CanonicalLean.git" @ "v4.28.0"

require smt from git
  "https://github.com/ufmg-smite/lean-smt.git" @ "f58d19d5d0803fcccb5ccb1b4473774dd2ae9f9a"  -- The commit corresponds to v4.28.0
