import Mathlib

/-
Prove that there is no positive integer n for which n^5 can be written as a product of six consecutive positive integers.
-/

theorem product_of_six_consecutive_integers_not_fifth_power :
  ∀ (n : ℕ), ∀ (a b c d e f : ℕ),
    (a * b * c * d * e * f = n^5) →
    (a + 1 = b ∧ b + 1 = c ∧ c + 1 = d ∧ d + 1 = e ∧ e + 1 = f) →
    False := by
  sorry
