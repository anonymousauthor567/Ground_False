import Mathlib

open CategoryTheory Limits Functor Types Function Pullback

/-Informal Statement

Theorem: Let $X,Y,Z$ be objects in $\mathcal{S}\mathrm{et}$ with morphisms $f:X\to Z$ and $g:Y\to Z$.
    Then $\{(x,y)\in X\times Y\mid f(x)=g(y)\}$ is the pullback $X\times_Z Y$ of $X$ and $Y$ over $Z$.
-/

theorem Function.isPullback_pulllback {X Y Z : Type u} (f : X → Z) (g : Y → Z) :
    IsPullback (C := Type u) (fst (f := f) (g := g)) snd f g := by
  sorry
