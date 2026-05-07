import Mathlib

/-
For all real numbers x, the cosine function cos(x) can be expressed as the following infinite series:

    $\cos(x) = \sum_{n=0}^{\infty} \frac{(-1)^n}{(2n)!} x^{2n}$

    where this series converges for all x in the interval (-∞, +∞).
-/

open Real

variable (x : ℝ)

/-- The Taylor series expansion of cos(x) -/
noncomputable def cos_taylor_series (x : ℝ) : ℝ := ∑' (n : ℕ), ((-1 : ℝ)^n / (2 * n).factorial) * x^(2 * n)

/-- Proof that the Taylor series of cos(x) converges for all real numbers x -/
lemma cos_taylor_series_converges (x : ℝ) : HasSum (λ n : ℕ => ((-1 : ℝ)^n / (2 * n).factorial) * x^(2 * n)) (cos x) := by
  sorry
