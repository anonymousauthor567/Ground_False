import Mathlib

/-
Dirichlet’s theorem: Let \(\alpha\) be an irrational number and \(n\) be a positive
integer. There exist \(p\in\mathbb{Z}\) and \(q\in\{1,2,\dots,n\}\) such that \(\left|\alpha-\frac pq\right| < \frac1{(n+1)q}\).
-/

variable {α : ℝ} {n : ℕ}

def dirichlet_approximation : Set (ℤ × ℕ) :=
  {p | p.2 ∈ Finset.range n ∧ p.2 ≠ 0 ∧ |α - (p.1:ℝ)/p.2| < 1/((n + 1) * p.2)}

theorem dirichlet_theorem' {α : ℝ} (hα : Irrational α) {n : ℕ} (hn : 0 < n) :
  ∃ p q : ℤ, 0 < q ∧ q ≤ n ∧ |α - p/q| < 1/((n + 1) * q) := by
  sorry
