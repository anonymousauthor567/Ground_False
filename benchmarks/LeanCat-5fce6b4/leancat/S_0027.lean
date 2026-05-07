import Mathlib

open CategoryTheory

/-Informal Statement

Theorem: Let $(\mathbb{Z},\leq)$ be a poset, regarded as a category, then $f\in \mathrm{End}(\mathbb{Z})$ has left adjoint if and only if it has a right adjoint.
-/

theorem int_endofunctor_hasLeftAdjoint_iff_hasRightAdjoint (f : ℤ ⥤ ℤ) :
    f.IsRightAdjoint ↔ f.IsLeftAdjoint := by
  sorry
