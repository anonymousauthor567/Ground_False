import Mathlib

/-
The coefficient of \(X^4\) in the expansion of the polynomial \(P(X) = \left(1 + X + X^2 + \cdots + X^{100}\right)^3\) is 15.
-/

open Polynomial BigOperators

variable {R : Type*} [Semiring R]

theorem coefficient_of_X4_in_polynomial_expansion :
  coeff ((∑ i in Finset.range 101, X ^ i) ^ 3) 4 = 15 := by
  sorry
