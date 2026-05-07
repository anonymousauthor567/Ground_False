import Mathlib

/-
The inequality \(a^2(s-a) + b^2(s-b) + c^2(s-c) \leq \frac{3}{2}abc\) holds for any
positive real numbers \(a\), \(b\), \(c\), and \(s\), where \(s\) is the semi-perimeter
given by \(s = \frac{a+b+c}{2}\).
-/

variable (a b c : ℝ) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)

noncomputable def s : ℝ := (a + b + c) / 2

theorem imo_inequality :
  a^2 * ((s a b c) - a) + b^2 * ((s a b c) - b) + c^2 * ((s a b c) - c) ≤ (3/2) * a * b * c := by
  sorry
