import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

def S : Finset (ℕ × ℕ × ℕ × ℕ) :=
  Finset.filter (λ (a, b, c, d) =>
    7 ∣ 1000 + 100 * b + 10 * c + d ∧
    7 ∣ 1000 * a + 100 + 10 * c + d ∧
    7 ∣ 1000 * a + 100 * b + 10 + d ∧
    7 ∣ 1000 * a + 100 * b + 10 * c + 1
  )
  (Finset.product (Finset.Icc 1 9) (Finset.product
    (Finset.Icc 0 9) (Finset.product
      (Finset.Icc 0 9) (Finset.Icc 0 9)
    )
  ))

/-- Let $N$ be the greatest four-digit integer with the property that whenever one of its digits is changed to $1$, the resulting number is divisible by $7$. Let $Q$ and $R$ be the quotient and remainder, respectively, when $N$ is divided by $1000$. Show that $Q+R=699$.-/

theorem aime_2024ii_p7 (n : ℕ)
    (h₀ : IsGreatest {x : ℕ | ∃ abcd ∈ S, x = 1000 * abcd.1 + 100 * abcd.2.1 + 10 * abcd.2.2.1 + abcd.2.2.2} n) :
    n / 1000 + n % 1000 = 699 := by
  sorry
