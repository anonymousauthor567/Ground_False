import Mathlib

/-
The integral of \(\int \frac{1}{x^2+1} \, dx\) is \(\arctan x + C\).
-/

open Real

noncomputable def f (x:ℝ ):ℝ := 1 / (x^2 + 1)

theorem integral_of_inv_sq_plus_one (x C: ℝ) :
  ∫ x , f x  = arctan x + C := by
  sorry
