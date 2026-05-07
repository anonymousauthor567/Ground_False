import Mathlib

/-
The integral of 4/(x^2 -7x +12) from 100 to 200 is equal to 4 * log(196/96) - 4 * log(197/97).
-/

open Real Filter

variable {a b : ℝ} (h_a : a = 100) (h_b : b = 200)

theorem integral_of_rational_function :
∫ x in a..b, (4 : ℝ) / (x^2 - 7*x + 12) = 4 * log (196 / 96) - 4 * log (197 / 97) := by
  sorry
