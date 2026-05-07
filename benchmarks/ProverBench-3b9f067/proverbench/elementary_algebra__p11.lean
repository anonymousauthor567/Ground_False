import Mathlib

/-
The positive integers \(n\) for which \(5^n >  n!\) belong to the set \(\{1,2,\dots, 11\}\).
-/

theorem power_and_factorial_range : ∀ (n : ℕ), n > 0 → (5^n > n.factorial ↔ n ≤ 11) := by
  sorry
