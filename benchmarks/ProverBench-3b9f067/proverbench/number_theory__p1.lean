import Mathlib

/-
All prime divisors of a number of the form n^8 - n^4 + 1, where n is a natural number,
are of the form 24k + 1, where k is a natural number.
-/

variable (n : ℕ)

/-- The polynomial n^8 - n^4 + 1 we're studying -/
noncomputable def polynomial (n : ℕ) : ℕ :=
  n^8 - n^4 + 1

/-- A number is of the form 24k + 1 -/
def is24kPlus1 (p : ℕ) : Prop :=
  ∃ k : ℕ, p = 24 * k + 1

theorem prime_divisors_of_polynomial_congruence :
  ∀ (p : ℕ), p.Prime → p ∣ polynomial n → is24kPlus1 p := by
  sorry
