import Mathlib

/-
For any matrix $A \in \mathbb{F}^{m \times n}$ over a field $\mathbb{F}$, the row rank of $A$ is equal to its column rank. That is, $\text{rank}(A) = \text{rank}(A^T)$, where $A^T$ denotes the transpose of $A$.
-/

open LinearMap Matrix

variable {m n : Type*} [Fintype m] [Fintype n] {F : Type*} [Field F] (A : Matrix m n F)

-- Define row space and column space
def row_space (A : Matrix m n F) : Submodule F (n → F) :=
  Submodule.span F (Set.range (fun i => A i))

def column_space (A : Matrix m n F) : Submodule F (m → F) :=
  Submodule.span F (Set.range (fun j i => A i j))

-- Lemma of Transpose Space Equivalence
axiom transpose_space_equivalence :
row_space A = column_space (transpose A) ∧ column_space A = row_space (transpose A)

-- Theorem of Rank Equivalence

theorem rank_equivalence : Matrix.rank A = Matrix.rank (transpose A) := by
  sorry
