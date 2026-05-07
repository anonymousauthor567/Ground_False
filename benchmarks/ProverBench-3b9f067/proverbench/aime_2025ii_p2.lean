import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Find the sum of all positive integers $n$ such that $n+2$ divides the product $3(n+3)(n^2+9)$. Show that it is 49.-/

theorem aime_2025ii_p2 (S : Finset ℕ)
    (h₀ : ∀ (n : ℕ), n ∈ S ↔ (n + 2) ∣ 3 * (n + 3) * (n ^ 2 + 9)) :
    (∑ n in S, n) = 49 := by
  sorry
