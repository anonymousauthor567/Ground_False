import Mathlib

/-
The set of all positive integers \(n\) such that \(5^n > n!\) is \( n \in \{1, 2, \dots, 11\} \).
-/

theorem five_pow_gt_factorial_iff_le_eleven (n : ℕ) (hn : 0 < n) : 5^n > n! ↔ n ≤ 11 := by
  sorry
