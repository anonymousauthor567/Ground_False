import Mathlib

/-
A real polynomial \(P(x)\) of degree at most 5 which leaves remainders \(-1\) and 1 upon division by
\((x-1)^3\) and \((x+1)^3\), respectively, is given by \(P(x)=-\frac38x^5+\frac54x^3-\frac{15}8x\).
-/

open Polynomial

variable {P : Polynomial ℝ} (hDegree : P.degree ≤ 5)

theorem unique_polynomial_with_remainders :
  (∀ x, (P %ₘ (X - 1)^3).eval x = -1) ∧ (∀ x, (P %ₘ (X + 1)^3).eval x = 1) →
  P = -C (3/8) * X^5 + C (5/4) * X^3 - C (15/8) * X := by
  sorry
