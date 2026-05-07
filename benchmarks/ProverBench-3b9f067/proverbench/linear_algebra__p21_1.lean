import Mathlib

/-
Let $A$ be an $n \times n$ matrix. If there exist two distinct rows (or columns) $i$ and $j$ of $A$, and a scalar $k \neq 0$
such that $a_{i,m} = k a_{j,m}$ (or $a_{m,i} = k a_{m,j}$) for all $m = 1, 2, \ldots, n$, then $\det(A) = 0$.
-/

open Matrix

variable {n : Type} [Fintype n] [DecidableEq n]
variable {R : Type} [CommRing R]

/-- Two rows are scalar multiples of each other. -/
def linearly_dependent_rows (A : Matrix n n R) (i j : n) (k : R) :=
  i ≠ j ∧ ∀ m : n, A i m = k * A j m

/-- Two columns are scalar multiples of each other. -/
def linearly_dependent_columns (A : Matrix n n R) (i j : n) (k : R) :=
  i ≠ j ∧ ∀ m : n, A m i = k * A m j

/-- If two rows or two columns are linearly dependent, then the determinant is zero. -/
theorem determinant_zero_if_linearly_dependent (A : Matrix n n R) (i j : n) (k : R) (h : k ≠ 0) :
  (linearly_dependent_rows A i j k) ∨ (linearly_dependent_columns A i j k) → det A = 0 := by
  sorry
