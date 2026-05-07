import Mathlib

/-
Let $(x, y, z) \in \mathbb{R}^3$. If $(x, y, z)$ satisfies the system of equations:
  \begin{align*}
  -9x + 15y &= 66 \\
  -11x + 18y &= 79 \\
  -x + y &= 4 \\
  z &= 3
  \end{align*}
  then $x = 1$, $y = 5$, and $z = 3$.
-/

open Classical

-- Define the system of equations
def A : Matrix (Fin 3) (Fin 2) ℝ :=
![![-9, 15], ![-11, 18], ![-1, 1]]

def b : Fin 3 → ℝ := ![66, 79, 4]

def solution : Fin 2 → ℝ := ![1, 5]

theorem unique_solution' :
  ∃! (x : Fin 2 → ℝ), A.mulVec x = b ∧ x = solution := by
  sorry
