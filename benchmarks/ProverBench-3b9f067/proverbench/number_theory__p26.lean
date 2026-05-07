import Mathlib

/-
For any real number \(\alpha\), there exist infinitely many pairs of positive integers \((p, q)\) such that \(\left|\alpha - \frac{p}{q}\right| < \frac{1}{q^2}\)
-/

theorem infinitely_many_positive_integer_pairs_for_real_approximation (α : ℝ) :
  ∃ (p q : ℕ) (h : q > 0), ∀ (n : ℕ), n > 0 → ∃ (p_n q_n : ℕ) (h_n : q_n > 0),
  |α - (p_n : ℝ) / q_n| < 1 / q_n^2 := by
  sorry
