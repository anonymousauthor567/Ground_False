import Mathlib

/-
For any prime number \(p\equiv1\) (mod 6), there exist \(a,b\in\mathbb{Z}\) such that \(p=a^2-ab+b^2\).
-/

theorem prime_congruent_1_mod_6_has_quadratic_form (p : ℤ) (hp : Prime p) (hp_mod_6 : p % 6 = 1) :
  ∃ (a b : ℤ), p = a^2 - a * b + b^2 := by
  sorry
