import Mathlib

/-
Let f(u,v) be a differentiable function satisfying the following conditions:

  1. $\frac{\partial f(u, v)}{\partial u} - \frac{\partial f(u, v)}{\partial v} = 2(u-v)e^{-(u+v)}$
  2. $f(u,0) = u^2e^{-u}$

  Then:

  a) For $g(x,y) = f(x,y-x)$, $\frac{\partial g(x,y)}{\partial x} = (4x-2y)e^{-y}$

  b) The expression for $f(u,v)$ is given by $f(u,v) = (u^2+v^2)e^{-(u+v)}$

  c) The function $f(u,v)$ has a unique global minimum at $(0,0)$ with $f(0,0) = 0$
-/

open Real

variable {u v x y : ℝ}

/-- The function f satisfying the given partial derivative condition -/
noncomputable def f (u v : ℝ) : ℝ := (u^2 + v^2) * exp (-(u + v))

/-- The function g defined in terms of f -/
noncomputable def g (x y : ℝ) : ℝ := f x (y - x)

/-- The partial derivative condition for f -/
axiom f_partial_condition (u v : ℝ) :
  deriv (fun u => f u v) u - deriv (fun v => f u v) v = 2 * (u - v) * exp (-(u+v))

/-- The initial condition for f -/
lemma f_initial_condition (u : ℝ) :
  f u 0 = u^2 * exp (-u) := by
  sorry
