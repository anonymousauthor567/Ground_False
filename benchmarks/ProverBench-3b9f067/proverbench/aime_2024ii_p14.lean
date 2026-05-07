import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

def beautifulSet (b : ℕ) : Finset (ℕ × ℕ) :=
  Finset.filter (λ (d₁, d₂) => (d₁ + d₂) ^ 2 = d₁ * b + d₂)
  (Finset.product (Finset.Ico 1 b) (Finset.Ico 0 b))

/-- Let $b \geq 2$ be an integer. Call a positive integer $n$ $b\textit{-eautiful}$ if it has exactly two digits when expressed in base $b$, and these two digits sum to $\sqrt{n}$. For example, $81$ is $13$-eautiful because $81=\underline{6}$ $\underline{3}_{13}$ and $6+3=\sqrt{81}$. Find the least integer $b\geq 2$ for which there are more than ten $b$-eautiful integers. Show that it is 211.-/

theorem aime_2024ii_p14 (b : ℕ) (h₀ : 2 ≤ b)
    (h₁ : (beautifulSet b).card ≥ 10)
    (h₂ : ∀ c ∈ Finset.Ico 2 b, (beautifulSet c).card < 10) :
    b = 211 := by
  sorry
