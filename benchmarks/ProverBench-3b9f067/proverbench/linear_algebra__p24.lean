import Mathlib

/-
When given two real numbers \(\alpha\) and \(\beta\) which can express the vector \(\[\begin{array}{c}52\ -49\137\end{array}\right]\) as a linear combination of vectors \(\[\begin{array}{c}-2\ 4\7\end{array}\right]\) and \(\[\begin{array}{c}6\ -7\8\end{array}\right]\), the sum of \(\alpha\) and \(\beta\) is 18.
-/

variable (α β : ℝ)

-- Define the vectors as arrays of real numbers
def v1 : Array ℝ := #[52, -49, 137]

def v2 : Array ℝ := #[-2, 4, 7]

def v3 : Array ℝ := #[6, -7, 8]

-- Define scalar multiplication for arrays
def smul (a : ℝ) (v : Array ℝ) : Array ℝ := v.map (λ x => a * x)

-- Define vector addition for arrays
def add_vec (v w : Array ℝ) : Array ℝ := v.zip w |>.map (λ (x, y) => x + y)

-- Theorem statement

theorem sum_of_coefficients :
(add_vec (smul α v2) (smul β v3) = v1) → (α + β = 18) := by
  sorry
