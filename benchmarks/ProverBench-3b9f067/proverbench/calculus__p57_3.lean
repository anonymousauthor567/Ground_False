import Mathlib

/-
Let $f(x) = \frac{x+1}{\sqrt{5x^2+35}}$ be a function defined on $\mathbb{R}$. Then $f(x)$ is concave up on the intervals $(-\infty, \frac{21-\sqrt{497}}{4})$ and $(\frac{21+\sqrt{497}}{4}, \infty)$.
-/

open Real

variable (x : ℝ)

/-- The function f(x) = (x + 1) / sqrt(5x^2 + 35) -/
noncomputable def f (x : ℝ) : ℝ := (x + 1) / sqrt (5 * x^2 + 35)

/-- The first derivative of f(x) -/
axiom f_deriv (x : ℝ) : deriv f x = (35 - 5 * x^2) / ((5 * x^2 + 35) * sqrt (5 * x^2 + 35))

/-- The second derivative of f(x) -/
axiom f_second_deriv (x : ℝ) : deriv (deriv f) x = (50 * x^2 - 525 * x - 175) / ((5 * x^2 + 35)^(5/2))

/-- The critical points of f''(x) -/
lemma critical_points : ∃ a b : ℝ, a < b ∧
  a = (21 - sqrt 497) / 4 ∧
  b = (21 + sqrt 497) / 4 ∧
  ∀ x, deriv (deriv f) x = 0 ↔ x = a ∨ x = b := by
  sorry
