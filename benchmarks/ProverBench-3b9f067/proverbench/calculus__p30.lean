import Mathlib

/-
The value of \(f_y(7,1)\) for the function \(f(x,y) = xy^2 + x^2y\) is 63.
-/

-- Define the function f(x, y) = x * y^2 + x^2 * y
noncomputable def f (x y : ℤ) : ℤ := x * y^2 + x^2 * y

-- Theorem statement: The value of f(7, 1) is 56

theorem function_evaluation_example : f 7 1 = 56 := by
  sorry
