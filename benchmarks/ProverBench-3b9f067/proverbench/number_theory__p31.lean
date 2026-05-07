import Mathlib

/-
Prove that \(\frac{x^2+1}{y^2-5}\) is not an integer for any integers \(x, y > 2\) .
-/

theorem formal_statement (x y : ℤ) (hx : 2 < x) (hy : 2 < y) : ¬(∃ z : ℤ, (x^2 + 1) = z * (y^2 - 5)) := by
  sorry
