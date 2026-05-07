import Mathlib

open Polynomial Set

/-- Define the parabola as a polynomial x² + 3 -/
noncomputable def parabola_poly : Polynomial ℝ :=
  X^2 + C 3

/-- Convert polynomial to real function -/
noncomputable def parabola_fun (x : ℝ) : ℝ :=
  aeval x parabola_poly

/-- The area under the parabola between x=1 and x=3 is 44/3 -/
theorem area_under_parabola_from_1_to_3 :
  (∫ x in Icc 1 3, parabola_fun x) = 44/3 := by
  sorry
