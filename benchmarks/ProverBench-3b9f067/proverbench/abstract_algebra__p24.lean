import Mathlib
/-
Let $R$ be an integral domain. If the characteristic of $R$ is 0, then $R$ is infinite.
-/
variable {R : Type*} [CommRing R] [IsDomain R]

/-- If R is an integral domain with characteristic 0, then R is infinite. -/
theorem integralDomainCharZeroInfinite (hchar : CharP R 0) : Infinite R := by
  sorry
