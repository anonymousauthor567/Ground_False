import Mathlib

/-
The critical values of the function \( f(x) = 2x^3 - 3x^2 - 36x + 18 \) are \( x = -2 \) and \( x = 3 \).
-/

open Polynomial

/-- The cubic polynomial f(x) = 2x³ - 3x² - 36x + 18 -/
noncomputable def f_poly : Polynomial ℝ :=
  2 * X^3 - 3 * X^2 - 36 * X + 18

/-- Convert polynomial to function -/
noncomputable def f (x : ℝ) : ℝ := f_poly.eval x

/-- The derivative polynomial -/
noncomputable def f_deriv_poly : Polynomial ℝ :=
  (2 * 3) * X^2 - (3 * 2) * X - 36

/-- The derivative as a function -/
noncomputable def f_deriv (x : ℝ) : ℝ := f_deriv_poly.eval x

/-- The critical values of f(x) are x = -2 and x = 3 -/
def critical_values_of_cubic (x : ℝ) : Prop :=
  f_deriv x = 0 ↔ x = -2 ∨ x = 3

/-- Verification of the critical values -/
theorem verify_critical_values :
  ∀ x, critical_values_of_cubic x := by
  sorry
