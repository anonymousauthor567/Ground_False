import Mathlib

/-
The integral of \(\int_0^a \sqrt{a^2-x^2} \,dx\) is \(\frac{a^2 \pi}{4}\).
-/

open Real

variable {a : ℝ} (ha : 0 < a)

theorem integral_sqrt_a2_minus_x2_eq_a2_pi_div_4 :
∫ x in Set.Icc 0 a, sqrt (a^2 - x^2) = a^2 * π / 4 := by
  sorry
