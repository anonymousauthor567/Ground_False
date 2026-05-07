import Mathlib

/-
The only real numbers \(a\), \(b\), \(c\), and \(d\) that satisfy the equation \(a^2 + b^2 + c^2 + d^2 = a(b + c + d)\) are \(a = b = c = d = 0\).
-/

variable (a b c d : ℝ)

theorem real_numbers_equation_solution :
    a^2 + b^2 + c^2 + d^2 = a * (b + c + d) → a = 0 ∧ b = 0 ∧ c = 0 ∧ d = 0 := by
  sorry
