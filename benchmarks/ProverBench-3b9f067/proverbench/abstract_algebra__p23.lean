import Mathlib

/-
Let $f(x) = x^5 + 3x^3 + x^2 + 2x$ be a polynomial in $\mathbb{Z}_5[x]$.
Then the set of all zeros of $f(x)$ in $\mathbb{Z}_5$ is $\{0, 4\}$.
-/

open ZMod Polynomial

noncomputable def f : Polynomial (ZMod 5) := X^5 + 3 * X^3 + X^2 + 2 * X

theorem zeros_of_f_in_Z5 : {x : ZMod 5 | eval x f = 0} = {0, 4} := by
  sorry
