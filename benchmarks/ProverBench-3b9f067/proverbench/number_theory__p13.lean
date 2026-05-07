import Mathlib

/-
All odd divisors of the number \(5x^2+1\) are congruent to \(1,3,7\) or \(9\) modulo \(20\), indicating they have an even tens digit.
-/

theorem odd_divisors_of_polynomial_congruence_mod_20 (d x : ℤ) (hd : d ∣ 5 * x^2 + 1) (h_odd : Odd d) :
  d % 20 = 1 ∨ d % 20 = 3 ∨ d % 20 = 7 ∨ d % 20 = 9 := by
  sorry
