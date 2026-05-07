import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

noncomputable def f (k x : ℝ) : ℝ :=
  (x - 18) * (x - 72) * (x - 98) * (x - k) / x

def exactly_two_minima (k : ℝ) : Prop := 
  ∃ (a b : ℝ), 0 < a ∧ 0 < b ∧ a ≠ b ∧ (f k a = f k b) ∧
  (∀ (x : ℝ), (0 < x) → (f k x > f k a ∨ x = b))

/-- There are exactly three positive real numbers $k$ such that the function
$$f(x) = \frac{(x - 18)(x - 72)(x - 98)(x - k)}{x}$$
defined over the positive real numbers achieves its minimum value at exactly two positive real numbers $x$. Find the sum of these three values of $k$. Show that it is 240.-/

theorem aime_2025ii_p15 : ∃ (k₁ k₂ k₃ : ℝ),
    0 < k₁ ∧ 0 < k₂ ∧ 0 < k₃ ∧ k₁ ≠ k₂ ∧ k₁ ≠ k₃ ∧ k₂ ≠ k₃ ∧
    exactly_two_minima k₁ ∧ exactly_two_minima k₂ ∧ exactly_two_minima k₃ ∧
    k₁ + k₂ + k₃ = 240 := by
  sorry
