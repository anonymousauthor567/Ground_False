import Mathlib

/-
The integral \[\int_0^{\frac{\pi}2} x\sin x\,dx.\] is equal to 1.
-/

open Real Set Filter

variable {f : ℝ → ℝ}

theorem integral_x_sin_x_pi_over_2 :
∫ x in Icc 0 (π / 2), x * sin x = 1 := by
  sorry
