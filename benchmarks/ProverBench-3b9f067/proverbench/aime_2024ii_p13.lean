import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Let $\omega\neq 1$ be a 13th root of unity. Find the remainder when
\[
\prod_{k=0}^{12}(2-2\omega^k+\omega^{2k})
\]
is divided by 1000. Show that it is 321.-/

theorem aime_2024ii_p13 (ω : ℂ) (h₀ : ω = Complex.exp (2 * ↑Real.pi * Complex.I / 13)) :
    (∏ k in Finset.range 13, (2 - 2 * ω ^ k + ω ^ (2 * k))) % 1000 = 321 := by
  sorry
