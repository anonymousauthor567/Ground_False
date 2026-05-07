import Mathlib

/-
The value of the integral \[\iiint_D e^{x^2+y^2}\,dV\] where \(D\) is the the region
in bounded by the planes \(y=0\), \(z=0\), \(y=x\),
and the paraboloid \(z=4-x^2-y^2\) is \[\frac{\left(e^4-5\right)\pi}8\].
-/

open MeasureTheory

variable {D : Type} [MeasurableSpace D] [MeasureSpace D]

-- Define the set D as a variable
variable (D : Set (Fin 3 → ℝ))

theorem integral_value_over_region (D : Set (Fin 3 → ℝ))
  (hD : D = {p : Fin 3 → ℝ | p 2 ≥ 0 ∧ p 3 ≥ 0 ∧ p 2 ≤ p 1 ∧ p 3 ≤ 4 - p 1^2 - p 2^2}) :
  let integrand := fun p : Fin 3 → ℝ => Real.exp (p 1^2 + p 2^2)
  ∫ p in D, integrand p = (Real.exp 4 - 5) * π / 8 := by
  sorry
