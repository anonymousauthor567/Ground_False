import Mathlib

/-
Let $a_n = \frac{3^n+2^n}{3^{n+1}-2^{n+1}}$ for $n \in \mathbb{N}$. Then,

  $\lim_{n\rightarrow\infty} a_n = \frac{1}{3}$
-/

open Real
open Filter (Tendsto)

variable (n : ℕ)

/-- Define `a_n`: The sequence defined by a_n = (3^n + 2^n) / (3^(n+1) - 2^(n+1)) -/
noncomputable def a_n (n : ℕ) : ℝ := (3^n + 2^n) / (3^(n+1) - 2^(n+1))

/-- Lemma 1: Rewrite a_n as (1 + (2/3)^n) / (3 * (1 - (2/3)^(n+1))) -/
lemma sequence_rewrite (n : ℕ) : a_n n = (1 + (2/3)^n) / (3 * (1 - (2/3)^(n+1))) := by
  sorry
