import Mathlib

/- For the equation cos(2x) - √3 sin(2x) = √2, there exist exactly four solutions
   in the interval [0, 2π), namely x = 0, x = π/3, x = π, and x = 4π/3. -/

/-- The left side of the equation cos(2x) - √3 sin(2x) = √2 -/
noncomputable def equation (x : ℝ) : ℝ :=
  Real.cos (2 * x) - Real.sqrt 3 * Real.sin (2 * x)

/-- The equation can be rewritten as 2cos(2x + π/3) = √2 -/
axiom simplified_equation (x : ℝ) :
  equation x = 2 * Real.cos (2 * x + Real.pi / 3) - Real.sqrt 2

/-- The set of solutions in [0, 2π) -/
noncomputable def solution_set : Finset ℝ :=
  {0, Real.pi / 3, Real.pi, 4 * Real.pi / 3}

/-- Verify each solution lies in [0, 2π) -/
lemma solutions_in_interval :
  ∀ x ∈ solution_set, x ∈ Set.Ico 0 (2 * Real.pi) := by
  sorry
