import Mathlib

/-
Let ${x_n}$ be a convergent sequence of real numbers. If $\lim_{n \to \infty}(x_n + \sin x_n) = 0$, then $\lim_{n \to \infty} x_n = 0$.
-/

open Topology Metric Filter

variable {x : ℕ → ℝ}

axiom abs_sin_le_one (x : ℝ) : |Real.sin x| ≤ 1

axiom convergent_seq_bounded {x : ℕ → ℝ} (hx : ∃ L, Tendsto x atTop (𝓝 L)) :
  ∃ M, ∀ n, |x n| ≤ M

theorem convergent_sum_sin_zero (hx : ∃ L, Tendsto x atTop (𝓝 L))
(h : Tendsto (λ n => x n + Real.sin (x n)) atTop (𝓝 0)) :
  Tendsto x atTop (𝓝 0) := by
  sorry
