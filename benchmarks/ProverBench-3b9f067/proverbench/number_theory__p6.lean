import Mathlib

/-
The solutions for the equation \(x^2 - dy^2 = 1\) in the set of rational numbers, for a given integer \(d\), are \(x = \frac{dt^2 + 1}{dt^2 - 1}\) and \(y = \frac{2t}{dt^2 - 1}\) where \(t \in \mathbb{Q}\).
-/

variable (d : ℤ)

theorem rational_solutions_of_pell_equation (t : ℚ) :
  ∃ (x y : ℚ), x = (d * t^2 + 1) / (d * t^2 - 1) ∧ y = 2 * t / (d * t^2 - 1) ∧ x^2 - d * y^2 = 1 := by
  sorry
