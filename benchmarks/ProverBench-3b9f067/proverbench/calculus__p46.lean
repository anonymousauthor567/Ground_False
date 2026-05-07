import Mathlib

/-
The evaluated integral of \(\displaystyle \int \sqrt{x -5}\,dx\) is \(\frac{2}{3} (x - 5)^{3/2} + C\).
-/

-- Define the theorem statement

theorem integral_sqrt_x_minus_5 (x : ℝ) :
  ∫ (x : ℝ), Real.sqrt (x - 5) = (2 / 3) * (x - 5) ^ (3 / 2) + C := by
  sorry
