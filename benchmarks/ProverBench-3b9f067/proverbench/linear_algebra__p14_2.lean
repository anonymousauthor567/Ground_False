import Mathlib

/-
Let $\boldsymbol{A}$ and $\boldsymbol{B}$ be square matrices. If $\boldsymbol{A}$ and $\boldsymbol{B}$ are similar,
then their determinants are equal, i.e., $|\boldsymbol{A}| = |\boldsymbol{B}|$.
-/

open Matrix

universe u
variable {n : Type u} [Fintype n] [DecidableEq n]
variable {K : Type*} [Field K]

/-- Two matrices A and B are similar if there exists an invertible matrix P such that B = P⁻¹ * A * P. -/
def similar (A B : Matrix n n K) :=
∃ (P : Matrix n n K), IsUnit (det P) ∧ B = P⁻¹ * A * P

/-- The determinant of a product is the product of determinants. -/
axiom det_product_eq (X Y : Matrix n n K) : det (X * Y) = det X * det Y

/-- The determinant of an inverse matrix is the inverse of the determinant. -/
theorem det_inverse (P : Matrix n n K) [Invertible P] : det (P⁻¹) = (det P)⁻¹ := by
  sorry
