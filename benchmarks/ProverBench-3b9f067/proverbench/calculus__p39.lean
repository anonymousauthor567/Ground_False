import Mathlib

/-
The integral \(\displaystyle \int \sin^{10}x\cos x \,dx\) is equal to
\(\frac{\sin^{11} x}{11} + C\), where C is the constant of integration.
-/

open Real

theorem integral_sin_pow_ten_cos (x C: ℝ) :
∫ x , (sin x)^10 * cos x = (sin x)^11 / 11 +C := by
  sorry
