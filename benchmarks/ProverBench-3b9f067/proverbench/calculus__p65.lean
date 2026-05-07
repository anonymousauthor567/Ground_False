import Mathlib

/-
The derivative of the function g(x) = cos(x) is g'(x) = -sin(x).
-/

theorem cos_derivative : deriv (fun x => Real.cos x) = fun x => -Real.sin x := by
  sorry
