import Mathlib

/-
For all positive real numbers \(a\) and \(b\), \(a^3+b^3\geq a^2b+ab^2\).
This is confirmed by the fact that the inequality is equivalent to \((a-b)^2(a+b)\geq 0\),
which is always true.
-/

variable {a b : ℝ}

theorem cubic_inequality (ha : 0 < a) (hb : 0 < b): a^3 + b^3 ≥ a^2 * b + a * b^2 := by
  sorry
