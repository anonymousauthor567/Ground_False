import Mathlib

/-
For all natural numbers \(x,y\) and \(z\) satisfying \(xy=z^2+1\), there exist integers \(a,b,c,d\) such that \(x=a^2+b^2\), \(y=c^2+d^2\) and \(z=ac+bd\).
-/

theorem sum_of_squares_representation (x y z : ℕ) (h : x * y = z^2 + 1) :
  ∃ (a b c d : ℤ), x = a^2 + b^2 ∧ y = c^2 + d^2 ∧ z = a * c + b * d := by
  sorry
