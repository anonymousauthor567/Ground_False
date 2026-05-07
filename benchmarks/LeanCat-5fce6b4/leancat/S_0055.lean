import Mathlib

open CategoryTheory Limits

/-Informal Statement

Theorem: The forgetful functor $U$ : $\mathcal{G}\mathrm{rp}$, $\mathcal{A}\mathrm{b}$, $\mathcal{R}\mathrm{ing}\to \mathcal{S}\mathrm{et}$ creates limits, but they do not preserve coproducts.
-/

theorem forget_Grp_createsLimits_but_not_coproducts : 
    Nonempty (CreatesLimits (forget Grp.{u})) ∧ 
    ¬ Nonempty (PreservesColimitsOfShape (Discrete Bool) (forget Grp.{u})) := by
  sorry

theorem forget_Ab_createsLimits_but_not_coproducts : 
    Nonempty (CreatesLimits (forget Ab.{u})) ∧ 
    ¬ Nonempty (PreservesColimitsOfShape (Discrete Bool) (forget Ab.{u})) := by
  sorry

theorem forget_RingCat_createsLimits_but_not_coproducts : 
    Nonempty (CreatesLimits (forget RingCat.{u})) ∧ 
    ¬ Nonempty (PreservesColimitsOfShape (Discrete Bool) (forget RingCat.{u})) := by
  sorry
