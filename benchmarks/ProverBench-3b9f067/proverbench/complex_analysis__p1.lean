import Mathlib

/-
The polynomial \(f(x)=x^6-2x^5+x^4-2x^3+x^2-2x+1\) has exactly four zeros of modulus 1.
-/

open Polynomial
open Complex

variable (f : Polynomial ℂ) (hf : f = (C 1 - C 2 * X + C 1 * X^2 - C 2 * X^3 + C 1 * X^4 - C 2 * X^5 + C 1 * X^6))

theorem exactly_four_roots_of_modulus_one :
 (Multiset.card (f.roots.filter fun z => ‖z‖ = 1)) = 4 := by
  sorry
