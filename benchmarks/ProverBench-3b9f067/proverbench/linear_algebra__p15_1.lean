import Mathlib

/-
Let $\mathbf{v}$ and $\mathbf{u}$ be vectors in $\mathbb{R}^3$. Then there exists a unique decomposition $\mathbf{v} = \mathbf{a}
+ \mathbf{b}$, where $\mathbf{a}$ is parallel to $\mathbf{u}$ and $\mathbf{b}$ is orthogonal to $\mathbf{u}$. Moreover,
$\mathbf{a} = \frac{\mathbf{v} \cdot \mathbf{u}}{\|\mathbf{u}\|^2} \mathbf{u}$ and $\mathbf{b} = \mathbf{v} - \mathbf{a}$.
-/

open InnerProductSpace

variable {E : Type} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
variable (v u : E)

/-- A vector a is parallel to u if a = l u for some scalar l. -/
def isParallel (a u : E) : Prop := ∃ (l : ℝ), a = l • u

/-- A vector b is orthogonal to u if ⟪b, u⟫ = 0. -/
def isOrthogonal (b u : E) : Prop := ⟪b, u⟫_ℝ = 0

/-- The decomposition of v into components parallel and orthogonal to u. -/
noncomputable def decomposition (v u : E) : E × E :=
let l := ⟪v, u⟫_ℝ / ‖u‖^2;
(l • u, v - l • u)

theorem vector_decomposition (hu : u ≠ 0) :
    let (a, b) := decomposition v u
v = a + b ∧ isParallel a u ∧ isOrthogonal b u := by
  sorry
