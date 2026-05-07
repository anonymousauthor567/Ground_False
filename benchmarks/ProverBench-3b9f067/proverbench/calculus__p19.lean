import Mathlib

/-
The integral \[ \int_{0}^{\frac{\pi}{2}} \ln{(\sin{x})} \,dx \] is equal to -\frac{\pi}{2} \ln{2}.
-/

open Real

variable (x : ℝ)

theorem integral_ln_sin_pi_over_two :
∫ x in Set.Icc 0 (π / 2), log (sin x) = - (π / 2) * log 2 := by
  sorry
