import Mathlib

/-
The inequality \(2a^3 + 2b^3 + 2c^3 + a^2b + b^2c + c^2a \geq 3ab^2 + 3bc^2 + 3ca^2\) holds for all positive real numbers \(a\), \(b\), and \(c\).
-/

theorem inequality_for_positive_reals (a b c : ℝ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
  2 * a^3 + 2 * b^3 + 2 * c^3 + a^2 * b + b^2 * c + c^2 * a ≥ 3 * a * b^2 + 3 * b * c^2 + 3 * c * a^2 := by
  sorry
