import Mathlib

/-
The value of \(x\) when \(2x+3y=8\) and \(5x+ 9y=-2\) is 26.
-/

variable {x y : ℚ}

theorem solution_of_system_of_linear_equations :
  (2 * x + 3 * y = 8) ∧ (5 * x + 9 * y = -2) → (x = 26 ∧ y = -44/3) := by
  sorry
