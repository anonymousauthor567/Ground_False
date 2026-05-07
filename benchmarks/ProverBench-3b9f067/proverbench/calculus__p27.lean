import Mathlib

/-
The partial derivative of the function g(s,t)=f(x(s,t),y(s,t),z(s,t))
with respect to ∂t evaluated at (2,π) is 24π², where:
  f(x,y,z) = x² + y³ + z⁴
  x(s,t) = s·cos(t)
  y(s,t) = s·t
  z(s,t) = s²
-/

open Real
open Function

/-- The main function f(x,y,z) = x² + y³ + z⁴ -/
noncomputable def f (x y z : ℝ) : ℝ := x^2 + y^3 + z^4

/-- x(s,t) = s·cos(t) -/
noncomputable def x (s t : ℝ) : ℝ := s * cos t

/-- y(s,t) = s·t -/
noncomputable def y (s t : ℝ) : ℝ := s * t

/-- z(s,t) = s² -/
noncomputable def z (s : ℝ) : ℝ := s^2

/-- The composite function g(s,t) = f(x(s,t), y(s,t), z(s,t)) -/
noncomputable def g (s t : ℝ) : ℝ :=
  f (x s t) (y s t) (z s)

/-- Partial derivative of g with respect to t -/
noncomputable def partial_t (s t : ℝ) : ℝ :=
  deriv (fun τ => g s τ) t

/-- Main theorem: The partial derivative ∂g/∂t at (2,π) equals 24π² -/
theorem partial_derivative_example :
  partial_t 2 π = 24 * π^2 := by
  sorry
