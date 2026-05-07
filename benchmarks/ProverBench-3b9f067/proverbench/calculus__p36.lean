import Mathlib

/-
The integral of \(x^p\) with respect to \(x\) where \(p\) is a real number different from -1, is given by \(\frac{x^{p+1}}{p+1} + C\).
-/

theorem integral_of_power_function (p : ℝ) (hp : p ≠ -1) :
∫ x in Set.Icc 0 1, x^p = (1^(p+1) - 0^(p+1)) / (p+1) := by
  sorry
