import Mathlib

/-
Let $f$ be a function defined by $f(x)=\frac{\sqrt{-1-x}}{\log _{\frac{1}{2}}(x)}$. Then the domain of $f$ is the empty set, i.e., $\text{Dom}(f) = \emptyset$.
-/

open Real Set

/-- The function f(x) = √(-1-x) / log₁/₂(x) -/
noncomputable def f (x : ℝ) : ℝ :=
sqrt (-1 - x) / logb (1/2) x

/-- The domain of f is empty -/
def Dom : Set ℝ := {x | -1 - x ≥ 0 ∧ x > 0}

theorem f_domain_empty : Dom = ∅ := by
  sorry
