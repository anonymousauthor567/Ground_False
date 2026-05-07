import Mathlib

/-
Let $f(x) = x^2 + 1$ be a polynomial over the finite field $\mathbb{Z}_2$. Then $f(x)$ has exactly one zero in $\mathbb{Z}_2$, namely $x = 1$.
-/

open Polynomial

-- Correct way to define a finite field with 2 elements in Lean 4
def Z2 : Type := ZMod 2

-- Ensure Z2 has the necessary algebraic instances
instance : Semiring Z2 := inferInstanceAs (Semiring (ZMod 2))

-- Define the polynomial f(x) = x^2 + 1 over Z_2
noncomputable def f : Polynomial Z2 := Polynomial.X^2 + Polynomial.C 1

-- Prove that f(1) = 0 in Z_2

lemma f_one_eq_zero : Polynomial.IsRoot f 1 := by
  sorry
