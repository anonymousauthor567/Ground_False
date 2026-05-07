import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Let $k$ be a real number such that the system
\begin{align*} |25+20i-z|&=5\\ |z-4-k|&=|z-3i-k| \\ \end{align*}
has exactly one complex solution $z$. The sum of all possible values of $k$ can be written as $\frac{m}{n},$ where $m$ and $n$ are relatively prime positive integers. Find $m+n$. Here $i=\sqrt{-1}$. Show that it is 77.-/

theorem aime_2025i_p8 (ans : ℚ) (S : Finset ℝ)
    (h₀ : ∀ k : ℝ, k ∈ S ↔ (∃! (z : ℂ),
      Complex.abs (25 + 20 * Complex.I - z) = 5 ∧
      Complex.abs (z - 4 - k) = Complex.abs (z - 3 * Complex.I - k)
    ))
    (answer : ans = (∑ k in S, k)) :
    ↑ans.den + ans.num = 77 := by
  sorry
