import Mathlib

/-
The limit of the function \(f(x)=\frac{ 3^{x}-1}{x}\) as \(x\) approaches 0 is \(\ln 3\).
-/

open Filter Topology

theorem limit_of_function_as_x_approaches_zero :
  Tendsto (fun x => (3^x - 1) / x) (𝓝[≠] 0) (𝓝 (Real.log 3)) := by
  sorry
