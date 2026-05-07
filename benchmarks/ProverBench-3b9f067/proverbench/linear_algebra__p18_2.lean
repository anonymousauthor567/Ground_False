import Mathlib

/-
Let $\boldsymbol{A}$ be a matrix and $\boldsymbol{x}$ be a vector such that $\boldsymbol{A x}=\mathbf{0}$ is a homogeneous system
of linear equations. If $\boldsymbol{\xi}$ is a solution to this system, then for any scalar $k \in \mathbb{R}$, the vector $k
\boldsymbol{\xi}$ is also a solution to the system.
-/

open LinearMap

variable {R : Type*} [Field R] -- R is a field
variable {n : Type*} [Fintype n] [DecidableEq n] -- n is a finite type with decidable equality
variable (A : Matrix n n R) -- Matrix A
variable (ξ : n → R) -- Vector ξ
variable (k : R) -- Scalar k

/-- A homogeneous system of linear equations A x = 0 -/
def HomogeneousSystem (A : Matrix n n R) (x : n → R) : Prop := A.mulVec x = 0

/-- Lemma: Scalar multiplication distributes over matrix-vector multiplication -/
axiom mulVec_smul (A : Matrix n n R) (k : R) (x : n → R) :
A.mulVec (k • x) = k • (A.mulVec x)

/-- Theorem: If ξ is a solution to the homogeneous system A x = 0,
    then for any scalar k, the vector k ξ is also a solution to the system. -/
theorem homogeneous_system_solution_scalar_multiplication
(h : HomogeneousSystem A ξ) (k : R) : HomogeneousSystem A (k • ξ) := by
  sorry
