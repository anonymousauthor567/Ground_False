import Mathlib

/-
Let T: Z × Z → Z be a linear function satisfying T(1, 0) = 3 and T(0, 1) = -5. Then for all (x, y) ∈ Z × Z, T(x, y) = 3x - 5y.
-/

open Int AddMonoidHom

variable (T : ℤ × ℤ →+ ℤ)

axiom T10 : T (1, 0) = 3

axiom T01 : T (0, 1) = -5

lemma T_expression : ∀ (x y : ℤ), T (x, y) = 3 * x - 5 * y := by
  sorry
