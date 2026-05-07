import Mathlib

/-
The derivative of the function \(f(x)=x^3\) at point \(x=4\) equals 48.
-/

open Filter

variable (f : ℝ → ℝ) (x : ℝ)

theorem derivative_of_cube_at_four : deriv (fun x : ℝ => x^3) 4 = 48 := by
  sorry
