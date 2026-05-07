import Mathlib

/-
Let $f(x) = x^3-9x^2+24x$ be a real-valued function defined on $\mathbb{R}$. Then:
  1. $f(x)$ has a local maximum at $x=2$.
  2. $f(x)$ has a local minimum at $x=4$.
  3. These are the only local extrema of $f(x)$ on $\mathbb{R}$.
-/

open Real

variable (x : ℝ)

/-- The cubic polynomial f(x) = x³ - 9x² + 24x -/
noncomputable def f (x : ℝ) : ℝ := x^3 - 9*x^2 + 24*x

/-- The first derivative f'(x) = 3x² - 18x + 24 -/
noncomputable def f_deriv (x : ℝ) : ℝ := 3*x^2 - 18*x + 24

/-- The second derivative f''(x) = 6x - 18 -/
noncomputable def f_second_deriv (x : ℝ) : ℝ := 6*x - 18

/-- Lemma: Critical points are x = 2 and x = 4 -/
axiom critical_points : f_deriv x = 0 ↔ x = 2 ∨ x = 4

/-- Lemma: Second derivative test -/
axiom second_derivative_test (x : ℝ) (h : f_deriv x = 0) :
  (x = 2 ∧ f_second_deriv x < 0) ∨ (x = 4 ∧ f_second_deriv x > 0)

/-- Theorem: f(x) has a local maximum at x = 2 -/
theorem local_max_at_2 : IsLocalMax f 2 := by
  sorry
