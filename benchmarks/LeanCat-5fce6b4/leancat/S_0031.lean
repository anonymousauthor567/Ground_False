import Mathlib

open CategoryTheory

/-Informal Statement

Theorem: Neither the category $\mathcal{S}\mathrm{et}$ of sets nor the category $\mathcal{T}\mathrm{op}$ of topological spaces has a proper isomorphism-closed full subcategory that is both reflective and coreflective.
-/

theorem not_reflective_and_coreflective (P : ObjectProperty (Type u))
    (h : P.IsClosedUnderIsomorphisms) (hproper : ∃ X : Type u, ¬ P X) :
    IsEmpty (Reflective P.ι) ∨ IsEmpty (Coreflective P.ι) := by
  sorry
