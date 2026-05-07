import Mathlib

/-
Let $A = \{(m, n) \in \mathbb{Z}^2 : 7m + 12n = 22\}$ and $B = \{m + n : (m, n) \in A\}$. Then the greatest negative element in set $B$ is $-4$.
-/

open Int

/-- The set A of integer pairs (m, n) satisfying 7m + 12n = 22 -/
def A : Set (Int × Int) := {(m, n) | 7 * m + 12 * n = 22}

/-- The set B of sums m + n where (m, n) is in A -/
def B : Set Int := {z | ∃ (m n : Int), (m, n) ∈ A ∧ z = m + n}

/-- Lemma: Particular solution to 7m + 12n = 22 -/
axiom particular_solution : ∃ m n : Int, 7 * m + 12 * n = 22

/-- Lemma: General solution to 7m + 12n = 22 -/
axiom general_solution (k : Int) : ∃ m n : Int, m = -110 + 12 * k ∧ n = 66 - 7 * k ∧ 7 * m + 12 * n = 22

/-- Lemma: Characterization of elements in B -/
lemma characterize_B : ∀ b : Int, b ∈ B ↔ ∃ k : Int, b = -44 + 5 * k := by
  sorry
