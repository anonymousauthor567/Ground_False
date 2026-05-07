import Mathlib

/-
For a prime number `p=4k-1` where `k∈ℕ` and an integer `a` in which the congruence `x^2≡a` (mod `p`)
has a solution, the solutions are `x=±a^k`, as per Euler's criterion, which implies that if a solution
exists, then it is defined that `a^(2k-1)≡1` (mod `p`). As such, for `x=a^k`, it holds that
`x^2≡a^(2k)≡a` (mod `p`).
-/

variable {p : ℕ} {k : ℕ} (hp : p = 4 * k - 1) (hp_prime : Nat.Prime p)
variable {a : ℤ} (ha : ∃ x : ℤ, x^2 ≡ a [ZMOD p])

/-- The solutions of x^2 ≡ a (mod p) are ±a^k -/
theorem solutions_of_quadratic_congruence :
  (∀ x : ℤ, x^2 ≡ a [ZMOD p] → (x ≡ a^k [ZMOD p] ∨ x ≡ -a^k [ZMOD p])) ∧
  ((a^k)^2 ≡ a [ZMOD p]) := by
  sorry
