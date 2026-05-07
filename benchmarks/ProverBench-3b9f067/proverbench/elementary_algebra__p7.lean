import Mathlib

/-
If \(f(x,y)=3x-2y\), \(g(x,y)=4x+5y\), and \(h(x,y)=x\cdot y\), \[f\left( g(5,7), h(4,5)\right).\] is 125
-/

open Polynomial

noncomputable def g_at_7 : Polynomial ℤ := 4 * X + 5 * C (7 : ℤ)

noncomputable def h_at_5 : Polynomial ℤ := X * C (5 : ℤ)

noncomputable def f_at (x y : ℤ) : ℤ := 3 * x - 2 * y

theorem function_composition_example :
    f_at (g_at_7.eval (5 : ℤ)) (h_at_5.eval (4 : ℤ)) = 125 := by
  sorry
