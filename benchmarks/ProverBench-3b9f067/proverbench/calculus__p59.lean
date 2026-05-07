import Mathlib

/-
The integral \[\iint_{R}f(x,y)\,dxdy,\] where \(f(x,y)=11-2x-3y^2\) and \(R\) is the rectangle \([1,3]\times[-2,5]\) is equal to -168.
-/

open Set Filter MeasureTheory

variable (f : ℝ → ℝ → ℝ) (R : Set (ℝ × ℝ))

theorem integral_over_rectangle_equals_minus_168 :
  let f := fun x y => 11 - 2 * x - 3 * y^2
  let R := Icc (1 : ℝ) (3 : ℝ) ×ˢ Icc (-2 : ℝ) (5 : ℝ)
  ∫ x in Icc (1 : ℝ) (3 : ℝ), ∫ y in Icc (-2 : ℝ) (5 : ℝ), f x y = -168 := by
  sorry
