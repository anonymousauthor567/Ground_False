import Mathlib

open CategoryTheory

universe u

/-Informal Statement

Theorem: Let $\{*\}\in\mathcal{S}\mathrm{et}$ be the terminal object in $\mathcal{S}\mathrm{et}$.Then $\hom_{\mathcal{S}\mathrm{et}}(\{*\},-):\mathcal{S}\mathrm{et}\to\mathcal{S}\mathrm{et}$ is an equivalence of categories.
-/

def fromTerminalFunctor : Type u ⥤ Type u where
  obj α := PUnit.{u} → α
  map {α β} (f : α → β) := fun g => f ∘ g
  map_id := by
    intro α
    funext g x
    rfl
  map_comp := by
    intro α β γ f g
    funext h x
    rfl


theorem fromTerminalEquivalence : fromTerminalFunctor.IsEquivalence := sorry
