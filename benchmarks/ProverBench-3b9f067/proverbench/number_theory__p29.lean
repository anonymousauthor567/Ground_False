import Mathlib

/-
For a given integer \(d\) and \(x \neq 1\), \(x^2-dy^2=1\) in the set of rational numbers* is equivalent to having \(x=\frac{dt^2+1}{dt^2-1}\) and \(y=\frac{2t}{dt^2-1}\) for \(\frac y{x-1}=t\in\mathbb{Q}\).
-/

variable (d : ℤ) (x y : ℚ)

theorem rational_solution_equivalence (h : x ≠ 1) :
  (x^2 - d * y^2 = 1) ↔ ∃ t : ℚ, x = (d * t^2 + 1) / (d * t^2 - 1) ∧ y = 2 * t / (d * t^2 - 1) := by
  sorry
