import Mathlib

/-
The series $\sum_{n=1}^{\infty} \frac{n}{n^{2}+1}$ is divergent.
-/

open Real NNReal

-- Define a comparison series that is known to diverge
noncomputable def comparison_series (n : ℕ+) : ℝ≥0 := 1 / (2 * n)

-- Define `general_term`: The general term of the series
noncomputable def general_term (n : ℕ+) : ℝ≥0 := (n : ℝ≥0) / ((n : ℝ≥0)^2 + 1)

-- Lemma: For all n ≥ 1, general_term n ≤ comparison_series n

lemma upper_bound (n : ℕ+) : general_term n ≤ comparison_series n := by
  sorry
