import Mathlib

/-
If a polynomial \(P\) with real coefficients satisfies for all \(x\) \[P(\cos x)=P(\sin x),\]
prove that there exists a polynomial \(Q\) such that for all \(x\), \(P(x)=Q(x^4-x^2).\)
-/

variable {P : Polynomial ℝ}

theorem polynomial_identity_cos_sin_to_poly (h : ∀ x, Polynomial.eval (Real.cos x) P = Polynomial.eval (Real.sin x) P) :
∃ Q : Polynomial ℝ, ∀ x, Polynomial.eval x P = Polynomial.eval (x^4 - x^2) Q := by
  sorry
