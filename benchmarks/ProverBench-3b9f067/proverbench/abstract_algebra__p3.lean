import Mathlib

/-
S₃ is a non-commutative group of order 6. Therefore, there does exist a non-commutative group
of 6 elements
-/

theorem exists_non_commutative_group_of_order_6 :
  ∃ (G : Type) (_ : Group G) (_ : Fintype G),
    Fintype.card G = 6 ∧ ¬(∀ a b : G, a * b = b * a) := by
  sorry
