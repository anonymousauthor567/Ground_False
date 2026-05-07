import Mathlib

/-
The integral \[\iiint_S z\,dxdydz,\] where \(S\) is a triangular prism bounded by the planes \(x=0\), \(y=0\), \(z=0\), \(x=5\), and \(y+z=1\), is equal to \(\frac{5}{6}\).
-/

open MeasureTheory
open Real

variable {S : Set (ℝ × ℝ × ℝ)}

theorem integral_over_triangular_prism :(∫⁻ (p : ℝ × ℝ × ℝ) in {p : ℝ × ℝ × ℝ | p.1 ∈ Set.Icc 0 5 ∧ p.2.1 ∈ Set.Icc 0 1 ∧
  p.2.2 ∈ Set.Icc 0 1 ∧ p.2.1 + p.2.2 ≤ 1}, ENNReal.ofReal p.2.2) = 5 / 6 := by
  sorry
