import Mathlib

/-
The limit of the function \(f(x)=\frac{\sin(5x^2)}{x^2}\) as \(x\) approaches 0 is 5.
-/

open Filter Topology Real

theorem limit_of_sin_5x2_over_x2_as_x_approaches_0 :
  Tendsto (fun x => (sin (5 * x^2)) / x^2) (𝓝 0) (𝓝 5) := by
  sorry
