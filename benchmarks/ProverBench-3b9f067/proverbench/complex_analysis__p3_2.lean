import Mathlib

/-
Let $f: \mathbb{C} \rightarrow \mathbb{C}$ be an entire function. If $|f(z)| \geq 1$ for all $z \in \mathbb{C}$, then $f$ is constant.
-/

open Complex

/-- A function f is entire if it is analytic on the entire complex plane ℂ. -/
def Entire (f : ℂ → ℂ) : Prop := AnalyticOn ℂ f Set.univ

/-- If f is an entire function such that |f(z)| ≥ 1 for all z ∈ ℂ, then g(z) = 1/f(z) is entire and |g(z)| ≤ 1. -/
axiom bounded_reciprocal_function (f : ℂ → ℂ) (hf : Entire f) (h : ∀ z, 1 ≤ abs (f z)) :
  Entire (fun z => 1 / f z) ∧ ∀ z, abs (1 / f z) ≤ 1

/-- Liouville's Theorem: Any bounded entire function must be constant. -/
lemma liouville_theorem (g : ℂ → ℂ) (hg : Entire g) (hbounded : ∃ C, ∀ z, abs (g z) ≤ C) :
  ∃ c : ℂ, ∀ z, g z = c := by
  sorry
