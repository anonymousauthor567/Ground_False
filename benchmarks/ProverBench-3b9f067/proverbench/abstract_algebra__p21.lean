import Mathlib

/-
In a ring \((R,+,\cdot)\), for which every element \(a\in R\) satisfies \(a^3=a\),
the ring \(R\) is commutative, meaning \(a\cdot b=b\cdot a\) for all \(a,b\in R\).
-/

variable {R : Type} [Ring R]

theorem commutative_ring_of_cube_equals_self
  (h : ∀ a : R, a^3 = a) :
  ∀ a b : R, a * b = b * a := by
  sorry
