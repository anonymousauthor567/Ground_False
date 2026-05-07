import Mathlib

/-
Let $i$ be the imaginary unit such that $i^2 = -1$. Then $(1+i)^{10} = 32i$.
-/

open Complex Real

-- Simplify e^(i 5π/2) using exponential function periodicity

lemma exponent_simplification : exp (I * (5 * π / 2)) = exp (I * (π / 2)) := by
  sorry
