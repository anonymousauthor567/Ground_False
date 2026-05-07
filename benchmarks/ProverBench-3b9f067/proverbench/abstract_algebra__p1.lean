import Mathlib

/-
A polynomial \(P(x)\in\mathbb{Z}[x]\) that takes values \(\pm1\) at three different integer points
can not have any integer zeros.
-/

variable {P : Polynomial ℤ}

theorem no_integer_zeros_for_polynomial_with_pm1_values
  (h : ∃ a b c : ℤ, a ≠ b ∧ b ≠ c ∧ a ≠ c ∧ P.eval a = 1 ∧ P.eval b = -1 ∧ P.eval c = 1) :
  ¬ ∃ z : ℤ, P.eval z = 0 := by
  sorry
