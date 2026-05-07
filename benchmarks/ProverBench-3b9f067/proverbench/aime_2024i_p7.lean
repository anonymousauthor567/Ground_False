import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Find the largest possible real part of \[(75+117i)z+\frac{96+144i}{z}\] where $z$ is a complex number with $|z|=4$. Show that it is 540.-/

theorem aime_2024i_p7 (f : ℂ → ℂ)
    (h₀ : ∀ (z : ℂ), f z = (75 + 117 * Complex.I) * z + (96 + 144 * Complex.I) / z) :
    IsGreatest {x : ℝ | ∃ (z : ℂ), Complex.abs z = 4 ∧ (f z).re = x} 540 := by
  sorry
