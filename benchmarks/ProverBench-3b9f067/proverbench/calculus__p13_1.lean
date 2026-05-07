import Mathlib

/-
Let $f(x) = \sec^2 x$. The equation of the tangent line to the graph of $f(x)$ at the point $(\pi/3, f(\pi/3))$ is given by $y = 8\sqrt{3}x + 4 - 8\sqrt{3}\pi/3$.
-/

open Real

-- Define `f(x)`: The function `f(x) = sec^2 x`.
noncomputable def f (x : ℝ) : ℝ := (1 / cos x) ^ 2

-- Lemma of `f(π/3)`: The value of `f` at `x = π/3` is `4`.

lemma value_at_pi_over_3 : f (π / 3) = 4 := by
  sorry
