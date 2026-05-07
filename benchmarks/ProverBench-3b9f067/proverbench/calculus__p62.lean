import Mathlib

/-
The integral \(\displaystyle \int \frac{x}{\sqrt{49-x^2}}\,dx\) evaluates to \(-\sqrt{49-x^2}+C.\)
-/

-- Define the function as noncomputable
noncomputable def f (x : ℝ) : ℝ := x / Real.sqrt (49 - x^2)

-- Theorem statement

theorem integral_f_eq (x C : ℝ):  ∫  x, f x = -Real.sqrt (49 - x^2) + C := by
  sorry
