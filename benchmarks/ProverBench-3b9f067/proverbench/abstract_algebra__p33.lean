import Mathlib

/-
For a polynomial P, the equation \(16P(x^2)=P(2x)^2\) holds if and only if
\(P(x)=16\left(\frac14x\right)^n\) for some \(n\in\mathbb{N}\).
-/

open Polynomial

variable {P : Polynomial ℝ}

theorem polynomial_condition :
(∀ x : ℝ, 16 * eval (x^2) P = (eval (2 * x) P)^2) ↔ ∃ n : ℕ, P = (16 : Polynomial ℝ) * (Polynomial.X /ₘ (4 : Polynomial ℝ))^n := by
  sorry
