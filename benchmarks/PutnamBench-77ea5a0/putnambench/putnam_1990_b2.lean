import Mathlib

open Filter Topology Nat


/-Informal Statement

Prove that for $|x|<1$, $|z|>1$, $1+\sum_{j=1}^\infty (1+x^j)P_j=0$, where $P_j$ is $\frac{(1-z)(1-zx)(1-zx^2) \cdots (1-zx^{j-1})}{(z-x)(z-x^2)(z-x^3) \cdots (z-x^j)}$.
-/

theorem putnam_1990_b2
(x z : ℝ)
(P : ℕ → ℝ)
(xlt1 : |x| < 1)
(zgt1 : |z| > 1)
(hP : ∀ j ≥ 1, P j = (∏ i : Fin j, (1 - z * x ^ (i : ℕ))) / (∏ i : Set.Icc 1 j, (z - x ^ (i : ℕ))))
: 1 + (∑' j : Set.Ici 1, (1 + x ^ (j : ℕ)) * P j) = 0 := by
  sorry
