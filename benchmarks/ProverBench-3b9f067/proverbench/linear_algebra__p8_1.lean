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

-- Define the coefficient matrix A of the system of linear equations
def coeff_matrix : Matrix (Fin 4) (Fin 3) ℚ :=
![![ -19,  8,  0],
  ![ -71, 30,  0],
  ![ -2,   1,  0],
  ![  4,   0,  1]]

-- Define the augmented matrix [A | b] of the system of linear equations
def aug_matrix : Matrix (Fin 4) (Fin 4) ℚ :=
![![ -19,  8,  0, -108],
  ![ -71, 30,  0, -404],
  ![ -2,   1,  0, -12],
  ![  4,   0,  1,  14]]

-- Prove that the rank of both the coefficient matrix A and the augmented matrix [A | b] is 2

lemma rank_of_matrix : rank coeff_matrix = 2 ∧ rank aug_matrix = 2 := by
  sorry
