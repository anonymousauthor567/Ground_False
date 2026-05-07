import Mathlib

/-
Let $f: (-1, 1) \to \mathbb{R}$ be a function such that $\lim_{x \to 0} f(x) = 0$. If $f$ is differentiable at $x = 0$ with $f'(0) = m$, then $\lim_{x \to 0} \frac{f(x)}{x} = m$.
-/

open Filter Set Function
open scoped Topology

variable (f : ℝ → ℝ) (m : ℝ)

-- Define the open interval (-1, 1)
def open_unit_interval : Set ℝ := Ioo (-1) 1

-- Theorem

theorem main_theorem (hf : ContinuousOn f open_unit_interval)
  (h_lim : Tendsto f (𝓝[≠] 0) (𝓝 0))
  (h_diff : DifferentiableAt ℝ f 0)
  (h_deriv : deriv f 0 = m) :
  Tendsto (λ x => f x / x) (𝓝[≠] 0) (𝓝 m) := by
  sorry
