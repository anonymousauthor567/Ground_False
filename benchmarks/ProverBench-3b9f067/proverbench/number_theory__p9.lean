import Mathlib

/-
Prove that if `m=2+2√(28n^2+1)` is an integer for some `n∈ℕ`, then `m` is a perfect square.
-/

variable {n : ℕ}

theorem perfect_square_condition {m : ℤ} (h : m = 2 + 2 * Real.sqrt (28 * n^2 + 1))
  (h_int : ∃ k : ℤ, Real.sqrt (28 * n^2 + 1) = k) :
  ∃ k : ℤ, m = k^2 := by
  sorry
