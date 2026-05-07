import Mathlib

/-
The indefinite integral \[\int_1^5 x\ln x\,dx\] is equivalent to \[\frac{25\ln 5-12}2. \]
-/

open Real
open MeasureTheory

theorem integral_x_ln_x_over_interval :
∫ x in Set.Icc 1 5, x * log x = (25 * log 5 - 12) / 2 := by
  sorry
