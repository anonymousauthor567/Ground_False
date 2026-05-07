import Mathlib

open CategoryTheory Limits

variable {C : Type u} [SmallCategory C]
variable {D : Type u} [SmallCategory D]
variable (F G : C ⥤ D)

/-Informal Statement

Theorem: Let $\mathcal{C}$ and $\mathcal{D}$ be a small category and let $F,G:\mathcal{C}\to\mathcal{D}$ be two functors.
    Then we have $\mathrm{Nat}(F,G)\cong \int_{c\in\mathcal{C}}\hom_{\mathcal{D}}(F(c),G(c))$.
-/

def homIntegrandBifunctor : Cᵒᵖ × C ⥤ Type u :=
  (Functor.prod F.op G) ⋙ (Functor.hom D)


theorem natTransIsoEnd :
    Nonempty (NatTrans F G ≅ end_ (curryObj (homIntegrandBifunctor F G))) := by
  sorry
