import Mathlib

/-
A monic polynomial of fourth degree satisfies \(f(1)=10\), \(f(2)=20\) and \(f(3)=30\). The sum of \(f(12)\) and \(f(-8)\) for this polynomial is 19840.
-/

variable (f : Polynomial ℤ) (hf_monic : f.Monic) (hf_degree : f.degree = 4)

theorem polynomial_evaluation_sum (h1 : f.eval 1 = 10) (h2 : f.eval 2 = 20) (h3 : f.eval 3 = 30) :
  f.eval 12 + f.eval (-8) = 19840 := by
  sorry
