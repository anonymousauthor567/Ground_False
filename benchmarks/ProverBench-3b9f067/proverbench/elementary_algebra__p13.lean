import Mathlib

/-
Given positive numbers \(a,b,c,x,y,z\) such that \(a+x=b+y=c+z=S\), prove that \(ay+bz+cx <  S^2\).
-/

variable {a b c x y z : ℝ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z)

variable (S : ℝ) (hS : a + x = S ∧ b + y = S ∧ c + z = S)

theorem imoProblem : a * y + b * z + c * x < S ^ 2 := by
  sorry
