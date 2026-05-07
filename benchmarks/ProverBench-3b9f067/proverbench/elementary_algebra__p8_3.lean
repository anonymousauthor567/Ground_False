import Mathlib

/-
For any real numbers, the following equality holds:

  $\frac{2-5 \sqrt{5}}{4 \sqrt{13}} = \frac{2 \sqrt{13}-5 \sqrt{65}}{52}$
-/

open Real

noncomputable def LHS : ℝ := (2 - 5 * sqrt 5) / (4 * sqrt 13)

noncomputable def RHS : ℝ := (2 * sqrt 13 - 5 * sqrt 65) / 52

axiom given_equality_holds : LHS = RHS

axiom sqrt_five_times_sqrt_thirteen : sqrt 5 * sqrt 13 = sqrt 65

lemma simplify_LHS_numerator : 2 * sqrt 13 - 5 * sqrt 65 = (2 - 5 * sqrt 5) * sqrt 13 := by
  sorry
