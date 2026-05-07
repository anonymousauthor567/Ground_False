import Mathlib

/-
There exist infinitely many prime numbers of the form (a) \(4k+1\); (b) \(10k+9\).
-/

-- Theorem: There exist infinitely many prime numbers of the form 4k+1.

theorem infinitely_many_primes_4k_plus_1 :
  ∃ (S : Set ℕ), Set.Infinite S ∧ ∀ p ∈ S, Nat.Prime p ∧ p ≡ 1 [MOD 4] := by
  sorry
