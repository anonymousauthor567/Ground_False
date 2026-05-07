import Mathlib

/-
For every prime number \( p \), there exist integers \( a \) and \( b \) such that \( a^2 + b^2 + 1 \) is a multiple of \( p \).
-/

theorem exists_ab_mod_p (p : ℕ) (hp : Nat.Prime p) :
  ∃ (a b : ℤ), (a^2 + b^2 + 1) % p = 0 := by
  sorry
