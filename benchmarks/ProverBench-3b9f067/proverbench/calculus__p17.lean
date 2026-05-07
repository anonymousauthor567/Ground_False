import Mathlib

/-
The integral \(\int \frac{1}{\cos^2 x} \, dx\) equals to \(\tan x + C\).
-/

-- Define the constant C for the integration constant
variable (C : ℝ)

-- Theorem: The indefinite integral of 1/cos^2(x) with respect to x is tan(x) + C.

theorem integral_of_one_over_cos_sq (x : ℝ) :
∫ (x : ℝ), 1 / (Real.cos x ^ 2) = Real.tan x + C := by
  sorry
