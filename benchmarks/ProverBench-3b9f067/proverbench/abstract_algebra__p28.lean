import Mathlib

/-
The sum of \(\alpha\), \(\beta\), \(\gamma\), and \(\delta\) when the fraction
\(\displaystyle \frac{7x^2 -2x +6}{(x -2)^2(x +3)}\) is expressed in the form
\(\displaystyle \frac{\alpha}{x-2}+\frac{\beta}{(x-2)^2}+\frac{\gamma}{(x+3)}+\frac{\delta}{(x+3)^2}\)
is 13.
-/

variable {α β γ δ : ℝ}

/-- The rational function before decomposition -/
noncomputable def originalFraction (X : ℝ) : ℝ :=
  (7 * X^2 - 2 * X + 6) / ((X - 2)^2 * (X + 3))

/-- The partial fraction decomposition form -/
noncomputable def decomposedForm (α β γ δ : ℝ) (X : ℝ) : ℝ :=
  α / (X - 2) + β / (X - 2)^2 + γ / (X + 3) + δ / (X + 3)^2

/-- Main theorem that when the original fraction equals its decomposition,
    the sum of coefficients must be 13 -/
theorem sum_of_coefficients_equals_thirteen
    (h : ∀ X, originalFraction X = decomposedForm α β γ δ X) :
    α + β + γ + δ = 13 := by
  sorry
