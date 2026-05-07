import Mathlib

open CategoryTheory

/-Informal Statement

Theorem: There is no equivalence of categories between $\mathcal{S}\mathrm{et}$ and $\mathcal{S}\mathrm{et}^{op}$.
-/

theorem no_equiv_between_Set_and_op : ¬ Nonempty (Equivalence (Type u) (Type u)ᵒᵖ) := by
  sorry
