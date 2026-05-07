import Mathlib

/-
The integral \(\displaystyle \int \sin^3 x\cos^{6}x\,dx\) is equal to -\frac{\cos^9x}9+\frac{\cos^{11}x}{11}+C.
-/

open Real

theorem integral_sin_cube_cos_sixth (x : ℝ) :
  ∫ (x : ℝ), sin x ^ 3 * cos x ^ 6 = -cos x ^ 9 / 9 + cos x ^ 11 / 11 + C := by
  sorry
