import Mathlib

/-
The integral of \(\sin^3 x\cos^{6}x\,dx\) is equal to \(-\frac{\cos^7 x}{7} + \frac{\cos^9 x}{9} + C\).
-/

theorem integral_sin_cube_cos_six_power (x : ℝ) :
  ∫ (x : ℝ), Real.sin x ^ 3 * Real.cos x ^ 6 = -(Real.cos x ^ 7 / 7) + Real.cos x ^ 9 / 9 + C := by
  sorry
