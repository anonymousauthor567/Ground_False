import Mathlib

/-
Prove that if the difference of two consecutive cubes is \(n^2\), \(n\in\mathbb{N}\),
then \(2n-1\) is a square.
-/

variable (n : ℕ)

theorem consecutive_cubes_difference_implies_square :
  ( (n + 1) ^ 3 - n ^ 3 = n ^ 2 ) → ∃ k : ℕ, k ^ 2 = 2 * n - 1 := by
  sorry
