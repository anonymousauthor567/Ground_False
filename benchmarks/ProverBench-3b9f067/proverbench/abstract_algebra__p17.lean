import Mathlib

/-
All zeros of the polynomial \(f(x)=x(x-2)(x-4)(x-6)+(x-1)(x-3)(x-5)(x-7)\) are real as
\(f(-\infty)=f(\infty)= +\infty\), \(f(1) <  0\), \(f(3) > 0\), \(f(5) <  0\),
indicating that polynomial \(f\) has a real zero in each of the intervals \((-\infty,1)\),
\((1,3)\), \((3,5)\), \((5,\infty)\), a total of four.
-/

open Polynomial Filter

-- Define the polynomial f(x) as given in the problem
noncomputable def f : ℝ[X] :=
  X * (X - 2) * (X - 4) * (X - 6) + (X - 1) * (X - 3) * (X - 5) * (X - 7)

theorem real_zeros_of_polynomial_f :
 ∃ (s : Finset ℝ), s.card = 4 ∧ (∀ x ∈ s, f.eval x = 0) ∧
 (∀ x : ℝ, f.eval x = 0 → x ∈ s) := by
  sorry
