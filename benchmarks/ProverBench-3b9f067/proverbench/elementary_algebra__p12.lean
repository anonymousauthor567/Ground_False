import Mathlib

/-
The result of the operation \(g(f(7,6))\) over the functions \(f(x,y)=3x^2-4y-3\) and \(g(x)=5x-5\) is 595.
-/

open Polynomial

/-- Function f as a polynomial in x with parameter y -/
noncomputable def f_poly (y : ℤ) : Polynomial ℤ := 3 * X^2 - 4 * C y - 3

/-- Function g as a polynomial -/
noncomputable def g_poly : Polynomial ℤ := 5 * X - 5

theorem function_composition_result : (g_poly.eval ((f_poly 6).eval 7)) = 595 := by
  sorry
