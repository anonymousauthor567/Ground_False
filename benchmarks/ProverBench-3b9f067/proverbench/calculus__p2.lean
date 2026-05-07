import Mathlib

/-
The integral of \(\displaystyle \int_0^1\frac{8x^2 +6x +5}{x^2 +2x+2 }\,dx\) is equal to \(-5\ln\frac52 - \left(\tan^{-1}2-\frac{\pi}4\right)+8\).
-/

open Real

theorem integral_of_rational_function_eq_given_value :
  let f := fun x => (8 * x^2 + 6 * x + 5) / (x^2 + 2 * x + 2);
  ∫ x in Set.Icc 0 1, f x = -5 * log (5 / 2) - (arctan 2 - π / 4) + 8 := by
  sorry
