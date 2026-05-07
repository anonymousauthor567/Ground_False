import Mathlib

/-
The characteristic of the ring $\mathbb{Z}_3 \times \mathbb{Z}_3$ is 3.
-/

open ZMod

/-- The ring Z3 is the set of integers modulo 3. -/
def Z3 : Type := ZMod 3

/-- The ring Z3 × Z3 consists of pairs (a, b) where a, b ∈ Z3, with component-wise addition and multiplication. -/
def Z3xZ3 : Type := ZMod 3 × ZMod 3

lemma scalar_multiplication (n : ℕ) (a b : ZMod 3) : n • (a, b) = (n • a, n • b) := sorry

lemma multiple_of_3 (n : ℕ) (a : ZMod 3) : (a ≠ 0 → (n • a = 0 ↔ n % 3 = 0)) := sorry

noncomputable def evalChar := ringChar (ZMod 3 × ZMod 3)

/-- The characteristic of the ring Z3 × Z3 is 3. -/
theorem characteristic_Z3xZ3 : evalChar = 3 := by
  sorry
