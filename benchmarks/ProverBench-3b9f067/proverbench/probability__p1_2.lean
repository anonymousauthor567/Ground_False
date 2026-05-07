import Mathlib
/-
Let X be a random variable following a Poisson distribution with parameter λ. If P{X>0} = 1-e^(-1), then:
  (a) λ = 1
  (b) P{X ≤ 1} = 2e^(-1)
  (c) cov(X, X^2) = 3
-/
open Real MeasureTheory ProbabilityTheory

variable (lambda : NNReal)

noncomputable def poisson_pmf : ℕ → ℝ :=
 poissonPMFReal lambda

axiom lambda_eq_1 (h : 1 - exp (-1) = 1 - exp (-(lambda : ℝ))) : lambda = 1 

theorem P_X_leq_1 : poisson_pmf lambda 0 + poisson_pmf lambda 1 = 2 * exp (-(lambda : ℝ)) := by
  sorry
