import Mathlib

/-
The unique solution to the linear equation $2=-12+2r$ is $r=7$.
-/

open Classical

variable (r : ℝ)

noncomputable def given_equation (r : ℝ) := (2 : ℝ) = (-12 : ℝ) + (2 * (r : ℝ))

-- Lemma to isolate r

lemma isolate_r : given_equation r ↔ r = (7 : ℝ) := by
  sorry
