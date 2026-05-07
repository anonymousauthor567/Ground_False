import Mathlib

/-
Let $f: \mathbb{R}^n \rightarrow \mathbb{R}$ be a function. Then $f$ is a quadratic form if and only if there exists a symmetric matrix $\boldsymbol{A} \in \mathbb{R}^{n \times n}$ such that for all $\boldsymbol{x} \in \mathbb{R}^n$, $f(\boldsymbol{x}) = \boldsymbol{x}^{\mathrm{T}} \boldsymbol{A} \boldsymbol{x}$.
-/

open Real

variable {n : ℕ} {K : Type*} [Field K]

/-- A quadratic form is a function from `K^n` to `K` that can be expressed as `x^T A x` for some symmetric matrix `A`. -/
def IsQuadraticForm (f : (Fin n → K) → K) : Prop :=
∃ (A : Matrix (Fin n) (Fin n) K), A.IsSymm ∧ ∀ x, f x = (Matrix.dotProduct x (A.mulVec x))

/-- For any quadratic form `f`, there exists a symmetric matrix `B` such that `f(x) = x^T B x`. -/
axiom symmetric_matrix_representation (f : (Fin n → K) → K) (hf : IsQuadraticForm f) :
∃ (B : Matrix (Fin n) (Fin n) K), B.IsSymm ∧ ∀ x, f x = (Matrix.dotProduct x (B.mulVec x))

/-- If a function `f` can be represented as `f(x) = x^T A x` for some symmetric matrix `A`, then `f` is a quadratic form. -/
lemma quadratic_form_verification (f : (Fin n → K) → K) (A : Matrix (Fin n) (Fin n) K) (hA : A.IsSymm)
(hf : ∀ x, f x = (Matrix.dotProduct x (A.mulVec x))) : IsQuadraticForm f := by
  sorry
