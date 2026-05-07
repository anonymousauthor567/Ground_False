import Mathlib

/-
Let $A$ be an $m \times n$ matrix. $A$ is said to be a column full rank matrix if and only if $\text{rank}(A) = n$, where $n$ is the number of columns in $A$.
-/

open Matrix LinearMap

variable {K : Type*} [Field K] {m n : Type*} [Fintype m] [Fintype n]

/-- A matrix A is said to be column full rank if its columns are linearly independent. -/
def column_full_rank (A : Matrix m n K) : Prop := LinearIndependent K (fun i => A i)

/-- An m × n matrix A is a column full rank matrix if and only if rank(A) = n. -/
axiom column_full_rank_iff_rank_eq_card :
∀ (A : Matrix m n K), column_full_rank A ↔ Matrix.rank A = Fintype.card n

/-- If the columns of an m × n matrix A are linearly independent, then rank(A) = n. -/
axiom column_full_rank_implies_rank_eq_card (A : Matrix m n K) :
column_full_rank A → Matrix.rank A = Fintype.card n

/-- If rank(A) = n for an m × n matrix A, then the columns of A are linearly independent. -/
theorem rank_eq_card_implies_column_full_rank (A : Matrix m n K) :
Matrix.rank A = Fintype.card n → column_full_rank A := by
  sorry
