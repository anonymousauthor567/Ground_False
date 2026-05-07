import Mathlib

/-
The equation \(x^2-py^2=-1\) has integral solutions if and only if \(p=2\) or \(p\equiv 1\) (mod 4) for any prime \(p\).
-/

variable {p : ℕ} (hp : Nat.Prime p)

theorem integral_solutions_of_x2_minus_py2_eq_minus_1 :
  (∃ (x y : ℤ), x^2 - p * y^2 = -1) ↔ p = 2 ∨ p % 4 = 1 := by
  sorry
