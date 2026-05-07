import Mathlib

/-
Let ${x_n}$ be a convergent sequence of real numbers. If $\lim_{n \to \infty}(x_n + \sin x_n) = 0$, then $\lim_{n \to \infty} x_n = 0$.
-/

open Topology Metric Filter

variable {x : ℕ → ℝ}

theorem abs_sin_le_one (x : ℝ) : |Real.sin x| ≤ 1 := by
  sorry
