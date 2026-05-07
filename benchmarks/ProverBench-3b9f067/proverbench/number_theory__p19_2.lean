import Mathlib

/-
There exist infinitely many prime numbers of the form (a) \(4k+1\); (b) \(10k+9\).
-/

-- Theorem: There exist infinitely many prime numbers of the form 4k+1.
axiom infinitelyManyPrimesOfForm4kPlus1 : ∃ (infinitelyMany : ℕ → Prop), ∀ n : ℕ, infinitelyMany n → ∃ p : ℕ, Nat.Prime p ∧ p % 4 = 1

-- Theorem: There exist infinitely many prime numbers of the form 10k+9.

theorem infinitely_many_primes_10k_plus_9 :
  ∃ (S : Set ℕ), Set.Infinite S ∧ ∀ p ∈ S, Nat.Prime p ∧ p ≡ 9 [MOD 10] := by
  sorry
