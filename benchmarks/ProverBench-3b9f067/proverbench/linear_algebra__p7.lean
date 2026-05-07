import Mathlib

/-
Let $\boldsymbol{\alpha}_{1}$ and $\boldsymbol{\alpha}_{2}$ be two non-zero vectors in a vector space $V$.
If $\boldsymbol{\alpha}_{1}$ and $\boldsymbol{\alpha}_{2}$ are linearly dependent, then there exists a scalar
$k \in \mathbb{R}$, $k \neq 0$, such that $\boldsymbol{\alpha}_{2} = k\boldsymbol{\alpha}_{1}$.
-/

open Classical

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- Two vectors are linearly dependent if there exist scalars, not both zero,
    such that their linear combination is zero. -/
def linearly_dependent (α₁ α₂ : V) : Prop :=
∃ (c₁ c₂ : ℝ), (c₁ ≠ 0 ∨ c₂ ≠ 0) ∧ c₁ • α₁ + c₂ • α₂ = 0

theorem linear_dependence_implies_proportional (α₁ α₂ : V) (h : linearly_dependent α₁ α₂) :
∃ (k : ℝ), k ≠ 0 ∧ (α₂ = k • α₁ ∨ (α₁ = 0 ∧ α₂ = 0)) := by
  sorry
