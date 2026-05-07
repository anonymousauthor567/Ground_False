import Mathlib

/-
The limit of the function \[\lim_{x\to 0}\frac{1-(\cos x)^{\sin x}}{x^3}\] is 1/2.
-/

open Filter Topology

theorem limit_of_function_at_zero :
  Tendsto (fun x => (1 - (Real.cos x)^(Real.sin x)) / x^3) (𝓝 0) (𝓝 (1 / 2)) := by
  sorry
