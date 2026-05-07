import Mathlib

/-
The indefinite integral of cos(5x) with respect to x is 1/5 sin(5x) + C.
-/

theorem cos_5x_indefinite_integral {f : ℝ → ℝ}
    (hf : Continuous f)
    (h_diff : ∀ x, DifferentiableAt ℝ f x)
    (h_deriv : ∀ x, deriv f x = (1 / 5 : ℝ) * Real.sin (5 * x)) :
    ∃ C, ∀ x, f x = (1 / 5 : ℝ) * Real.sin (5 * x) + C := by
  sorry
