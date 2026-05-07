import Mathlib

/-
For any number \(n\in\mathbb{N}\), all prime divisors of \(n^8-n^4+1\) are of the form \(24k+1\), \(k\in\mathbb{N}\), since any prime divisor \(p\) of \(n^8-n^4+1\) is congruent to 1 or 13 (mod 24) and since \[n^8-n^4+1=(n^4+n^2+1)-2(n^3+n)^2,\] 2 is a quadratic residue modulo \(p\), excluding the possibility \(p\equiv\pm13\) (mod 24).
-/

/-- The polynomial n^8 - n^4 + 1 -/
def Polynomialn (n : ℕ) : ℕ :=
  n^8 - n^4 + 1

/-- Main theorem: all prime divisors are of the form 24k + 1 -/
theorem prime_divisors_of_polynomial_form (p : ℕ) (hp : Prime p) (h : p ∣ Polynomialn n) :
  ∃ k : ℕ, p = 24 * k + 1 := by
  sorry
