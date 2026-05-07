import Mathlib

/-
The integral \(\displaystyle \int \frac{2\sin^3x+\sin^2x\cos x-4\sin x\cos^2x+3\cos^3x}{\left(\sin^2x-\sin x\cos x-2\cos^2x\right)\cos x}\,dx\) is equal to \(\ln\left|\tan x-2\right|-\ln\left|\tan x+1\right|-2\ln\left|\cos x\right|+C\).
-/

-- Define the integral function
noncomputable def integralFunction (x : ℝ) : ℝ :=
  (2 * Real.sin x ^ 3 + Real.sin x ^ 2 * Real.cos x - 4 * Real.sin x * Real.cos x ^ 2 + 3 * Real.cos x ^ 3) / ((Real.sin x ^ 2 - Real.sin x * Real.cos x - 2 * Real.cos x ^ 2) * Real.cos x)

-- Theorem statement

theorem trigonometric_integral_result :
∀ x : ℝ, ∃ C : ℝ, ∫ x, integralFunction x = Real.log (abs (Real.tan x - 2)) - Real.log (abs (Real.tan x + 1)) - 2 * Real.log (abs (Real.cos x)) + C := by
  sorry
