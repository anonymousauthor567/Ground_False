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

axiom P_X_leq_1 : poisson_pmf lambda 0 + poisson_pmf lambda 1 = 2 * exp (-(lambda : ℝ))

axiom E_X (h : Summable (fun (k : ℕ) => k * poissonPMFReal lambda k)) :
  ∑' k, k * poissonPMFReal lambda k = lambda

theorem cov_X_X2 (h0 : lambda = 1)
  (h1 : Summable fun k => k * k^2 * poissonPMFReal lambda k)
  (h2 : Summable fun k => k * poissonPMFReal lambda k)
  (h3 : Summable fun k => k^2 * poissonPMFReal lambda k) :
  (∑' k, k * k^2 * poissonPMFReal lambda k) -
  (∑' k, k * poissonPMFReal lambda k) * (∑' k, k^2 * poissonPMFReal lambda k) = 3 := by
  sorry
