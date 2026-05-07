import Mathlib

/-
Let $F$ be a field and $f(x) \in F[x]$ be a non-constant polynomial. Then there exists an extension field $E$ of $F$ and an element $\alpha \in E$ such that $f(\alpha) = 0$.
-/

open Polynomial

variable {F : Type*} [Field F]

/-- For any non-constant polynomial f(x) ∈ F[x], there exists an extension field E of F and an element α ∈ E such that f(α) = 0. -/
theorem extension_field_zero (f : F[X]) (hf : f.degree > 0) :
∃ (E : Type*) (_ : Field E) (i : F →+* E) (α : E), eval₂ i α f = 0 := by
  sorry
