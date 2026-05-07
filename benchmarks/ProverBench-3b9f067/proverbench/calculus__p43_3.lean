import Mathlib

/-
Let $y(t) = 40t - 16t^2$ represent the height in feet of a ball $t$ seconds after being thrown vertically upward with an initial velocity of 40 ft/s. Then the average velocity $v_{avg}$ of the ball over the time interval $[2, 2.5]$ seconds is given by:

    $v_{avg} = \frac{y(2.5) - y(2)}{2.5 - 2} = -32 \text{ ft/s}$
-/

open Real

noncomputable def heightFunction (t : ℝ) : ℝ := 40 * t - 16 * t^2

axiom heightAtTwo : heightFunction 2 = 16

axiom heightAtTwoPointFive : heightFunction 2.5 = 0

theorem averageVelocity : (heightFunction 2.5 - heightFunction 2) / (2.5 - 2) = -32 := by
  sorry
