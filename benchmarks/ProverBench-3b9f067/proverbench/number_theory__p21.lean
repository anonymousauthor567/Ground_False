import Mathlib

/-
The number of ordered pairs \((x,y)\) of integers satisfying \[x^2+xy+y^2\leq 2012.\] is not divisible by \(3\).
-/

def quadraticFormPoints (n : ℕ) := {(x, y) : ℤ × ℤ | x^2 + x*y + y^2 ≤ n}

/-- Count points satisfying x^2 + xy + y^2 ≤ n -/
def countPoints (n : ℕ) : ℕ :=
 Finset.card (Finset.filter (fun p : ℤ × ℤ =>
   p.1^2 + p.1*p.2 + p.2^2 ≤ n)
   (Finset.product (Finset.Ico (-n) (n+1)) (Finset.Ico (-n) (n+1))))

theorem count_not_div_three : ¬(3 ∣ countPoints 2012) := by
  sorry
