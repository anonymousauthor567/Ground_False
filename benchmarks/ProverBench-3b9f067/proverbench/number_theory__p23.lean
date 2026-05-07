import Mathlib

/-
Prove that for `n∈ℕ` every prime divisor `p` of number `n^4-n^2+1` is of the form `12k+1`.
-/

variable (n : ℕ)

theorem prime_divisors_of_polynomial_form :
  ∀ p : ℕ, p.Prime → p ∣ n^4 - n^2 + 1 → ∃ k : ℕ, p = 12 * k + 1 := by
  sorry
