import Mathlib

/-
Let $\boldsymbol{A}$ be an $n \times n$ invertible matrix. Then the determinant of its inverse matrix $\boldsymbol{A}^{-1}$ is
given by $\left|\boldsymbol{A}^{-1}\right| = \frac{1}{|\boldsymbol{A}|}$.
-/

open Matrix

variable {n : Type} [Fintype n] [DecidableEq n]

axiom det_identity : det (1 : Matrix n n ℝ) = 1

axiom det_mul (A B : Matrix n n ℝ) : det (A * B) = det A * det B

theorem det_inv (A : Matrix n n ℝ) [Invertible A] : det A⁻¹ = (det A)⁻¹ := by
  sorry
