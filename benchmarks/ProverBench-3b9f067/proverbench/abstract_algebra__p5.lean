import Mathlib

/-
For a polynomial \(P(x)=ax^4+bx^3+cx^2+dx+e\) of degree four with integer coefficients,
if two roots \(x_1\) and \(x_2\) satisfy that \[x_1+x_2\in\mathbb Q\setminus\left\{\frac{-b}{2a}\right\}\],
then it is true that \(x_1x_2\in\mathbb Q\).
-/

open Polynomial

variable {P : Polynomial ℤ} (hP : P.degree = 4)

theorem rational_product_of_roots {K : Type*} [CommRing K] [Field K] [CharZero K] [Algebra ℚ K]
  (P : Polynomial ℚ) (hd : P.degree = 4)
  (x₁ x₂ : K) (hr₁ : eval x₁ (map (algebraMap ℚ K) P) = 0)
  (hr₂ : eval x₂ (map (algebraMap ℚ K) P) = 0)
  (hsum : x₁ + x₂ ≠ (-P.coeff 1) / (2 * P.leadingCoeff)) :
  ∃ q : ℚ, x₁ * x₂ = algebraMap ℚ K q := by
  sorry
