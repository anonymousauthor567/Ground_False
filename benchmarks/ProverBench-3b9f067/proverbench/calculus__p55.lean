import Mathlib

/-
If \(f(x)=2^x\) and \(g(x)=5\cdot x-6\), then the function \(h(x)=f(g(x))=2^{5x-6}\) results in \(h(3)=2^{5\cdot 3-6}=2^{9}=512\), and function \(m(x)=g(f(x))=5\cdot 2^x-6\) results in \(m(3)=5\cdot 2^3-6=5\cdot 8-6=34\).
-/

/-- The exponential function with base a, f(x) = a^x -/
noncomputable def f (a : ℝ) (x : ℝ) : ℝ := a^x

/-- The linear function g(x) = mx + b -/
noncomputable def g (m b : ℝ) (x : ℝ) : ℝ := m * x + b

/-- The composition h(x) = f(g(x)) = a^(mx + b) -/
noncomputable def h (a m b : ℝ) (x : ℝ) : ℝ := f a (g m b x)

/-- The composition m(x) = g(f(x)) = m * a^x + b -/
noncomputable def m_comp (a m b : ℝ) (x : ℝ) : ℝ := g m b (f a x)

/-- Specific example where a = 2, m = 5, b = -6, and x = 3 -/
theorem specific_example :
  h 2 5 (-6) 3 = 512 ∧ m_comp 2 5 (-6) 3 = 34 := by
  sorry
