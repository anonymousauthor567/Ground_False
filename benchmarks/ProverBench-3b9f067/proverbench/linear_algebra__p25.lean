import Mathlib

/-
Let $A$ be a 3x3 matrix defined as
  $$A = \begin{pmatrix}
  2 & 1 & 3 \\
  2 & 4 & 2 \\
  1 & 4 & -5
  \end{pmatrix}$$
  Then, the determinant of $A$ is equal to -32, i.e., $\det(A) = -32$.
-/

open Matrix

-- Define the matrix A
def A : Matrix (Fin 3) (Fin 3) ℝ := !![
  2, 1, 3;
  2, 4, 2;
  1, 4, -5
]

-- Prove the determinant of A

theorem det_A : det A = -32 := by
  sorry
