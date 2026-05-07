import Mathlib

/-
The polynomial \(x^n+x-1\) is divisible by \(x^2-x+1\) if and only if \(n=6i-1\).
Additionally, there exists no \(n\) such that the polynomial \(x^n+x-1\) can be divisible by \(x^3-x+1\).
-/

open Polynomial Complex

variable {R : Type*} [Field R] [Nontrivial R]

variable  (P Q R : Polynomial R) (hP : P = X^n + X - 1) (hQ : Q = X^2 - X + 1) (hR : R = X^3 - X + 1)

theorem polynomial_divisibility_by_quadratic (n : ℕ) :
  ((P ∣ Q) ↔ ∃ i : ℕ, n = 6 * i - 1 )∧ (∀ n : ℕ, ¬ (P ∣ R)) := by
  sorry
