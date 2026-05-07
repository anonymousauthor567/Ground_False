import Mathlib

/-
Prove that if \(\cos\frac pq\pi=a\) is a rational number for some \(p,q\in\mathbb{Z}\), then \(a\in\{0,\pm\frac12,\pm1\}\).
-/

open Real Rat Int

theorem cos_pi_rational_values (p q : ℤ) (h : ∃ r : ℚ, cos (p * π / q) = r) :
  ∃ r : ℚ, r ∈ ({0, 1, -1, 1/2, -1/2} : Set ℚ) ∧ cos (p * π / q) = r := by
  sorry
