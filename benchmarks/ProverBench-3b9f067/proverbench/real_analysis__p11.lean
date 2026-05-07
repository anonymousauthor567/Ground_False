import Mathlib

/-
Let $f: (a,b) \rightarrow \mathbb{R}$ be a function differentiable on the open interval $(a,b)$. For any two points $x_1, x_2 \in (a,b)$, there exists a point $\xi$ between $x_1$ and $x_2$ such that $f(x_1) - f(x_2) = (x_1 - x_2)f'(\xi)$.
-/

open Set

variable {a b : ℝ} {f : ℝ → ℝ}

/-- Theorem: If `f` is differentiable on `(a, b)`, then for any `x₁, x₂ ∈ (a, b)`, there exists `ξ` between `x₁` and `x₂` such that `f(x₁) - f(x₂) = (x₁ - x₂) f'(ξ)`. -/
theorem mean_value_theorem_for_differences (hf : DifferentiableOn ℝ f (Ioo a b))
  {x₁ x₂ : ℝ} (hx₁ : x₁ ∈ Ioo a b) (hx₂ : x₂ ∈ Ioo a b) :
  ∃ ξ ∈ Ioo (min x₁ x₂) (max x₁ x₂), f x₁ - f x₂ = (x₁ - x₂) * deriv f ξ := by
  sorry
