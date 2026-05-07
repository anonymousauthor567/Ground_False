import Mathlib

/-
Let $\boldsymbol{A}$ and $\boldsymbol{B}$ be any two non-zero matrices such that $\boldsymbol{A}\boldsymbol{B} = \boldsymbol{O}$, where $\boldsymbol{O}$ is the zero matrix. Then, the column vectors of $\boldsymbol{A}$ are linearly dependent, and the row vectors of $\boldsymbol{B}$ are linearly dependent.
-/

open Matrix

variable {m n p : ℕ}
variable (A : Matrix (Fin m) (Fin n) ℝ)
variable (B : Matrix (Fin n) (Fin p) ℝ)

-- Prove `Null Space Non-Triviality`

lemma null_space_non_trivial (hAB : A * B = 0) (hA : A ≠ 0) : ¬LinearIndependent ℝ (fun i => A i) := by
  sorry
