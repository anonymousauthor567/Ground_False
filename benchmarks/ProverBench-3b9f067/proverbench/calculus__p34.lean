import Mathlib

/-
The length of the curve obtained by a moving paint nozzle that rotates around a rotating paraboloid in unit time is given by the integral
(without evaluating) \[\int_0^1\sqrt{1+\left(4+4\pi^2\right)t^2}\,dt.\]
-/

-- Define the integrand function
noncomputable def integrand (t : ℝ) : ℝ := Real.sqrt (1 + (4 + 4 * Real.pi ^ 2) * t ^ 2)

-- Theorem statement

theorem curveLength_integral :
∫ (t : ℝ) in Set.Icc 0 1, integrand t = ∫ (t : ℝ) in Set.Icc 0 1, Real.sqrt (1 + (4 + 4 * Real.pi ^ 2) * t ^ 2) := by
  sorry
