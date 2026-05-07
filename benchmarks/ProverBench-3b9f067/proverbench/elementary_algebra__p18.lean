import Mathlib

/-
The value of \(\alpha-\beta+\gamma\), when the fraction
\(\displaystyle \frac{7x^2 -9x +32}{\left(x^2+25\right)(x -3)}\)
is expressed in the form \(\displaystyle \frac{\alpha x+\beta}{x^2+ 25}+\frac{\gamma}{(x-3)}\), is 1.
-/

variable (α β γ : ℤ)(x : ℝ)

noncomputable def fraction: ℝ := (7 * x^2 - 9 * x + 32) / ((x^2 + 25) * (x - 3))

noncomputable def decomposed: ℝ  := (α * x + β) / (x^2 + 25) + γ / (x - 3)

theorem partial_fraction_decomposition_value : fraction x = decomposed α β γ x → α - β + γ = 1 := by
  sorry
