import Mathlib

/-
The local maximum of the function f(x)=x^4/4 - x^3/3 - 2x^2 + 4x + 5 on the interval
[-3,3] is 41 / 4  and is attained at x=3, and
the local minimum is -13/3 and it is attained for x=-2.
-/

noncomputable def f (x : ℝ) : ℝ := x^4 / 4 - x^3 / 3 - 2 * x^2 + 4 * x + 5

theorem extrema_on_interval :
  ¬ ((∃ x : ℝ, x ∈ Set.Icc (-3) 3 ∧ (∀ y ∈ Set.Icc (-3) 3, f y ≤ f x) ∧ f x = 41/4 ∧ x = 3) ∧
  (∃ z : ℝ, z ∈ Set.Icc (-3) 3 ∧ (∀ y ∈ Set.Icc (-3) 3, f z ≤ f y) ∧ f z = - 13 / 3 ∧ z = -2)) := by
  sorry
