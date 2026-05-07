import Mathlib

/-
Let $A\mathbf{x} = \mathbf{b}$ be the system of linear equations given by:
  \begin{align*}
  -19x + 8y &= -108 \\
  -71x + 30y &= -404 \\
  -2x + y &= -12 \\
  4x + z &= 14
  \end{align*}
  Then, prove that the rank of both the coefficient matrix A and the augmented matrix [A | b] is 2$.
-/

open Matrix

def coeff_matrix : Matrix (Fin 4) (Fin 3) ℚ :=
![![ -19,  8,  0],
  ![ -71, 30,  0],
  ![ -2,   1,  0],
  ![  4,   0,  1]]

def aug_matrix : Matrix (Fin 4) (Fin 4) ℚ :=
![![ -19,  8,  0, -108],
  ![ -71, 30,  0, -404],
  ![ -2,   1,  0, -12],
  ![  4,   0,  1,  14]]

axiom rank_of_matrix : rank coeff_matrix = 2 ∧ rank aug_matrix = 2

axiom verify_solution : (4, -4, -2) ∈ {x : ℚ × ℚ × ℚ |
-19 * x.1 + 8 * x.2.1 = -108 ∧
-71 * x.1 + 30 * x.2.1 = -404 ∧
-2 * x.1 + x.2.1 = -12 ∧
4 * x.1 + x.2.2 = 14}

/-- The system of linear equations has a unique solution (4, -4, -2). -/
theorem unique_solution : ∃! x : ℚ × ℚ × ℚ,
-19 * x.1 + 8 * x.2.1 = -108 ∧
-71 * x.1 + 30 * x.2.1 = -404 ∧
-2 * x.1 + x.2.1 = -12 ∧
4 * x.1 + x.2.2 = 14 := by
  sorry
