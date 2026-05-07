import Mathlib

open CategoryTheory Limits

/-Informal Statement

Theorem: Suppose $\mathcal{B}$ is locally small, complete, has a small coseparating set $S$, and has the property that every family of subobjects has an intersection. Then $\mathcal{B}$ has an initial object.
-/

theorem has_initial_of_locally_small_complete_coseparating {ℬ : Type u} [Category.{v} ℬ] 
    [LocallySmall.{w} ℬ] [HasLimitsOfSize.{w, w} ℬ] {S : Set ℬ} [Small.{w} S] 
    (hS : IsCoseparating S) (h : ∀ (A : ℬ), ∀ (s : Set (Subobject A)), ∃ (f : Subobject A), 
    IsGLB s f) : HasInitial ℬ := by
  sorry
