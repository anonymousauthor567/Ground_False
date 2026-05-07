import Mathlib

/-
Let $A$ be a real $2 \times 2$ matrix. Then the determinant of $A^2$ is always nonnegative, i.e., $\det(A^2) \geq 0$.
-/

open Matrix

variable (A : Matrix (Fin 2) (Fin 2) ℝ)

/-- The determinant of A^2 is the square of the determinant of A. -/
lemma det_A_sq : det (A * A) = (det A) ^ 2 := by
  sorry
