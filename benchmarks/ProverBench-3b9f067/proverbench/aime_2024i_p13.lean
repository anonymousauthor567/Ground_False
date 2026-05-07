import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

def isSolution (p : ℕ) (n : ℕ) :=
  p.Prime ∧ 0 < n ∧ p ^ 2 ∣ n ^ 4 + 1

/-- Let $p$ be the least prime number for which there exists a positive integer $n$ such that $n^{4}+1$ is divisible by $p^{2}$. Find the least positive integer $m$ such that $m^{4}+1$ is divisible by $p^{2}$. Show that it is 110.-/

theorem aime_2024i_p13 (p m : ℕ) (h₀ : isSolution p m)
    (h₁ : ∀ q < p, ¬ (∃ (n : ℕ), isSolution q n))
    (h₂ : ∀ k < m, ¬ isSolution p k) :
    m = 110 := by
  sorry
