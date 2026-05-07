import Mathlib

open CategoryTheory Limits

/-Informal Statement

Theorem: $\mathcal{G}\mathrm{rp}$ is not an additive category.
-/

def IsAdditiveCategory (C : Type u) [Category.{v} C] : Prop :=
  ∃ (_ : Preadditive C), HasZeroObject C ∧ HasFiniteBiproducts C

theorem Grp_not_is_additive : IsEmpty (IsAdditiveCategory Grp.{u}) := by
  sorry
