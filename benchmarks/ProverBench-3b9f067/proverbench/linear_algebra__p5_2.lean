import Mathlib

/-
Let $A$ be an $n \times n$ matrix and let $A'$ be the matrix obtained from $A$ by interchanging any two rows or any two columns.
Then $\det(A') = -\det(A)$.
-/

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

def swapRows {R : Type*} [CommRing R] (A : Matrix n n R) (i j : n) : Matrix n n R :=
fun (k l : n) => if k = i then A k j else if k = j then A k i else A k l

def swapColumns {R : Type*} [CommRing R] (A : Matrix n n R) (i j : n) : Matrix n n R :=
fun (k l : n) => if l = i then A k j else if l = j then A k i else A k l

-- The determinant of a matrix changes sign when two rows are interchanged.
axiom det_row_interchange {R : Type*} [CommRing R] (A : Matrix n n R) (i j : n) (h : i ≠ j) :
  det (swapRows A i j) = -det A

-- The determinant of a matrix changes sign when two columns are interchanged.

theorem det_column_interchange {R : Type*} [CommRing R] (A : Matrix n n R) (i j : n) (h : i ≠ j) :
  det (swapColumns A i j) = -det A := by
  sorry
