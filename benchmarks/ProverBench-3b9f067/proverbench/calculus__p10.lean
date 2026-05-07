import Mathlib

/-
The integral \(\displaystyle \int \frac{1}{\sqrt{81-x^2}}\,dx\)
is equivalent to \(\arcsin\left(\frac{x}{9}\right)+C\).
-/

open Real

theorem integral_of_one_over_sqrt_eighty_one_minus_x_squared (x C : ℝ):
  ∫ x, 1 / sqrt (81 - x^2) = arcsin (x / 9) + C := by
  sorry
