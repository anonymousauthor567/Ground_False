import Mathlib

open CategoryTheory Limits Functor

variable {C : Type u₁} [Category.{v₁} C] {D : Type u₂} [Category.{v₂} D]

/-Informal Statement

Theorem: Let $\mathcal{C}$ and $\mathcal{D}$ be categories and let $F:\mathcal{C}\to \mathcal{D}$ be a fully faithful functor.
    Then $F$ reflects any limits and colimits admitted in the codomain category.
-/

theorem fully_faithful_reflects_limits_and_colimits (F : C ⥤ D) [Full F] [Faithful F] :
    ReflectsLimits F ∧ ReflectsColimits F := by
  sorry
