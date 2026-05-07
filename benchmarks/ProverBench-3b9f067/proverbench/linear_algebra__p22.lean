import Mathlib

/-
Given that L:ℝ³→ℝ² and K:ℝ²→ℝ⁴ are two linear transformations.
Let M=K∘L.
If the matrix of L is [[3, -2, 6], [-5, -3, 2]],
the matrix of K is [[9, -2], [4, -3], [-5, 3], [-9, 7]],
and the matrix of M is [[37, -12, 50], [27, 1, 18], [-30, 1, -24], [-62, -3, -40]],
then m₁₁ + m₂₂ + m₃₃ - m₄₁ - m₄₂ - m₄₃ = 119.
-/

variable {L : (Fin 3 → ℝ) →ₗ[ℝ] (Fin 2 → ℝ)} {K : (Fin 2 → ℝ) →ₗ[ℝ] (Fin 4 → ℝ)}

def matrixL : Matrix (Fin 2) (Fin 3) ℝ := ![![3, -2, 6], ![-5, -3, 2]]
def matrixK : Matrix (Fin 4) (Fin 2) ℝ := ![![9, -2], ![4, -3], ![-5, 3], ![-9, 7]]
def matrixM : Matrix (Fin 4) (Fin 3) ℝ := ![![37, -12, 50], ![27, 1, 18], ![-30, 1, -24], ![-62, -3, -40]]

theorem specificElementSumDifference :
 matrixM 0 0 + matrixM 1 1 + matrixM 2 2 - matrixM 3 0 - matrixM 3 1 - matrixM 3 2 = 119 := by
  sorry
