import Mathlib
open CategoryTheory
universe u

/-Informal Statement

Theorem: The forgetful functor $U : \mathcal{A}\mathrm{b} \to \mathcal{G}\mathrm{rp}$ admits a left adjoint.
-/

theorem forget_CommGrp_to_Grp_admits_left_adjoint :
    (forget₂ CommGrp.{u} Grp.{u}).IsRightAdjoint := by
  sorry
