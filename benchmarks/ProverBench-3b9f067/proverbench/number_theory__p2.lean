import Mathlib

/-
For the equation \(x^2+y^2-1=4xy\) its general solution in the integers is given by \(x+u\sqrt3=(2+\sqrt3)^n\), where \(u\) is the substitute for \(y-2x\).
-/

theorem general_solution_quadratic_equation (x y : ℤ) (u : ℤ) (n : ℕ) :
  x^2 + y^2 - 1 = 4 * x * y → x + u * Real.sqrt 3 = (2 + Real.sqrt 3)^n := by
  sorry
