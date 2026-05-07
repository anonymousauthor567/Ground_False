import Mathlib

open CategoryTheory Limits

variable {C : Type u} [Category.{v} C] {D : Type u} [Category.{v} D]

/-Informal Statement

Theorem: A reflective subcategory $\mathcal{C}$ of a cocomplete category $\mathcal{D}$ is also cocomplete.
-/

theorem hasColimits_of_reflective (i : C ⥤ D) [Reflective i] [HasColimits D] :
    HasColimits C := by
  sorry
