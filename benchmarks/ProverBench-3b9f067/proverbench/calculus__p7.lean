import Mathlib

/-
Let \[F(x)=\cos^2 x-\sin^2 x,\] \[G(x)=2\cos^2x,\] \[H(x)=2\sin^2x,\] \[K(x)=\cos (2x).\] Which of the previously defined functions are anti-derivatives of the function \[\varphi(x)=-4\sin x\cdot\cos x.\] \begin{itemize} \item \textbf{(A)} \(F\) only \item \textbf{(B)} \(F\) and \(K\) only \item \textbf{(C)} \(F\), \(G\), and \(K\) only \item \textbf{(D)} \(H\) and \(K\) only \item \textbf{(E)} \(H\) only \end{itemize}
-/

open Real

-- Define the functions
noncomputable def F (x : ℝ) : ℝ := cos x ^ 2 - sin x ^ 2

noncomputable def G (x : ℝ) : ℝ := 2 * cos x ^ 2

noncomputable def H (x : ℝ) : ℝ := 2 * sin x ^ 2

noncomputable def K (x : ℝ) : ℝ := cos (2 * x)

-- Define the function φ
noncomputable def φ (x : ℝ) : ℝ := -4 * sin x * cos x

-- Theorem statement

theorem formal_statement : ∀ x : ℝ, (deriv F x = φ x) ∧ (deriv K x = φ x) ∧ (deriv G x ≠ φ x) ∧ (deriv H x ≠ φ x) := by
  sorry
