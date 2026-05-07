import Mathlib

/-
Let $A$ be a 2x2 matrix defined as $A=\begin{bmatrix} 0 & 1 \\ 5 & 3 \end{bmatrix}$. Then $A$ is invertible,
and its inverse is given by $A^{-1}=\begin{bmatrix} -\frac{3}{5} & \frac{1}{5} \\ 1 & 0 \end{bmatrix}$.
-/

open Matrix

/-- Define the matrix A -/
def A : Matrix (Fin 2) (Fin 2) ℝ := ![![0, 1], ![5, 3]]

/-- Define the proposed inverse matrix A⁻¹ -/
noncomputable def A_inv : Matrix (Fin 2) (Fin 2) ℝ :=
  ![![(-3/5 : ℝ), (1/5 : ℝ)], ![1, 0]]

/-- Verify that A⁻¹ is indeed the inverse of A -/
lemma verify_inverse : A * A_inv = 1 ∧ A_inv * A = 1 := by
  sorry
