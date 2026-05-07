import Mathlib

/-
In a ring R of characteristic 0, if e, g, and f are idempotent elements of R (where an element a is idempotent if a^2=a), and if e+g+f=0, then it follows that e=f=g=0.
-/

variable {R : Type _} [Ring R] [CharZero R]

variable (e g f : R) (he : IsIdempotentElem e) (hg : IsIdempotentElem g) (hf : IsIdempotentElem f) (hsum : e + g + f = 0)

theorem sum_of_idempotents_zero_implies_zero  :
e = 0 ∧ g = 0 ∧ f = 0 := by
  sorry
