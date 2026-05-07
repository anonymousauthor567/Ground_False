import Mathlib

/-
The integral of \(\displaystyle \frac{1}{x^2-9}\,dx\) is equal to \(\frac{1}{6}\ln\left|\frac{x-3}{x+3}\right|+C\).
-/

open Real

theorem integral_of_rational_function_with_log :
  ∀ (x : ℝ), x ≠ 3 ∧ x ≠ -3 →
  (∫ (dx : ℝ), 1 / (x^2 - 9)) = (1 / 6) * log (abs ((x - 3) / (x + 3))) + C := by
  sorry
