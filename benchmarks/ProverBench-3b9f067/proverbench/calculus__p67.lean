import Mathlib

/-
The integral \(\displaystyle \int \sqrt[3]{\cos x}\cdot \sin^3x\,dx\) can be evaluated as \(-\frac34 \cos^{\frac43}x+\frac{3}{10}\cos^{\frac{10}3}x+C\), by substituting \(u=\cos x\) and integring term by term.
-/

open Real

theorem integral_of_cube_root_cos_sin_cube (x : ℝ) :
∫ x in Set.Icc 0 x, (cos x)^(1/3 : ℝ) * (sin x)^3 =
  - (3/4) * (cos x)^(4/3 : ℝ) + (3/10) * (cos x)^(10/3 : ℝ) + C := by
  sorry
