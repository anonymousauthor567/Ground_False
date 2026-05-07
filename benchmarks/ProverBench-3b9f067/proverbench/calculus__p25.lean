import Mathlib

/-
The function \(f(x)=\cos(3x+x^2)\) is differentiable for \(x\in\mathbb R\) and its derivative \(f^{\prime}(x)\) is \(-\sin(3x+x^2)\cdot (3+2x)\).
-/

open Real

theorem cosine_derivative_formula (x : ℝ) :
  deriv (fun x => cos (3 * x + x^2)) x = -sin (3 * x + x^2) * (3 + 2 * x) := by
  sorry
