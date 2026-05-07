import Mathlib

/-
The smallest possible value for \(n\) in a library with \(n\) books, where if books are arranged in boxes with 7 books in each box, then 5 books remain, if arranged with 9 books in each box, then 3 books remain, and if arranged with 11 books in each box, then 7 books remain, is 579.
-/

theorem smallest_library_books_value {n : ℕ}
  (h1 : n % 7 = 5) (h2 : n % 9 = 3) (h3 : n % 11 = 7) :
  n = 579 := by
  sorry
