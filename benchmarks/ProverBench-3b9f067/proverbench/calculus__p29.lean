import Mathlib

/-
The integral of \(\frac{1}{x^2 + 1}\) with respect to \(x\) equals to the arctangent function \(\arctan x + C\).
-/

open Real

theorem integral_of_one_over_x_squared_plus_one (x : ℝ) :
∫ y in Set.Icc 0 x, (1 : ℝ) / (y^2 + 1) = arctan x - arctan 0 := by
  sorry
