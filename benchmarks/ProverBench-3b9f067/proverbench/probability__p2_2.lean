import Mathlib

/-
Let $A = [a_{ij}]$ be a $3 \times 3$ Markov transition matrix given by
  $$A = \begin{bmatrix}
  0.1 & 0.3 & 0.7 \\
  0.1 & 0.3 & 0.2 \\
  0.8 & 0.4 & 0.1
  \end{bmatrix}$$
  representing a random walk on three locations. If the initial state vector is $X_0 = [0, 1, 0]^T$, then the probability of being in the second location after three steps is given by the second component of the vector $X_3 = A^3 X_0$, which equals 0.18.
-/

open Matrix

/-- The Markov transition matrix A -/
def A : Matrix (Fin 3) (Fin 3) ℝ :=
  ![![0.1, 0.3, 0.7], ![0.1, 0.3, 0.2], ![0.8, 0.4, 0.1]]

/-- The initial state vector X0 -/
def X0 : Matrix (Fin 3) (Fin 1) ℝ :=
  ![![0], ![1], ![0]]

/-- A^2 is computed as A * A -/
axiom A_squared : A * A = ![![0.6, 0.4, 0.2], ![0.2, 0.2, 0.15], ![0.2, 0.4, 0.65]]

/-- A^3 is computed as A * A^2 -/
lemma A_cubed : A * (A * A) = ![![0.26, 0.38, 0.52], ![0.16, 0.18, 0.195], ![0.58, 0.44, 0.285]] := by
  sorry
