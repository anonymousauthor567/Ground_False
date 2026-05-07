import Mathlib

open CategoryTheory

/-Informal Statement

Theorem: Let $(-)^{\times}: \mathcal{R}\mathrm{ing} \to \mathcal{G}\mathrm{rp}$ mapping a ring to its group of units. Then it admits a left adjoint.
-/

def RingCat.units : RingCat.{u} ⥤ Grp.{u} where
  obj R := .of Rˣ
  map f := Grp.ofHom (Units.map f.hom)

theorem exists_leftAdjoint_unitFunctor :
    ∃ (left : Grp.{u} ⥤ RingCat.{u}), Nonempty (left ⊣ RingCat.units.{u}) := by
    sorry
