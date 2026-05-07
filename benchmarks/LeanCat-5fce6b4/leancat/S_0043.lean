import Mathlib

open CategoryTheory Function Classical

/-Informal Statement

Theorem: The one point set $\{*\}$ form a separator in Set, and the two point set $\{a,b\}$ form a coseparating set in Set.
-/

theorem PUnit_isSeparator : IsSeparator (PUnit : Type u) := by
  sorry

theorem ULiftBool_isCoseparator :  IsCoseparator (ULift.{u} Bool) := by
  sorry
