import Mathlib

/-
The integral of \(\displaystyle \int_0^{\frac{\pi}4}\frac{ 3\sin x +2 \cos x}{ 4\sin x+ 3\cos x} \,dx\) is equal to \(\frac{1}{50} \ln 2 -\frac{1}{25} \ln \frac{7}{3} + \frac{9\pi}{50}\).
-/

open Real

variable (x : ℝ)

theorem integral_of_trig_rational_function :
∫ x in Set.Icc 0 (π / 4), (3 * sin x + 2 * cos x) / (4 * sin x + 3 * cos x) =
    (1 / 50) * log 2 - (1 / 25) * log (7 / 3) + (9 * π) / 50 := by
  sorry
