import Mathlib

/-
The limit of the function \(\displaystyle \lim_{x\to 0}\frac{\sin\left(3x+x^2\right)}{5x+2x^2}\) equals to \(\frac{3}{5}\).
-/

open Filter Topology

theorem limit_of_function_at_zero :
Tendsto (fun x => Real.sin (3 * x + x^2) / (5 * x + 2 * x^2)) (𝓝 0) (𝓝 (3 / 5)) := by
  sorry
