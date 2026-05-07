import Mathlib

/-
 If A and B are two n	times n matrices such that AB=BA,
 and if u is an eigenvector of B, then Au is an eigenvector of B
 as well.} \
-/

variable {n : Type} [Fintype n] [DecidableEq n] {A B : Matrix n n ℂ}

variable {u : n → ℂ} (hu : u ≠ 0) (hAB : A * B = B * A)

open Matrix

-- Assuming IsEigenvector is defined or imported correctly
def IsEigenvector (M : Matrix n n ℂ) (v : n → ℂ) (eigenvalue : ℂ) := M.mulVec v = eigenvalue • v

theorem eigenvector_preserved_under_commuting_matrix
(lambda : ℂ) (hB : IsEigenvector B u lambda) :
∃ (lambda' : ℂ), IsEigenvector B (A.mulVec u) lambda' := by
  sorry
