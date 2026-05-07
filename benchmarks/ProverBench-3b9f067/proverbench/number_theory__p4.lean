import Mathlib

/-
For every prime number \(p\), if \(p\mid x^2-x+3\) for some integer \(x\), then \(p\mid y^2-y+25\) for some integer \(y\), and vice versa.
-/

variable {p : ℤ} (hp : Prime p)

theorem prime_divisibility_condition (x y : ℤ) :
  (∃ x, p ∣ x^2 - x + 3) ↔ (∃ y, p ∣ y^2 - y + 25) := by
  sorry
