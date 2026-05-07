import Mathlib

/-
In a sequential shooting scenario where two shooters A and B independently take turns, with A shooting first, if the probability of A hitting the target on any given shot is $p_A = 0.3$ and the probability of B hitting the target is $p_B = 0.4$, then the probability $P(A)$ that A is the first to hit the target is given by:

  $P(A) = \frac{p_A}{1 - (1-p_A)(1-p_B)} = \frac{15}{29}$
-/

open MeasureTheory ProbabilityTheory

/-- The probability that shooter A hits the target on any given shot. -/
noncomputable def p_A : NNReal := 3 / 10

/-- The probability that shooter B hits the target on any given shot. -/
noncomputable def p_B : NNReal := 4 / 10

/-- Formula for the probability that shooter A is the first to hit the target
    in a sequential, independent shooting scenario. -/
noncomputable def prob_A_first_hit {α : Type} [MeasurableSpace α] (μ : Measure α)
  (A : Set α) (B : Set α) : NNReal :=
  (μ (A)).toNNReal / (1 - (1 - (μ (A)).toNNReal) * (1 - (μ (B)).toNNReal))

/-- Theorem: Given p_A = 0.3 and p_B = 0.4, the probability that shooter A
    is the first to hit the target in a sequential, independent shooting scenario is 15/29. -/
theorem prob_A_first_hit_value {α : Type} [MeasurableSpace α]
    (μ : Measure α) (A : Set α) (B : Set α)
  (hIndep : IndepSet A B μ) (hA : μ (A) = p_A) (hB : μ (B) = p_B) :
  prob_A_first_hit μ A B  = 15 / 29 := by
  sorry
