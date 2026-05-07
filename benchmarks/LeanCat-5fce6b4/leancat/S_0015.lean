import Mathlib

open CategoryTheory

namespace CAT_statement_S_0015

universe u uX

variable {X : Type uX} [Category.{vX} X]

namespace AHS

structure ConcreteCat (X : Type v) [Category X] where
  C : Type u
  [cat : Category C]
  U : C ⥤ X
  [U_Faithful : U.Faithful]

attribute [instance] ConcreteCat.cat ConcreteCat.U_Faithful

/-Informal Statement

Def: Let $(\mathcal C,U)$ be a concrete category over $\mathcal B$. 
A morphism $f: x\to y$ in $\mathcal C$ is called $\textbf{initial}$ if for any object $c\in \mathcal C$, a morphism $g:U(c)\to U(x)$ is a morphism in $\mathcal{C}$ whenever $f\circ g: U(c)\to U(y)$ is a morphism in $\mathcal C$.

Def: An initial morphism $f:x\to y$ such that the underlying morphism $U(f):U(x)\to U(y)$ is monic is called an $\textbf{embedding}$.

Def: In a concrete category an object $I$ is called $\textbf{injective}$ provided that for any embedding $m: A \to B$ and any morphism $f: A\to C$ there exists a morphism $g:B\to C$ extending $f$, i.e., $g\circ m=f$


Theorem: In $\mathcal{L}\mathrm{at}_{\land}$, the category of meet semilattice and meet preserving maps, injective objects are frames.
-/

def IsInitialHom {C : ConcreteCat (X:= X)} {A B : C.C} (f : A ⟶ B) : Prop :=
  ∀ ⦃Z : C.C⦄ (g : C.U.obj Z ⟶ C.U.obj A),
    (∃ h : Z ⟶ B, C.U.map h = g ≫ C.U.map f) →
      (∃ k : Z ⟶ A, C.U.map k = g)


def IsEmbedding {C : ConcreteCat (X:= X)} {A B : C.C} (f : A ⟶ B) : Prop :=
  IsInitialHom f ∧ Mono (C.U.map f)


def IsInjectiveObj {C : ConcreteCat (X:= X)} (I : C.C) : Prop :=
  ∀ ⦃A B : C.C⦄ (m : A ⟶ B),
    IsEmbedding  m →
    ∀ (f : A ⟶ I), ∃ g : B ⟶ I, m ≫ g = f

end AHS

namespace SemilatInfCat


def forget : SemilatInfCat.{u} ⥤ Type u where
  obj A := A
  map {A B} f := f


instance : forget.Faithful  where
  map_injective {A B} f g h := by
    ext x
    simpa using congrArg (fun k => k x) h

def SemilatInfCatConcrete : AHS.ConcreteCat (X := Type u) :=
{ C := SemilatInfCat.{u}
  U := forget }


class IsFrameObj (P : SemilatInfCat.{u}) (sSup : Set P.X → P.X) (sInf : Set P.X → P.X): Prop where
  exists_sSup :
      (∀ (s : Set P.X), IsLUB s (sSup s))
  exists_sInf :
      (∀ (s : Set P.X), IsGLB s (sInf s))
  distributive :
      (∀ (a : P.X), ∀ (s : Set P.X),
        a ⊓ sSup s = sSup (Set.image (fun (b : P.X) => a ⊓ b) s))


theorem AHS_injective_iff_frameObj (P : SemilatInfCat) :
    AHS.IsInjectiveObj (C := SemilatInfCatConcrete) P ↔ ∃ (sSup : Set P.X → P.X) (sInf : Set P.X → P.X), IsFrameObj P sSup sInf := by
  sorry

end SemilatInfCat

end CAT_statement_S_0015
