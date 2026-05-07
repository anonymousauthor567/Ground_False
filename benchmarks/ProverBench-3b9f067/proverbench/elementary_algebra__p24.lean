import Mathlib

/-
Given that three cats and five dogs cost 31 dollars and five cats and nine dogs cost 53 dollars.
Then the total price for five cats and three dogs equals 41 dollars.
-/

variable (catPrice dogPrice : ℤ)

variable (h1 : 3 * catPrice + 5 * dogPrice = 31)

variable (h2 : 5 * catPrice + 9 * dogPrice = 53)

theorem total_price_theorem : 5 * catPrice + 3 * dogPrice = 41 := by
  sorry
