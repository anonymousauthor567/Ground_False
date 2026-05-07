import Mathlib

/-
The integral of \[(x^3 - 3cosx) dx\] is \[\frac{x^4}{4} - 3sinx + C\].
-/

-- Define the function f(x)
noncomputable def f (x : ℝ) : ℝ := x^3 - 3 * Real.cos x

-- Define the integral of f(x)
noncomputable def integralf (x : ℝ) : ℝ := (x^4 / 4) - 3 * Real.sin x

-- Theorem statement

theorem integral_f_eq_integralF_plus_C (x C : ℝ):
  ∫ x , f x = integralf x + C := by
  sorry
