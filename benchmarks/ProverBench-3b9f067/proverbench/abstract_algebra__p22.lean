import Mathlib

/-
For all sequences \(x_1, \dots, x_n \in [-\pi/6,\pi/6]\), the inequality \(\cos(2x_1-x_2)+\cos(2x_2-x_3)+\cdots + \cos(2x_n-x_1)\leq \cos x_1+\cdots + \cos x_n\) is satisfied.
-/

open Real
open BigOperators

variable (n : ℕ) (x : Fin (n + 1) → ℝ) (hx : ∀ i, -π/6 ≤ x i ∧ x i ≤ π/6)

theorem cosine_inequality :
∑ i : Fin n, cos (2 * x i - x (i.succ)) ≤ ∑ i : Fin (n + 1), cos (x i) := by
  sorry
