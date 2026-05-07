import Mathlib

/-
The integral \[\int_{-1}^1 \frac{x^2}{1+x^2}\,dx\] is equal to \[2-\frac{\pi}2.\]
-/

open Real
open MeasureTheory

theorem integral_of_rational_function_over_interval :
∫ x in Set.Icc (-1) 1, (x^2 / (1 + x^2)) = 2 - π / 2 := by
  sorry
