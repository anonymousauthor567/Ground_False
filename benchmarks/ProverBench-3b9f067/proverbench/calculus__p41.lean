import Mathlib

/-
The limit of the function \(\displaystyle \lim_{x\to0}\frac{ e^{8x}-1}{x}\) is 8.
-/

open Filter Topology

variable (x : ℝ)

theorem limit_of_function : Tendsto (fun x => (Real.exp (8 * x) - 1) / x) (𝓝[Set.Ioi 0] 0) (𝓝 8) := by
  sorry
