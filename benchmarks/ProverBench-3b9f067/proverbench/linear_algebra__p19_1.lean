import Mathlib

/-
Let $\boldsymbol{A}$ and $\boldsymbol{B}$ be matrices of appropriate dimensions. The matrix equation $\boldsymbol{A} \boldsymbol{X}=\boldsymbol{B}$ has a solution if and only if $r(\boldsymbol{A})=r(\boldsymbol{A}, \boldsymbol{B})$, where $r(\boldsymbol{A})$ denotes the rank of matrix $\boldsymbol{A}$, and $r(\boldsymbol{A}, \boldsymbol{B})$ denotes the rank of the augmented matrix $[\boldsymbol{A} \mid \boldsymbol{B}]$.
-/

open LinearAlgebra
open Matrix

variable {m n p : Type} [Fintype m] [Fintype n] [Fintype p]
variable {R : Type} [CommRing R]

lemma rankConditionIfSolutionExists (A : Matrix m n R) (B : Matrix m p R) :
(∃ X : Matrix n p R, A * X = B) → rank A = rank (fromColumns A B) := by
  sorry
