import Mathlib

/-
The indefinite integral \(\int \frac{\sin\sqrt{x}}{\sqrt{x}}\,dx\) is equal to \(-2 \cos (\sqrt{x}) + C\).
-/

open Real

theorem sin_sqrt_x_over_sqrt_x_integral (x C: ℝ):
∫ (x : ℝ), sin (sqrt x) / sqrt x = -2 * cos (sqrt x) + C := by
  sorry
