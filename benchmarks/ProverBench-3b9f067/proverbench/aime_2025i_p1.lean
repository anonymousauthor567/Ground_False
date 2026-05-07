import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Find the sum of all integer bases $b>9$ for which $17_b$ is a divisor of $97_b$. Show that it is 70.-/

theorem aime_2025i_p1 (S : Finset ℕ)
    (h₀ : ∀ (b : ℕ), b ∈ S ↔ b > 9 ∧ b + 7 ∣ 9 * b + 7) :
    (∑ b in S, b) = 70 := by
  sorry
