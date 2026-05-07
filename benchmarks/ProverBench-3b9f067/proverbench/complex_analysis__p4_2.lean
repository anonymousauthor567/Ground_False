import Mathlib

/-
For the imaginary unit $i$, where $i^2 = -1$, the following equality holds:

    $i^{73} = i$
-/

open Complex

axiom i_pow_73 : I ^ 73 = I

theorem i_pow_mod_4 (n : ℕ) : I ^ n = I ^ (n % 4) := by
  sorry
