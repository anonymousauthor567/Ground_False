import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- The product
$$\prod_{k=4}^{63} \frac{\log_k \left(5^{k^2 - 1}\right)}{\log_{k+1} \left(5^{k^2 - 4}\right)} = \frac{\log_4 (5^{15})}{\log_5 (5^{12})} \cdot \frac{\log_5 (5^{24})}{\log_6 (5^{21})} \cdot \frac{\log_6 (5^{35})}{\log_7 (5^{32})} \dots \frac{\log_{63} (5^{3968})}{\log_{64} (5^{3965})}$$
is equal to $\frac{m}{n}$, where $m$ and $n$ are relatively prime positive integers. Find $m + n$. Show that it is 106.-/

theorem aime_2025ii_p4 (ans : ℚ)
    (answer : ans = (∏ k in Finset.Icc (4 : ℕ) 63,
      (Real.logb k (5 ^ (k ^ 2 - 1)) / Real.logb (k + 1) (5 ^ (k ^ 2 - 4)))
    )) :
    ↑ans.den + ans.num = 106 := by
  sorry
