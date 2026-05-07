import Mathlib

/-
The real values of \(a\) for which there exists a rational function \(f(x)\) that satisfies
\(f(x^2) = f(x)^2 - a\) are \(0\) and \(2\).
-/

open Polynomial

/-- The polynomial X² -/
noncomputable def square_poly : Polynomial ℚ := X * X

/-- Main theorem characterizing values of a for which the functional equation
    f(x²) = f(x)² - a has a rational function solution -/
theorem rational_function_equation_solution (a : ℝ) :
  (∃ (f : Polynomial ℚ), ∀ x : ℚ,
    (f.eval (x * x)) = (f.eval x)^2 - a) ↔
  a = 0 ∨ a = 2 := by
  sorry
