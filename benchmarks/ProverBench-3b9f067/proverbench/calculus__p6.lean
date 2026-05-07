import Mathlib

/-
The derivative of the function \(f(x)=\cos(x^3)\) is \(f'(x)= -\sin(x^3)\cdot 3x^2\).
-/

open scoped Topology Filter

variable (x : ℝ)

theorem cosX3_derivative : deriv (fun x => Real.cos (x^3)) x = -Real.sin (x^3) * (3 * x^2) := by
  sorry
