import Mathlib

/-
The limit of the function \(\displaystyle \lim_{x\to +\infty}\frac{\sin\left(2x+x^3\right)}{x+3x^3}\) as x approaches infinity is equal to 0.
-/

open Filter Topology Real

theorem limit_of_sin_fraction_as_x_approaches_infinity :
Tendsto (fun x : ℝ => sin (2 * x + x^3) / (x + 3 * x^3)) atTop (𝓝 0) := by
  sorry
