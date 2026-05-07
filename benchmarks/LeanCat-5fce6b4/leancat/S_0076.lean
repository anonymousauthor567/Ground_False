import Mathlib

open CategoryTheory

universe v u

/-Informal Statement

Theorem: Let $\mathcal Set^{fin}$ be the category of finite sets and functions. Its pro-completion is the category
$$ \mathrm{Pro}(\mathcal Set^{fin}) = \mathcal Stone$$
of Stone spaces, i.e. compact topological spaces in which distinct elements can be separated by
clopen subsets. Morphisms are the continuous functions. 


ref: JIŘÍ ADÁMEK, LIANG-TING CHEN, STEFAN MILIUS and HENNINGURBAT, Reiterman’s Theorem on Finite Algebras for a Monad, https://arxiv.org/pdf/2101.00942
-/

abbrev Pro (C : Type u) [Category.{v} C] : Type (max u (v + 1)) := (Ind (Cᵒᵖ))ᵒᵖ

theorem pro_fintypecat_equiv_profinite : Nonempty ((Pro (FintypeCat)) ≌ Profinite) := by
  sorry
