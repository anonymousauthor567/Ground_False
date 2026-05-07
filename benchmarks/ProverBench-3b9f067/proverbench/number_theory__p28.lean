import Mathlib

/-
Let \(p\) be a prime number and \( N=\prod _{k=1}^{p-1}(k^2+1)\). The remainder of \(N\) upon division by \(p\) is 4 if \(p\) is congruent to 3 modulo 4, and 0 if \(p\) is congruent to 1 modulo 4.
-/

open Finset

theorem prime_remainder_theorem (p : ℕ) (hp : Prime p) :
  let N := (range (p - 1)).prod (λ k => k^2 + 1);
  if p % 4 = 3 then N % p = 4 else N % p = 0 := by
  sorry
