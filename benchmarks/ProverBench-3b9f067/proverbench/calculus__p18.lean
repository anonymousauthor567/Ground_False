import Mathlib

/-
The integral of the function (1/x + x^2) with respect to x from 2 to 8 equals the natural logarithm of 4 plus 168.
-/

open Real

theorem integral_of_function_equals_ln_plus_168 :
(∫ x in Set.Icc 2 8, (1 / x + x^2) : ℝ) = Real.log 4 + 168 := by
  sorry
