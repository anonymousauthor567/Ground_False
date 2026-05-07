import Mathlib
import Aesop

set_option maxHeartbeats 0

open BigOperators Real Nat Topology Rat

/-- A piecewise linear function is defined by
\[f(x) = \begin{cases} x & \text{if } x \in [-1, 1) \\ 2 - x & \text{if } x \in [1, 3)\end{cases}\]
and $f(x + 4) = f(x)$ for all real numbers $x.$ The graph of $f(x)$ has the sawtooth pattern depicted below. 

\begin{asy}
import graph;

size(18cm);
real f(real x) {
    real x_mod = x - 4 * floor((x+1) / 4);
    if (-1 <= x_mod && x_mod < 1) {
        return x_mod;
    } else if (1 <= x_mod && x_mod < 3) {
        return 2 - x_mod;
    }
    return 0; // Should never reach here
}

// Set up axes
real xmin = -8, xmax = 11, ymin = -2, ymax = 2;
xaxis("", xmin, -2, Ticks(2.0));
xaxis("", -2, 2);
xaxis("", 2, xmax, Ticks(2.0));
yaxis("", ymin, ymax, Ticks(2.0));
// Plot the function in segments due to periodicity
real step = 0.01;
for (real k = -8; k < 7; k += 4) {
    draw(graph(f, k, k + 4, n=(int)((4)/step)),blue);
}
    draw(graph(f, 8, 11, n=(int)((4)/step)),blue);
\end{asy}

The parabola $x = 34y^2$ intersects the graph of $f(x)$ at finitely many points. The sum of the $y$-coordinates of these intersection points can be expressed in the form $\tfrac{a + b\sqrt c}d,$ where $a, b, c$ and $d$ are positive integers, $a, b,$ and $d$ has greatest common divisor equal to $1,$ and $c$ is not divisible by the square of any prime. Find $a + b + c + d$. Show that it is 259.-/

theorem aime_2025i_p11 (f : ℝ → ℝ) (S : Finset ℝ)
    (h₀ : ∀ (x : ℝ), (-1 ≤ x ∧ x < 1) → f x = x)
    (h₁ : ∀ (x : ℝ), (1 ≤ x ∧ x < 3) → f x = 2 - x)
    (h₂ : ∀ (x : ℝ), f x = f (x + 4))
    (h₃ : ∀ (x : ℝ), ∀ x : ℝ, x ∈ S ↔ x = 34 * (f x) ^ 2) :
    ∃ (a b c d : ℕ), 0 < a ∧ 0 < b ∧ 0 < c ∧ 0 < d ∧
    Nat.Coprime a b ∧ Nat.Coprime a d ∧ Nat.Coprime b d ∧ Squarefree c ∧
    (∑ x in S, f x) = (a + b * Real.sqrt c) / d ∧ a + b + c + d = 259 := by
  sorry
