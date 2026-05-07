import Mathlib

/-
Let $\boldsymbol{A}$ and $\boldsymbol{B}$ be any two non-zero matrices such that $\boldsymbol{A}\boldsymbol{B} = \boldsymbol{O}$, where $\boldsymbol{O}$ is the zero matrix. Then, the column vectors of $\boldsymbol{A}$ are linearly dependent, and the row vectors of $\boldsymbol{B}$ are linearly dependent.
-/

open Matrix

variable {m n p : ℕ}
variable (A : Matrix (Fin m) (Fin n) ℝ)
variable (B : Matrix (Fin n) (Fin p) ℝ)

-- Prove `Null Space Non-Triviality`
axiom null_space_non_trivial (hAB : A * B = 0) (hA : A ≠ 0) : ¬LinearIndependent ℝ (fun i => A i)

-- Prove `Transpose and Linear Dependence`
axiom transpose_linear_dependence (hAB : A * B = 0) (hB : B ≠ 0) : ¬LinearIndependent ℝ (fun i => Bᵀ i)

/-- If `A * B = 0` for non-zero matrices `A` and `B`, then the columns of `A` are linearly dependent and the rows of `B` are linearly dependent. -/
theorem matrix_product_zero_implies_dependence (hAB : A * B = 0) (hA : A ≠ 0) (hB : B ≠ 0) :
  (¬LinearIndependent ℝ (fun i => A i)) ∧ (¬LinearIndependent ℝ (fun i => Bᵀ i)) := by
  sorry
