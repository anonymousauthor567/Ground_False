import Mathlib

/-
The derivative of \(f(x)=e^x\) at \(x=e\) is \(e^e\).
-/

open Real

theorem derivative_of_exp_at_e : deriv (fun x => exp x) e = exp e := by
  sorry
