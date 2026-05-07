import Mathlib
/-
Let $R$ be a commutative ring with unity. Then:
  1. Every field is an integral domain.
  2. Not every integral domain is a field.
-/
open CommRing
variable (F : Type) [Field F]
variable (D : Type) [CommRing D] [NoZeroDivisors D]

/-- In a field, if ab = 0, then a = 0 or b = 0. -/
theorem field_is_integral_domain (a b : F) (h : a * b = 0) : a = 0 ∨ b = 0 := by
  sorry
