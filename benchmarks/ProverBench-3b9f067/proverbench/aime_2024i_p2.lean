import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- Real numbers $x$ and $y$ with $x,y>1$ satisfy $\log_x(y^x)=\log_y(x^{4y})=10.$ Show that the value of $xy$ is 25.-/

theorem aime_2024i_p2 (x y : ℝ) (hx : 1 < x) (hy : 1 < y)
    (h₁ : Real.logb x (y ^ x) = 10) (h₂ : Real.logb y (x ^ (4 * y)) = 10) :
    x * y = 25 := by
  sorry
