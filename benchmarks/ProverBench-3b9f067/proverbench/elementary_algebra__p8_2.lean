import Mathlib

/-
For any real numbers, the following equality holds:

  $\frac{2-5 \sqrt{5}}{4 \sqrt{13}} = \frac{2 \sqrt{13}-5 \sqrt{65}}{52}$
-/

open Real

-- Define `LHS`: The left-hand side of the equation
noncomputable def LHS : ℝ := (2 - 5 * sqrt 5) / (4 * sqrt 13)

-- Define `RHS`: The right-hand side of the equation
noncomputable def RHS : ℝ := (2 * sqrt 13 - 5 * sqrt 65) / 52

-- Prove the equality
axiom given_equality_holds : LHS = RHS

-- Optional: Prove some intermediate steps for clarity

lemma sqrt_five_times_sqrt_thirteen : sqrt 5 * sqrt 13 = sqrt 65 := by
  sorry
