import Mathlib

/-
The polynomial \(P\) of \(n\)-th degree that takes the value 1 in points \(0,2,4,\dots,2n\), takes the value \(1\) at \(x=-1\).
-/

open Polynomial

variable {P : Polynomial ℤ} {n : ℕ} (hP : P.natDegree = n)

theorem polynomial_roots_bound :
(∀ k : ℕ, k ≤ 2 * n → P.eval (2 * (Int.ofNat k)) = 1) → P.eval (-1) = 1 →
  (P - 1).roots.toFinset.card ≤ n + 1 := by
  sorry
