import Mathlib

/-
All polynomials \(P\) satisfy the equation \(P(x)^2-2= 2P(2x^2-1)\)
 if and only if \(P(x)=a\), where \(a\) is the root of the quadratic equation \(a^2-2a-2=0\).
-/

variable {P : Polynomial ℝ }

theorem polynomial_equation_solution :
  (∀ x, P.eval x ^ 2 - 2 = 2 * P.eval (2 * x ^ 2 - 1)) ↔
  ∃ a : ℝ , a ^ 2 - 2 * a - 2 = 0 ∧ P = Polynomial.C a := by
  sorry
