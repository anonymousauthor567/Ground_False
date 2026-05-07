import Mathlib

/-
The derivative of the function \(f(x)=e^{-\frac{x^2}2}\) is \(f^{\prime}(x)=-xe^{-\frac{x^2}2}\).
-/

open Real

theorem derivative_of_exponential_function :
  deriv (fun x => exp (-x^2 / 2)) = fun x => -x * exp (-x^2 / 2) := by
  sorry
