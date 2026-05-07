import Mathlib

/-
For every pair of non-negative integers \(x\) and \(y\), if \(15x + 11y\) is divisible by \(37\), then \(7x + 15y\) is divisible by \(37\).
-/

theorem divisibility_by_37 (x y : ℕ) (h : 37 ∣ 15 * x + 11 * y) : 37 ∣ 7 * x + 15 * y := by
  sorry
