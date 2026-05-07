import Mathlib

open CategoryTheory

variable {C : Type*} [Category.{v} C]

/-Informal Statement

Theorem: Let $\mathcal{C}$ be a category and $\mathrm{Id}_{\mathcal{C}}$ the identity functor. Then monoid of natural transformations $\mathrm{End}(\mathrm{Id}_{\mathcal{C}})$ is commutative.
-/

theorem id_comm (α β : (𝟭 C) ⟶ (𝟭 C)) : α ≫ β = β ≫ α := by
  sorry
