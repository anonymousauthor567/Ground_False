import Mathlib

/-
The only polynomials \(P\) for which \(P(x)^2-1= 4P(x^2-4x+1)\) are the constant polynomials \(P(x) = 2 + \sqrt{5}\) and \(P(x) = 2 - \sqrt{5}\).
-/

open Polynomial

variable {P : Polynomial ℝ}

theorem unique_constant_solutions (h : ∀ x, P.eval x ^ 2 - 1 = 4 * P.eval (x ^ 2 - 4 * x + 1)) :
  P = C (2 + Real.sqrt 5) ∨ P = C (2 - Real.sqrt 5) := by
  sorry
