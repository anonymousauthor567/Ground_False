import Mathlib

/-
For any polynomial \(P(x)\) with real coefficients such that \(P(x) \geq 0\) for all \(x \geq 0\),
there exist polynomials \(A(x)\) and \(B(x)\) with real coefficients such that \(P(x) = A(x)^2 + x \cdot B(x)^2.
-/

variable {P : Polynomial ℝ} (hP : ∀ x : ℝ, x ≥ 0 → P.eval x ≥ 0)

theorem polynomial_decomposition :
  ∃ (A B : Polynomial ℝ), P = A^2 + Polynomial.X * B^2 := by
  sorry
