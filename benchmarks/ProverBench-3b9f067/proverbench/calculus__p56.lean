import Mathlib

/-
The maximum value of \[\int_0^1 \left(x^2f(x)-xf^2(x)\right)\,dx\] over all continuous functions \(f:[0,1]\to\mathbb R\) is \(\frac{1}{16}\).
-/

open Filter Topology

variable {f : ℝ → ℝ} (hf : Continuous f)

theorem max_integral_value :
IsMaxOn (fun f => ∫ x in Set.Icc 0 1, (x^2 * f x - x * f x^2)) {f | Continuous f} f →
(∫ x in Set.Icc 0 1, (x^2 * f x - x * f x^2)) = 1/16 := by
  sorry
