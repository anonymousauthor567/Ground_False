import Mathlib

/-
The composition of the functions \(u(x)=\sin x\) and \(v(x)=x^2\) is \(u(v(x))=\sin(x^2)\).
-/

-- Define the sine function
noncomputable def u (x : ℝ) : ℝ := Real.sin x

-- Define the quadratic function
def v (x : ℝ) : ℝ := x ^ 2

-- Theorem statement for the composition of u and v

theorem composition_of_sine_and_quadratic (x : ℝ) : u (v x) = Real.sin (x ^ 2) := by
  sorry
