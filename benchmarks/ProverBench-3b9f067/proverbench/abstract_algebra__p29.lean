import Mathlib

/-
There exist only injective functions \f:\mathbb{N}\rightarrow\mathbb{N}\ that satisfy:
\a\ \f(f(m)+f(n))=f(f(m))+f(n)\, \b\ \f(1)=2, \f(2)=4\.
-/

variable {f : ℕ → ℕ} (hf_inj : Function.Injective f)

theorem unique_injective_function_satisfying_conditions :
  (∀ m n : ℕ, f (f m + f n) = f (f m) + f n) →
  f 1 = 2 →
  f 2 = 4 →
  ∃! f : ℕ → ℕ, Function.Bijective f ∧ (∀ m n : ℕ, f (f m + f n) = f (f m) + f n) ∧ f 1 = 2 ∧ f 2 = 4 := by
  sorry
