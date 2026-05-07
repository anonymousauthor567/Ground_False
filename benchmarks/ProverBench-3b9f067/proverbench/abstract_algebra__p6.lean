import Mathlib

/-
The only polynomials P(x) that satisfy the equation \(P(x)^2 - 2 = 2P(2x^2 - 1)\) are
\(P(x) = 1 + \sqrt{3}\) or \(P(x) = 1 - \sqrt{3}\).
-/

open Polynomial

variable {P : Polynomial ℝ}

theorem polynomial_solution_unique (h : P^2 - C 2 = C 2 * eval₂ C (2 * X^2 - C 1) P) :
  P = C (1 + Real.sqrt 3) ∨ P = C (1 - Real.sqrt 3) := by
  sorry
