# Faithfulness audit of `proofnet_verified/`

For each Lean file we asked Claude to read the full file content (informal statement + Lean theorem signature) and decide whether the Lean encoding is a *strictly faithful* formalization (neither stronger nor weaker).

## Summary

| verdict | count |
|---|---|
| faithful | 86 |
| weaker | 8 |
| stronger | 5 |
| incomparable | 1 |
| unclear | 0 |
| error | 0 |
| **total** | **100** |

## faithful (86)

### 1

**Verdict:** `faithful`

**Reasoning**

The Lean signature matches the informal statement exactly. `[CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]` is the standard Mathlib encoding of a UFD. The hypotheses `hp : Prime p`, `hq : Prime q`, `hpq : ¬ Associated p q` together with `h : ∀ {x : R}, Prime x → Associated x p ∨ Associated x q` precisely capture "two nonassociate prime elements p, q such that every prime element is an associate of either p or q". The conclusion `IsPrincipalIdealRing R` combined with the in-scope `IsDomain R` is Mathlib's documented way of expressing "R is a PID" (there is no single `PrincipalIdealDomain` class). No hypotheses are added, dropped, or changed in type, so this is logically equivalent to the informal claim.

### 100

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the hypotheses and conclusion of Bass's theorem correctly. `CommRing R` + `IsNoetherianRing R` matches "Noetherian ring" (commutative is the natural reading for localization). `Projective R P` with the existence of a countable spanning set matches "countably generated projective R-module". The conclusion `Free R P` matches "P is free". The encoding of "P_m has infinite rank" as `¬ Module.Finite (R_m) (P_m)` is logically equivalent under the given projectivity hypothesis: localization preserves projectivity, and by Kaplansky's theorem projective modules over local rings are free, so for P_m "not finitely generated" is equivalent to "basis is infinite" i.e. "infinite rank". Both directions of this equivalence hold, so the hypotheses and hence the overall statements are logically equivalent.

### 11

**Verdict:** `faithful`

**Reasoning**

The Lean file defines `EuclideanNormNat` as a classical Euclidean domain with an ℕ-valued norm (matching the standard textbook definition in Dummit-Foote/Lang), and asserts `IsEmpty` of this class for A = ℝ[X,Y]/(X²+Y²+1). The ring is correctly encoded as `MvPolynomial (Fin 2) ℝ ⧸ Ideal.span {X 0^2 + X 1^2 + C 1}`. The extra `mul_left_not_lt` axiom (norm(a·b) ≥ norm(a) for b ≠ 0) is not in the classical textbook definition, but by Samuel's reduction (replacing N with N*(a) = min{N(a·x) : x ≠ 0}), any classical ℕ-valued Euclidean norm can be refined to one satisfying this multiplicativity condition. Hence "A has a classical Euclidean norm" ⟺ "A has an `EuclideanNormNat` structure", making `IsEmpty (EuclideanNormNat A)` logically equivalent to "A is not a Euclidean domain." The formalization is faithful.

### 12

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that $\mathbb{Z}[(1+\sqrt{-19})/2]$ is a PID. The Lean statement uses `Algebra.adjoin ℤ {α}` with `α = (1 + Real.sqrt 19 * Complex.I) / 2 ∈ ℂ`, which correctly represents $\mathbb{Z}[(1+\sqrt{-19})/2]$ since `Real.sqrt 19 * Complex.I` is the standard encoding of $\sqrt{-19}$ in ℂ, and `Algebra.adjoin ℤ` gives the smallest subring of ℂ containing the element. The conjunction `IsPrincipalIdealRing ∧ IsDomain` is exactly Mathlib's recommended encoding of "PID" — the Mathlib documentation itself states that a PID should be formalized via `[IsDomain R] [IsPrincipalIdealRing R]` since there is no explicit `PID` definition. Including `IsDomain` is not stronger: it is part of the definition of a principal ideal domain. The formalization is logically equivalent to the informal claim.

### 14

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully encodes the informal statement. R being a UFD is captured by `CommRing R`, `IsDomain R`, and `UniqueFactorizationMonoid R`, which is the standard Mathlib encoding. `FractionRing R` is the field of fractions of the integral domain R (i.e., the "quotient field"). "Isomorphic to ℝ" is naturally expressed as `Nonempty (_ ≃+* ℝ)`, which is the standard way to express "there exists a ring isomorphism"; for fields, ring-isomorphism coincides with field-isomorphism. The hypothesis `Nonempty ((FractionRing R) ≃+* ℝ)` and conclusion `Nonempty (R ≃+* ℝ)` match the informal hypothesis and conclusion respectively. No hidden hypotheses added or dropped.

### 16

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly captures the informal claim. The `IsPExtension` class is defined as "Galois extension with Module.rank = p^n for some n", which for prime p (as required by `hp : p.Prime`) precisely matches the informal definition of a p-extension (finite Galois with degree a power of p). The intermediate field tower F ⊆ K ⊆ L ⊆ E is correctly set up via `L : IntermediateField F E` and `K : IntermediateField F L`. The hypothesis `IsNormalClosure F L E` correctly expresses that E is the normal closure of L over F; since L/F is separable (by transitivity of separability, as both K/F and L/K are Galois hence separable), this coincides with the Galois closure. The conclusion `IsPExtension F E p` asserts that E is a p-extension of F, matching the informal conclusion. The redundant `[IsGalois K L]` (already implied by `IsPExtension K L p`) does not affect faithfulness. Module.rank = p^n forces finite-dimensionality for prime p, correctly capturing the "finite" qualifier.

### 17

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures all components of the informal statement. (1) `K : Subfield ℂ` with `h_nmem : (Real.sqrt 2 : ℂ) ∉ K` matches "K is a subfield of ℂ with √2 ∉ K". (2) The maximality hypothesis `∀ L, K ≤ L → √2 ∉ L → K = L` is the standard encoding of "K is maximal with the property √2 ∉ K" (no proper superfield excludes √2). (3) The conclusion `Module.rank K ℂ = Cardinal.aleph0` precisely expresses "countable and not finite" — equality to ℵ₀ means countably infinite, which is exactly "countable and not finite" in standard Mathlib convention where `Cardinal.aleph0` = #ℕ. No hypotheses have been added or dropped, types match, and the quantifier structure is preserved.

### 18

**Verdict:** `faithful`

**Reasoning**

The Lean formalization accurately captures the informal statement. E : Subfield ℝ matches "subfield of ℝ"; [Field K] [Algebra E K] [IsGalois E K] captures "Galois extension"; the rank condition Module.rank E K = n with n : ℕ, Odd n, n > 1 encodes "finite Galois extension of odd degree > 1" (the natural-number target forces finiteness via Cardinal coercion). K' : IntermediateField E ℝ with IsRadicalTower E K' correctly captures "radical tower that is a subfield of ℝ" (containing E). The conclusion IsEmpty (K →ₐ[E] K') is equivalent to "no E-embedding from K" since field homomorphisms are automatically injective. The custom IsRadicalExtension definition (simple extension by x with x^n = e, n ≥ 1) and inductive IsRadicalTower (composition of radical extensions via subalgebras) match the informal definitions. The n ≥ 1 in IsRadicalExtension is a reasonable implicit premise. The universal quantification over K' correctly expresses "cannot be embedded into any such tower".

### 19

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that Gal(E/ℚ) ≅ Q_8 where E = ℚ(α) and α = √((2+√2)(3+√3)). In Lean: (1) `QuaternionGroup 2` has order 4·2 = 8 (per `QuaternionGroup.card`), which is the standard quaternion group Q_8; (2) `Algebra.adjoin ℚ {α}` coincides with the field ℚ(α) since α is algebraic over ℚ, so the type `E` correctly represents the subfield; (3) `E ≃ₐ[ℚ] E` is the group of ℚ-algebra automorphisms of E. An isomorphism to Q_8 (order 8) forces |Aut_ℚ(E)| = 8, which combined with [E:ℚ] ≤ 8 means E/ℚ is Galois with Galois group isomorphic to Q_8 — equivalent to the informal claim. (4) `Nonempty (G ≃* H)` is the standard encoding of "G is isomorphic to H". The formalization captures the exact mathematical content.

### 20

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes each component: `frobenius L p` is Mathlib's Frobenius endomorphism x ↦ x^p, its `.range` is σ(L), and `IntermediateField.adjoin K ((frobenius L p).range : Set L)` is precisely the compositum Kσ(L). The hypothesis `Module.rank ... L ≤ p` matches [L : Kσ(L)] ≤ p since `FiniteDimensional K L` makes the rank finite and matches the degree. The conclusion `∃ x, IntermediateField.adjoin K {x} = ⊤` is exactly "L is generated by one element over K". Although only `[CharP L p]` is assumed explicitly (not `CharP K p`), K has characteristic p automatically via the injective algebra map K → L, so this is not a missing hypothesis. The informal phrase "which of course stabilizes K" is a remark, not an added hypothesis, and follows automatically. No drift in quantifiers, types, or strength.</reasoning>
</invoke>

### 21

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal claim. The hypotheses match exactly: F is a field, f is an irreducible polynomial, K is a splitting field of f over F, and α, α+1 are both roots of f in K (via `f.aeval · = 0`). The conclusion `∃ E : IntermediateField F K, Module.rank E K = ringChar F` corresponds exactly to "there exists an intermediate field E such that [K:E] = char(F)": `IntermediateField F K` is Mathlib's standard type for fields E with F ⊆ E ⊆ K, `Module.rank E K` is the standard formalization of [K:E] as a Cardinal, and `ringChar F` gives char(F) coerced to Cardinal. The parenthetical remark "the characteristic of F is not zero" is a logical consequence of the main statement (since Module.rank E K ≥ 1 always holds for a nontrivial field extension), so it is automatically captured — not a separate conjunct that needs formalizing. No hypotheses are silently added or dropped, and the quantifier structure is preserved.

### 24

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. "r distinct prime numbers" is encoded via `[Finite I]`, `p : I → ℕ`, `hp : ∀ i, (p i).Prime`, and `h_inj : p.Injective` — any finite indexing type is equivalent to Fin r. The field ℚ(√p_1,...,√p_r) is encoded as `Algebra.adjoin ℚ (Set.range (fun i ↦ Real.sqrt (p i)))`; since √p_i is algebraic over ℚ, this subalgebra of ℝ is a field and coincides with the intermediate field adjoin. The Galois group Gal(K/ℚ) is represented as the ℚ-algebra automorphism group `RatAdjoinSqrt p ≃ₐ[ℚ] RatAdjoinSqrt p`. The group (ℤ/2ℤ)^r is encoded as `Multiplicative (I → ZMod 2)`, which is the multiplicative group of the direct product of |I| copies of ℤ/2ℤ. The assertion of a group isomorphism `≃*` wrapped in `Nonempty` correctly captures "is isomorphic to". No hypotheses are silently added or dropped.

### 25

**Verdict:** `faithful`

**Reasoning**

The Lean statement has two conjuncts mirroring the informal claim. (1) `Nonempty ((RatFunc (ZMod 2) ≃+* RatFunc (ZMod 2)) ≃* Equiv.Perm (Fin 3))` asserts RingAut(F₂(t)) ≅ S₃; since ZMod 2 is the prime field, every ring automorphism fixes it, so this ring-automorphism group equals the full automorphism group Aut(F₂(t)), and Equiv.Perm (Fin 3) is exactly S₃. (2) `IntermediateField.fixedField ⊤ = IntermediateField.adjoin (ZMod 2) {u}` with u = (X⁴-X)³/(X²-X)⁵ states that the fixed field of the top subgroup of Gal(F₂(t)/F₂) (i.e., the whole Aut group) equals F₂(u). Using only one of the two algebraically-equal expressions for u from the informal statement is sufficient, since the informal asserts they are equal. The conjunction, objects, and types all align with standard Mathlib conventions, making this a faithful formalization.

### 26

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement closely. `[Algebra ℚ K] [Module.Finite ℚ K]` correctly encodes "K/ℚ is a finite extension". `Field.absoluteGaloisGroup K` is Mathlib's standard definition, equipped with the Krull topology, so `Subgroup (Field.absoluteGaloisGroup K)` paired with `IsClosed (H : Set ...)` precisely captures "closed subgroup of G(K)". `Finite H` gives "H is finite" as a finite subtype, and `Nat.card H = 1 ∨ Nat.card H = 2` correctly asserts that the cardinality is one or two. No hypotheses are added or dropped, no types are changed, and the conclusion is equivalent. This is a standard consequence of the Artin-Schreier theorem, and the Lean statement is logically equivalent to the informal claim.

### 27

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes each piece of the informal claim: `p.Prime` captures "p prime"; `Field K` + `NumberField K` captures "K/ℚ finite extension" (since NumberField bundles CharZero and FiniteDimensional ℚ K); `IsPrimitiveRoot ζ (p^2)` captures "K contains the p²-th root of unity" (standard mathematical reading meaning a primitive one); `IntermediateField K (AlgebraicClosure K)` with `IsGalois K L` and `Module.rank K L = p` is a standard and logically equivalent encoding of "L/K is a Galois extension of degree p" (the coercion of ℕ to Cardinal forces finite-dimensionality with dim = p). The conclusion existentially introduces L' as a field with compatible K- and L-algebra structure (via IsScalarTower), asserting `IsGalois L L'`, `Module.rank L L' = p`, and `IsGalois K L'`, which together state exactly "there exists a Galois L'/L of degree p such that L'/K is also Galois". No hypothesis is added or dropped, and no quantifier structure changed.

### 28

**Verdict:** `faithful`

**Reasoning**

The Lean signature captures each part of the informal statement exactly. "K/ℚ is a finite extension" is encoded by `[Field K] [Algebra ℚ K] [Module.Finite ℚ K]`, which for a field K is equivalent to K being a finite extension of ℚ. `Field.absoluteGaloisGroup K` is defined in Mathlib as `AlgebraicClosure K ≃ₐ[K] AlgebraicClosure K`, i.e., the Galois group of the algebraic closure over K — precisely the absolute Galois group. The "nontrivial" condition is `g ≠ 1`, and "infinite number of conjugates" is encoded as the infiniteness of the set `{g' | IsConj g g'}`, where `IsConj` in a group matches the standard group-theoretic notion (∃ c, c * g * c⁻¹ = g'). No hypotheses are dropped, added, or weakened, and the conclusion matches the informal claim exactly.

### 29

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes each component of the informal statement. `Field.absoluteGaloisGroup K` is defined in Mathlib as `AlgebraicClosure K ≃ₐ[K] AlgebraicClosure K`, matching G(K) = Gal(K^al/K), with the Krull topology automatically instantiated. The typeclass assumptions `[Field K] [Algebra ℚ K] [Module.Finite ℚ K]` faithfully capture "K/ℚ is a finite extension". `Subgroup.zpowers g` is defined as `{g^k : k ∈ ℤ}`, which equals the subgroup generated by g. `IsOfFinOrder g` means there exists n ≥ 1 with g^n = 1, which is exactly "g is torsion". The `IsClosed (... : Set _)` correctly expresses topological closedness of this subgroup in G(K). The biconditional matches the informal "if and only if". Using `Type` instead of `Type*` is a mild universe annotation that does not alter the mathematical content.

### 3

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes the informal claim. The hypothesis `[H.FiniteIndex]` matches "subgroup of finite index". In Mathlib, `Subgroup.IsComplement S H` means the multiplication map `S × H → G` is a bijection, which is equivalent to S containing exactly one representative of each left coset (Mathlib's `LeftTransversal H` is literally defined as `{S // IsComplement S H}`). Symmetrically, `Subgroup.IsComplement H S` means S is a right-coset representative system (Mathlib's `RightTransversal H = {T // IsComplement H T}`). The conjunction `IsComplement S H ∧ IsComplement H S` therefore asserts exactly that S is simultaneously a set of left-coset and right-coset representatives, matching the informal statement exactly. Types (Group G, Subgroup G, Set G) are also appropriate.

### 30

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully captures the informal statement. The hypothesis `∀ (x y : B), x ∉ A → y ∉ A → x * y ∉ A` is exactly equivalent to "B\A is closed under multiplication". The conclusion `IsIntegrallyClosedIn A B`, given Mathlib's definition (verified: `IsIntegrallyClosedIn S A ↔ ∀ ⦃x : A⦄, IsIntegral S x → x ∈ S` for S a subring), precisely expresses "A is integrally closed in B" (every element of B integral over A lies in A). The `CommRing B` assumption, while not literally stated in the informal text which only says "a ring B", is the standard convention in commutative algebra (where this integral-closure problem lives; cf. Atiyah-Macdonald) and is needed for the notion of integral closure as formalized in Mathlib to be defined at all — this is surfacing an implicit premise rather than narrowing the scope.

### 31

**Verdict:** `faithful`

**Reasoning**

The Lean definition `R n := MvPolynomial (Fin n) ℂ ⧸ Ideal.span {∑ i, X i ^ 2}` correctly represents ℂ[x_1,...,x_n]/(x_1²+...+x_n²). The conclusion `∃ (h : IsDomain (R n)), UniqueFactorizationMonoid (R n)` is logically equivalent to `IsDomain (R n) ∧ UniqueFactorizationMonoid (R n)` since the body doesn't depend on h. This correctly captures "UFD" because in Mathlib, `UniqueFactorizationMonoid` extends `IsCancelMulZero` but not `Nontrivial`, so `IsDomain` is required separately to assert the full "integral domain + unique factorization" meaning of UFD. The hypothesis `n ≥ 5` matches the informal statement exactly. The universal quantification over n is correctly represented.

### 32

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal claim. Hypotheses: `[CommRing R] [IsLocalRing R] [IsNoetherianRing R]` correctly model "Noetherian local ring A" (in commutative-algebra convention local rings are commutative). `AdicCompletion (maximalIdeal R) R` is Mathlib's standard m-adic completion Â. The combination `[IsDomain (AdicCompletion …)]` + `[UniqueFactorizationMonoid (AdicCompletion …)]` correctly encodes "Â is a UFD" (UFD = domain + unique factorization; Mathlib's `UniqueFactorizationMonoid` extends `IsCancelMulZero` but not `Nontrivial`, so pairing with `IsDomain` is the right way to get a UFD). The conclusion `∃ (h : IsDomain R), UniqueFactorizationMonoid R` asserts both that R is a domain and that unique factorization holds, which is precisely "A is a UFD". No extra or missing hypotheses, no quantifier drift.

### 33

**Verdict:** `faithful`

**Reasoning**

This is the Eakin-Nagata theorem. The Lean formalization correctly captures all components: (1) `A : Subring B` with `[CommRing B]` encodes "A ⊂ B commutative rings" since a Subring of a CommRing automatically inherits a CommRing structure via Mathlib's `SubringClass.toCommRing` instance; (2) `Module.Finite A B` is definitionally `(⊤ : Submodule A B).FG`, which is exactly "B is finitely generated as an A-module" (the Module A B structure comes from the standard Subring Module instance); (3) `[IsNoetherianRing B]` matches "B is Noetherian"; (4) the conclusion `IsNoetherianRing A` matches "A is Noetherian". The types and hypothesis structure exactly mirror the informal statement with no added or dropped hypotheses.

### 34

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully formalizes the informal claim. "Valuation ring" is correctly encoded as `CommRing R` + `IsDomain R` + `ValuationRing R` (Mathlib's `ValuationRing` class itself assumes a commutative integral domain, matching the standard convention). "Krull dimension ≥ 2" is correctly encoded as `2 ≤ ringKrullDim R`, where `ringKrullDim` takes values in `WithBot ℕ∞` so the inequality properly captures "at least 2" (the variable name `two_lt` is misleading but the actual proposition is `2 ≤ ...`, i.e., "≥ 2"). "R[[X]] is not integrally closed" is correctly encoded as `¬ (IsIntegrallyClosed R⟦X⟧)`, which by Mathlib's definition means R[[X]] does not contain all integral elements of its fraction field — the standard meaning. No hypotheses are added or dropped beyond the standard convention, and the quantifier structure matches.

### 35

**Verdict:** `faithful`

**Reasoning**

The Lean statement precisely formalizes "A commutative ring whose prime ideals are finitely generated is Noetherian." It takes a `CommRing R`, assumes that for every ideal `p : Ideal R`, if `p.IsPrime` then `p.FG` (finitely generated), and concludes `IsNoetherianRing R`. This is exactly Cohen's theorem, and it matches Mathlib's own `IsNoetherianRing.of_prime` in `Mathlib/RingTheory/Noetherian/OfPrime.lean`. The Mathlib notions `Ideal.IsPrime`, `Submodule.FG`, and `IsNoetherianRing` correspond to the standard mathematical definitions. The universe choice `Type` instead of `Type*` is a minor formalization convention that does not alter the mathematical claim.

### 36

**Verdict:** `faithful`

**Reasoning**

The Lean statement matches the informal claim exactly. `associatedPrimes R (M →ₗ[R] N)` is Ass Hom_R(M,N). The RHS `{p | p ∈ associatedPrimes R N ∧ Module.annihilator R M ≤ p}` encodes Ass N ∩ Supp M using the informal statement's own explicit definition of Supp M as "primes containing the annihilator of M". Since elements of `associatedPrimes R N` are automatically prime ideals (by `IsAssociatedPrime.isPrime`), the set comprehension correctly captures primes `p` that lie in Ass N and contain Ann(M). The hypotheses R Noetherian (`IsNoetherianRing`), M and N f.g. R-modules (`Module.Finite R M/N`), and commutative ring all align with the informal setup. The types are correct (Set (Ideal R) on both sides). This is a faithful formalization.

### 37

**Verdict:** `faithful`

**Reasoning**

The Lean definition of `QuotDetSubOne n` correctly encodes $\mathbb{C}[x_{ij}]/(\det(x_{ij})-1)$ as a quotient of the multivariate polynomial ring over $\mathbb{C}$ by the ideal generated by $\det(x_{ij}) - 1$. The conclusion `∃ h : IsDomain R, UniqueFactorizationMonoid R` is logically equivalent to `IsDomain R ∧ UniqueFactorizationMonoid R`, which is the standard Mathlib way to express "R is a UFD" (since `UniqueFactorizationMonoid` only extends `IsCancelMulZero` and not `Nontrivial`, so pairing it with `IsDomain` gives exactly the classical UFD notion). The `n ≥ 1` hypothesis surfaces an implicit premise of the informal statement, which explicitly lists variables $x_{11}, \ldots, x_{nn}$ and only makes genuine sense for $n \geq 1$; this is acceptable as surfacing an implicit premise. Overall the Lean statement is a faithful formalization.

### 38

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes the informal claim. `DualNumber k = TrivSqZeroExt k k` is canonically isomorphic to `k[t]/(t²)` with `ε` playing the role of `t`, so the ring R is correctly encoded. The polynomial `(C ε) * X^3 + (C ε) * X^2 - X^2 - X ∈ (DualNumber k)[X]` exactly encodes `tx³ + tx² − x² − x ∈ R[x]`. The quotient `(DualNumber k)[X] ⧸ Ideal.span {p}` correctly represents `S = R[x]/(p)`. The explicit `Module.compHom _ C` produces the correct R-module structure on S (equivalent to the canonical one induced by the composition R → R[X] → R[X]/(p)). The conclusion `Module.Free R S ∧ Module.rank R S = 2` faithfully states "free R-module of rank 2", and since R is a commutative ring it satisfies invariant basis number so rank is well-defined. No hypotheses are added or dropped beyond what the informal statement requires (just `[Field k]`).

### 39

**Verdict:** `faithful`

**Reasoning**

The Lean theorem precisely captures the informal statement. `CommRing R + IsDomain R + IsIntegrallyClosed R` exactly matches "normal domain" (Mathlib defines `IsIntegrallyClosed R` as integrally closed in `FractionRing R`, which for a domain is the definition of a normal domain). `IsNoetherianRing R` adds the Noetherian hypothesis. The extension L/K is encoded via `Field L`, `Algebra (FractionRing R) L`, `FiniteDimensional (FractionRing R) L`, and the compatibility scalar tower `IsScalarTower R (FractionRing R) L`, where `FractionRing R` is the canonical fraction field K. `integralClosure R L` is exactly the R-subalgebra of elements integral over R, matching R̄. Finally, `p.primesOver (integralClosure R L)` is defined as `{P : Ideal B | P.IsPrime ∧ P.LiesOver p}` — the set of primes lying over p — and `.Finite` asserts finiteness, precisely matching "only finitely many primes of R̄ lie over p".

### 4

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement on every point. "Odd prime p" is encoded as `Odd p` plus `p.Prime`. "Finite group G of order p(p+1)" is encoded via `[Finite G] [Group G]` with `Nat.card G = p * (p + 1)`. "G does not have a normal Sylow p-subgroup" is logically equivalent to `∀ (H : Sylow p G), ¬ H.Normal` (no Sylow p-subgroup is normal), using Mathlib's standard `Sylow.Normal` predicate. The conclusion `∃ n : ℕ, p + 1 = 2 ^ n` correctly captures "p+1 is a power of 2" in the standard mathematical sense. There are no added or missing hypotheses, no quantifier changes, and no type mismatches.

### 40

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. The hypotheses match: `[CommRing R] [IsLocalRing R] [IsReduced R]` encodes "reduced local ring"; `(minimalPrimes R).Finite` encodes "finite set Σ of minimal primes"; `[Module.Finite R M]` encodes "finitely generated". The LHS `Module.Free R M ∧ Module.rank R M = r` is equivalent to "free of rank r" for f.g. modules over a commutative ring (with the coercion ℕ → Cardinal being standard). The RHS correctly encodes $\dim_k(k\otimes_A M)=r$ using `IsLocalRing.ResidueField R` (the residue field $A/\mathfrak{m}$), and for each minimal prime $\mathfrak{p}$, $\dim_{K(\mathfrak{p})}(K(\mathfrak{p})\otimes_A M)=r$ using `FractionRing (R ⧸ p)` (which is the fraction field of the domain $A/\mathfrak{p}$). The quantifier structure and iff direction match exactly.

### 41

**Verdict:** `faithful`

**Reasoning**

The formalization faithfully captures the informal statement. MvPolynomial N k is isomorphic to k[X_1, X_2, ...] under re-indexing. The sequence m : N -> N with StrictMono m captures 'm_1 < m_2 < ...' under standard index shift. The ideals ideal_x k (Set.Ioc (m n) (m (n+1))) correctly generate the primes from the informal. StrictMono on consecutive differences is equivalent to the informal's growth condition. The compl_all definition uses Submonoid.closure on the complement of the union of primes; since the ideals are prime (generated by subsets of variables), the complement is already multiplicatively closed, so closure equals the complement. ringKrullDim = top correctly expresses infinite Krull dimension.

### 43

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. The hypotheses `[CommRing A] [IsNoetherianRing A] [IsLocalRing A] [IsReduced A]` match "reduced Noetherian local ring", and `[CharP A p]` matches "Char A = p". The `[Fact p.Prime]` hypothesis makes explicit a standard implicit premise: whenever one speaks of "the Frobenius $a \mapsto a^p$ in characteristic $p$", $p$ is understood to be prime (otherwise the map isn't even a ring homomorphism). The `IsRegularLocalRing` class defined in the file encodes exactly $\dim_k(m/m^2) = \dim R$ via `Module.finrank (ResidueField R) (CotangentSpace R) = ringKrullDim R`, where `CotangentSpace R` is Mathlib's abbrev for `(maximalIdeal R).Cotangent` (i.e., $m/m^2$). `frobenius A p` is the standard Mathlib Frobenius ring homomorphism (requires `ExpChar`, automatically derived from `[Fact p.Prime] [CharP A p]`), and `.Flat` on a ring hom expresses flatness of the induced module structure. The biconditional direction and all object types match the informal statement.

### 44

**Verdict:** `faithful`

**Reasoning**

The Lean file defines a class `IsGlobalCompleteIntersection` capturing the informal definition: extending `Algebra.FiniteType k S` encodes "finite type k-algebra", and the `isGlobalCompleteIntersection` field states exactly that there exist n ∈ ℕ and a list rs of polynomials in k[x_1,…,x_n] such that S ≅ k[x_1,…,x_n]/(rs) and ringKrullDim S + rs.length = n (i.e., dim S = n - c). The `Algebra.FiniteType` parent is technically redundant (any such presentation implies finite type) but doesn't change the logical content. `Ideal.ofList rs = span {r | r ∈ rs}` correctly represents the ideal (f_1,…,f_c). The ring A in the theorem matches the informal ring exactly under X↔X 0, Y↔X 1, Z↔X 2, with Ideal.span generating the same ideal as Ideal.ofList over the same elements. The conclusion ¬ IsGlobalCompleteIntersection k A matches "A is not a global complete intersection."

### 45

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes Hilbert's syzygy theorem. The exact sequence $0 \to K \to L_{r-1} \to \cdots \to L_0 \to M \to 0$ is encoded as an ℕ-indexed chain complex with $C_0 = M$, $C_1, \ldots, C_r$ corresponding to $L_0, \ldots, L_{r-1}$, $C_{r+1} = K$, and $C_n = 0$ for $n > r+1$ (via `hC`). `C.Acyclic` combined with the tail-vanishing correctly captures all required exactness: surjectivity at $M$ (exactness at 0 in ℕ-chain complex gives surjectivity of $L_0 \to M$), internal exactness, and injectivity of $K \to L_{r-1}$ (exactness at $r+1$ with $C_{r+2}=0$). The grading by ℕ matches the "$\mathbb{Z}_{\geq 0}$"; `DirectSum.Decomposition` plus `SetLike.GradedSMul` with `MvPolynomial.homogeneousSubmodule` correctly makes each module a graded module over the graded ring $k[x_1, \ldots, x_r]$. `IsGradedHom` is the standard degree-preserving condition matching "graded homomorphism". The `h_free` hypothesis covers exactly $n \in \{1, \ldots, r\}$ (i.e., $L_0, \ldots, L_{r-1}$), and the conclusion asserts freeness of $C_{r+1} = K$. The notion of "free" (Module.Free) matches consistently between hypothesis and conclusion.

### 46

**Verdict:** `faithful`

**Reasoning**

The Lean statement encodes exactly Stacks 058E: M is flat iff every R-linear map f : P → M from a finitely presented R-module P factors through a finite free R-module. Each component matches faithfully: `Module.Flat R M` for "M is flat"; `Module.FinitePresentation R P` for "finitely presented R-module"; `Module.Finite R F ∧ Module.Free R F` for "free finite R-module" (for a free module, finitely generated is equivalent to finite rank); and `f = g.comp h` for "f = g ∘ h" with h : P → F, g : F → M. The quantification order (f before the FP hypothesis) is logically equivalent to quantifying over f.p. P's first. The restriction of R, M, P, F to Type 0 is a conventional universe choice and does not change the essential mathematical content. The iff is mathematically correct (standard consequence of Lazard's theorem).

### 47

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal statement. Hypotheses match precisely: `[Field k]` encodes "k is a field"; `¬ CharP k 2` encodes "characteristic ≠ 2" (since field characteristic is unique); `n ≥ 3` and `Odd n` match "n ≥ 3 odd integer"; `Function.Injective t` with `t : Fin n → k` encodes "t₁,...,tₙ distinct". The ring `A t := MvPolynomial (Fin 2) k ⧸ Ideal.span {X 1 ^ 2 - ∏ (X 0 - C (t m))}` correctly represents k[x,y]/(y² - f(x)) with f(x) = ∏(x - t_m). The conclusion `∃ _ : IsDedekindDomain (A t), Nontrivial (ClassGroup (A t))` is logically equivalent to the conjunction "A is a Dedekind domain AND ClassGroup(A) is nontrivial", since IsDedekindDomain is a Prop and its witness supplies the IsDomain instance needed to form ClassGroup(A t).

### 48

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes both pieces of the informal statement. The `IsAbsolutelyFlat` class captures "every A-module is flat" by quantifying `Module.Flat R P` over all `P` with `AddCommGroup P` and `Module R P`, which is the standard Mathlib formulation for modules over a commutative ring. The iff-conclusion `∀ I : Ideal R, I.IsPrincipal → I ^ 2 = I` precisely captures "every principal ideal is idempotent": `Ideal.IsPrincipal` is Mathlib's predicate for principal ideals (∃ a, I = span{a}), and `I^2 = I` on ideals is exactly the definition of idempotent ideal (since `I^2 = I * I`). The universe restriction to `Type 0` is a conventional formalization choice that does not weaken the statement, since absolute flatness is characterized by a universe-invariant property (flatness of finitely generated cyclic modules R/I). No hypotheses are silently added or dropped.

### 49

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal claim. LHS: "every principal ideal is idempotent" becomes `∀ I, I.IsPrincipal → I^2 = I`, which is the standard definition of an idempotent ideal (I·I = I, since I^2 in Mathlib's ideal monoid is I*I). RHS: "every finitely generated ideal is a direct summand of A" becomes `∀ I, I.FG → ∃ J, I ⊔ J = ⊤ ∧ I ⊓ J = ⊥`. The two conditions I+J=A and I∩J=0 are exactly the IsCompl condition giving A = I ⊕ J as A-modules (the natural meaning of "direct summand of A" for an ideal, since ideals are not subrings). Note that although J is required to be an ideal (not just a submodule), this is equivalent: if a submodule complement J exists, then 1 = e+f decomposition forces J = fA which is automatically an ideal. The quantification over an arbitrary CommRing A is correct, and the overall biconditional structure matches.

### 5

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement. The hypotheses correctly encode "H is a maximal normal abelian subgroup": H is normal (h_normal), H is abelian (h_comm, using Mathlib's IsMulCommutative which expresses commutativity of multiplication), and H is maximal among normal abelian subgroups (h_maximal_normal_abelian: any normal abelian K with H ≤ K equals H). The conclusion encodes "H is a maximal abelian subgroup": any abelian subgroup K with H ≤ K equals H (with H itself already known abelian via h_comm). The ambient hypotheses (p prime, G finite group, G is a p-group via IsPGroup) faithfully encode the setup. The encoding of "maximal X" as "any X-subgroup containing H equals H" is the standard and faithful way to express maximality.

### 50

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully encodes the informal statement. "Complete local ring" becomes `[IsLocalRing R] [IsAdicComplete (IsLocalRing.maximalIdeal R) R]` (standard: m-adic completeness). "Containing a field" becomes `[Field k] [Algebra k R] [NoZeroSMulDivisors k R]`, yielding an injective ring homomorphism k → R (and in fact `NoZeroSMulDivisors k R` is automatic from `GroupWithZero.toNoZeroSMulDivisors` given `Field k` + `Algebra k R`, plus `IsLocalRing` supplies `Nontrivial R`). "𝔪 is finitely generated over A" is exactly `(IsLocalRing.maximalIdeal R).FG`. The conclusion `IsNoetherianRing R` matches Mathlib's standard definition (all ideals finitely generated). The universal quantification over R with the field k as an extra parameter correctly reflects the informal "Let A ... be a ring containing a field". No hypothesis is silently dropped or strengthened.

### 51

**Verdict:** `faithful`

**Reasoning**

The informal statement defines a Zariski ring as a Noetherian topological ring whose topology is defined by an ideal contained in the Jacobson radical. Given A is Noetherian with the 𝔞-adic topology (defined by the ideal 𝔞), the condition "A is a Zariski ring for the 𝔞-topology" reduces exactly to 𝔞 ⊆ Jac(A). The Lean statement encodes: A commutative Noetherian ring (CommRing + IsNoetherianRing), an ideal I (= 𝔞), the 𝔞-adic completion AdicCompletion I A, faithfully flat as an A-module (Module.FaithfullyFlat A (AdicCompletion I A)), iff I ≤ Ring.jacobson A. Verified in Mathlib: Ring.jacobson is the Jacobson radical of the ring, AdicCompletion I A is the standard 𝔞-adic completion, and Module.FaithfullyFlat matches the textbook notion. Both directions of the iff correspond exactly to the informal biconditional. The formalization is logically equivalent to the informal claim.

### 52

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all the components of the informal statement: `m ≤ Ring.jacobson R` encodes "m is an ideal in the Jacobson radical", `G₁.Monic` matches "G₁ is monic", `G₁.map (Ideal.Quotient.mk m)` is precisely the reduction of G₁ modulo m (giving an element of (R/m)[x]), and both "generate the unit ideal" conditions are correctly expressed as `Ideal.span {...} = ⊤`. The one point of potential concern is the use of `CommRing R` vs. just "ring" — but this is a classical commutative algebra theorem (a Nakayama-style argument relying on R[x]/(G₁) being a finitely generated R-module), and the informal language (using 𝔪, "unit ideal," and the Jacobson-radical framing) unambiguously refers to the commutative setting. The commutativity is an implicit premise standard in this context, not a strengthening of scope. All quantifier structure, types, and logical relationships match.

### 53

**Verdict:** `faithful`

**Reasoning**

The Lean formalization uses custom definitions `IsGorensteinLocalRing` (Noetherian local ring with Ext^i(k, R) = 0 for i ≫ 0) and `IsGorensteinRing` (Noetherian ring whose localizations at all maximal ideals are Gorenstein local). By Bass's theorem (Bruns-Herzog 3.1.17, Matsumura 18.1), for a Noetherian local ring, inj.dim_R R < ∞ is equivalent to Ext^i(k, R) = 0 for all i ≫ 0, so the `IsGorensteinLocalRing` class faithfully encodes the informal definition via an equivalent characterization. The global definition (localize at every maximal ideal) is the standard definition of Gorenstein for general Noetherian rings. The ring `k[X,Y,Z]/(X²-Y², Y²-Z², XY, YZ, ZX)` is correctly encoded as `MvPolynomial (Fin 3) k ⧸ Ideal.span {...}` with the five generators matching exactly. `Subsingleton` on an Ext-group (an abelian group) correctly expresses vanishing. All components match the informal claim.

### 54

**Verdict:** `faithful`

**Reasoning**

The Lean signature correctly formalizes each component. `[CommRing A] [Algebra ℚ A]` captures "ℚ-algebra" (commutativity is implicit from the informal notation `x^n A`). `Derivation ℤ A A` is equivalent to `Derivation ℚ A A` on a ℚ-algebra because any ℤ-derivation on a ℚ-vector-space-structured ring is automatically ℚ-linear. `IsHausdorff (Ideal.span {x}) A`, unfolded via Mathlib's definition, asserts `⋂_n (⟨x⟩)^n · A = 0`, which since `(⟨x⟩)^n = ⟨x^n⟩` equals `⋂_n x^n · A = 0` — exactly the informal Hausdorff condition. `x ∈ nonZeroDivisors A` is by definition the non-zero-divisor condition. The conclusion and hypotheses align with the informal statement without adding or removing content.

### 56

**Verdict:** `faithful`

**Reasoning**

The Lean signature precisely formalizes the informal claim. `[CommRing R] [CommRing S] [Algebra R S] [Module.FaithfullyFlat R S]` encodes a faithfully flat ring map R → S (commutativity is standard context for "faithfully flat ring map" with tensor products, and Mathlib's `Module.FaithfullyFlat` requires `CommRing`). `TensorProduct R S M` is S ⊗_R M, carrying its canonical S-module structure via `TensorProduct.leftModule`, so `[Module.Projective S (TensorProduct R S M)]` correctly asserts that S ⊗_R M is a projective S-module. The conclusion `Module.Projective R M` matches "M is projective." The universal quantification over R, S, M is preserved via Lean's variable binding, and no extra hypotheses are added or removed beyond those mathematically implicit in the informal setup.

### 57

**Verdict:** `faithful`

**Reasoning**

The Lean formalization defines `IsAlmostIntegral` and `IsCompletelyIntegrallyClosed` in a way that closely mirrors the informal text. For x : FractionRing A, the condition `r • (x^n) = algebraMap A (FractionRing A) y` in an A-algebra is equivalent to `algebraMap(r) * x^n ∈ range(algebraMap)`, which captures precisely "rx^n ∈ A" under the standard identification of A with its image in K. The hypothesis `r ≠ 0` matches "r ≠ 0" and, since A is a domain, also matches Mathlib's standard convention (r ∈ A⁰). `∀ n : ℕ` captures "n ≥ 0". The conclusion `IsCompletelyIntegrallyClosed (Polynomial A)` is well-typed since Mathlib automatically provides `IsDomain (Polynomial A)` from `IsDomain A` (see `Polynomial/Basic.lean:1160`). The statement "if A is completely integrally closed, so is A[X]" is captured exactly.

### 58

**Verdict:** `faithful`

**Reasoning**

The Lean signature matches the informal statement precisely. `IsLocalRing R/S` + `IsNoetherianRing R/S` + `Algebra R S` capture the local Noetherian R-algebra hypothesis. The hypothesis `Ideal.map (algebraMap R S) (maximalIdeal R) ≤ maximalIdeal S` is exactly 𝔓S ⊆ 𝔔. `Module.Finite S M` with `IsScalarTower R S M` captures "M is a finitely generated S-module". The conclusion `Module.Flat R M` matches "M is flat as R-module". Finally, the hypothesis `Module.Flat (R ⧸ 𝔓^n) ((R ⧸ 𝔓^n) ⊗[R] M)` is equivalent to "M/𝔓^n M is flat as R/𝔓^n-module" via Mathlib's `quotTensorEquivQuotSMul : (R ⧸ I) ⊗[R] M ≃ M ⧸ (I • ⊤)`, which is an R/I-linear isomorphism, and flatness is invariant under such isomorphisms. All quantifiers, types, and logical structure match.

### 59

**Verdict:** `faithful`

**Reasoning**

The Lean statement asserts unique existence of an additive valuation on FractionRing(MvPolynomial(Fin 2) k) = k(X,Y) whose restriction to polynomials matches the formula min{n+mα : c_{n,m}≠0} (via Finset.inf over the image in WithTop ℝ, which correctly gives ⊤ for zero and min otherwise). The informal "determines a valuation" is captured by existence; uniqueness is a free consequence of valuation extension to a fraction field. The value group claim (Z+Zα) is not explicitly stated in Lean, but it is a direct logical consequence of the existence: v(X)=1, v(Y)=α, v(f/g)=v(f)-v(g), and v(f)∈Z+Zα for polynomials, so image(v) on k(X,Y)^× equals exactly Z+Zα. Thus the Lean statement is logically equivalent to the informal claim — neither strictly weaker nor stronger.

### 6

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures exactly the informal claim. `Nat.card G = 396` encodes |G| = 396, and `¬ IsSimpleGroup G` captures "G is not simple" using Mathlib's standard definition (a group is simple iff it is nontrivial and every normal subgroup is ⊥ or ⊤). The `[Finite G]` instance is redundant but not restrictive, because `Nat.card G = 396` already forces G to be finite (Nat.card returns 0 for infinite types, per Mathlib's `card_eq_zero` lemma). Thus the set of models satisfying the Lean hypotheses is exactly the set of finite groups of order 396, matching the informal statement. Nontriviality of the conclusion's definition is not an issue since |G| = 396 > 1. The formalization is logically equivalent to the informal claim.

### 61

**Verdict:** `faithful`

**Reasoning**

The Lean statement precisely encodes the informal claim. Each hypothesis maps correctly: `I ^ 2 = 0` matches I² = 0 (using `Ideal.zero_eq_bot`); `[Module.Flat R S]` is the standard formulation of R → S being flat; `[Algebra.FormallySmooth (R ⧸ I) (S ⧸ (I.map (algebraMap R S)))]` correctly encodes R/I → S/IS formally smooth, where `I.map (algebraMap R S)` is the ideal IS (image of I in S) and the natural algebra instance R/I → S/IS is provided by `Ideal.Quotient.algebraQuotientMapQuotient`. The conclusion `Algebra.FormallySmooth R S` matches "R → S formally smooth." The CommRing assumption is standard Stacks convention for "ring." No hypotheses are dropped or added, no quantifiers are changed.

### 62

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement component-by-component. The ring map φ is encoded as `algebraMap R S` via `[Algebra R S]`, and `Algebra.Smooth R S` is Mathlib's standard definition (formally smooth + finite presentation), matching "smooth ring map". `Function.LeftInverse σ (algebraMap R S)` unfolds to `∀ r, σ(algebraMap R S r) = r`, precisely σ∘φ = id_R. `I = Ker(σ)` becomes `RingHom.ker σ`, and `(RingHom.ker σ).Cotangent` is `I⧸(I•⊤)` = I/I², with `Module.Free R` the natural R-module freeness (R-module structure arises via `Algebra R S` and the derived scalar tower on Cotangent). The conclusion `∃ d : ℕ, Nonempty (AdicCompletion (RingHom.ker σ) S ≃ₐ[R] MvPowerSeries (Fin d) R)` matches "S^ ≅ R[[t₁,…,t_d]] as R-algebras"; the existential for d is appropriate because the informal statement leaves d implicit (it's the rank of I/I², which is finite since smoothness entails finite presentation). No hypotheses are silently added or dropped.

### 64

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly encodes the informal statement. The ring k[s⁴, s³t, st³, t⁴] ⊂ k[s,t] is captured by `Algebra.adjoin k {X_0^4, X_0^3·X_1, X_0·X_1^3, X_1^4}` inside `MvPolynomial (Fin 2) k`, which is precisely the k-subalgebra generated by these four monomials in the 2-variable polynomial ring. The `IsCohenMacaulayRing` class defined in the file encodes the standard definition: for all prime ideals p, the localization at p is a local ring satisfying `ringKrullDim = depth`, where depth is defined via vanishing of Ext^i (the standard Ext-characterization of depth). The universal quantification over fields k is preserved, and the universe restriction to Type (rather than Type*) is forced by the `ModuleCat.{0}`/`HasExt.{0}` infrastructure and is a standard Lean convention rather than a substantive mathematical restriction. The negation `¬ IsCohenMacaulayRing ...` faithfully captures "is not Cohen-Macaulay".

### 65

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. (1) `IsGorensteinLocalRing` extends `IsLocalRing` and `IsNoetherianRing` and asserts ∃n, ∀i≥n, Ext^i(k, R) vanishes — which is equivalent to "inj.dim_R R < ∞" by Bass's classical theorem for Noetherian local rings (inj.dim_R R = sup{i : Ext^i(k,R) ≠ 0}). (2) `IsGorensteinRing` extends `IsNoetherianRing` and requires every localization at a maximal ideal to be `IsGorensteinLocalRing`, matching the informal definition exactly. (3) The theorem `[IsGorensteinRing R] → IsGorensteinRing R[X]` correctly encodes "if A is Noetherian Gorenstein, then A[X] is Noetherian Gorenstein" (Noetherian-ness is absorbed into `IsGorensteinRing`). The Mathlib convention `Ext X Y n = Ext^n(X, Y)` is applied correctly. The Type-0 universe restriction is an implementation choice common in Mathlib formalizations using specific ModuleCat universes, not a semantic weakening.

### 66

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. Hypotheses match: `CommRing R` + `IsNoetherianRing R` = "Noetherian ring"; `I = Ideal.ofList rs` + `Sequence.IsRegular R rs` = "I is generated by a regular sequence" (where `Sequence.IsRegular R rs` correctly uses R as a module over itself, matching standard commutative-algebra usage of "regular sequence in R"). The conclusion `∃ rs', I = Ideal.ofList rs' ∧ (∀ l, l.Perm rs' → Sequence.IsRegular R l)` precisely encodes "I can be generated by a set of elements that is a regular sequence in any order" — the existential matches "can be generated by", and quantifying over all permutations l of rs' captures "in any order". Mathlib's `Ideal.ofList rs = span {r | r ∈ rs}` correctly represents "generated by". No hypothesis is dropped or added beyond what the informal statement implies.

### 67

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully encodes the informal claim. The ring $k[[x_1,\dots,x_n]]$ is represented by `MvPowerSeries (Fin n) k` and the 2n-variable power series ring $k[[x_1,\dots,x_n,y_1,\dots,y_n]]$ by `MvPowerSeries (Fin (n + n)) k`, which are the standard Mathlib encodings. The tensor product $A \otimes_k A$ is given by `(MvPowerSeries (Fin n) k) ⊗[k] (MvPowerSeries (Fin n) k)` with the scoped TensorProduct notation. The hypothesis `hn : n ≠ 0` matches the informal $n \neq 0$. "No isomorphism" is encoded as `IsEmpty (...)`, which is equivalent to asserting the type of `k`-algebra equivalences is empty — i.e., no such isomorphism exists. Using `≃ₐ[k]` (k-algebra equivalence) is the natural reading given that the tensor product is taken over $k$. All quantifier structure, types, and assumptions match.

### 68

**Verdict:** `faithful`

**Reasoning**

The Lean signature encodes each component of the informal statement correctly. `[CommRing R] [IsLocalRing R] [IsNoetherianRing R]` captures "Noetherian local ring". `hf : f ∈ IsLocalRing.maximalIdeal R` captures "f ∈ 𝔪". `¬ IsNilpotent f` captures "f is not nilpotent". `Localization.Away f` is defined in Mathlib as `Localization (Submonoid.powers f)`, which is exactly the localization $A_f$. `IsJacobsonRing` is Mathlib's standard Jacobson-ring predicate (every radical ideal equals its Jacobson radical). No hypotheses are added or removed beyond what the informal statement specifies. Thus, the Lean statement is logically equivalent to the informal claim.

### 69

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the informal claim precisely. The local `IsRegularLocalRing` class correctly encodes "regular local ring" via Mathlib's `CotangentSpace` (= m/m²) equipped with `ResidueField R`-module structure, and equates its `finrank` to `ringKrullDim R`, which is the standard definition. The hypothesis `[P.LiesOver (maximalIdeal R)]` unfolds (via `Ideal.LiesOver.over`) to `maximalIdeal R = P.comap (algebraMap R R[X])`, i.e., m = P ∩ R. The conclusion `IsRegularLocalRing (Localization.AtPrime P)` correctly formalizes "R[x]_P is regular". The introductory phrase "Let A be a Noetherian ring" in the informal text introduces an unused variable A and is vestigial; omitting it does not alter the claim (regular local rings are Noetherian by definition, captured by `extends IsNoetherianRing R`). No hypothesis is silently dropped or added beyond what the informal text implies.

### 7

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that any group G with order 1785 is not simple. The Lean statement quantifies over types G with [Group G], assumes Nat.card G = 1785 (the standard Mathlib encoding of group order), and concludes ¬ IsSimpleGroup G. The [Finite G] instance is logically redundant since Nat.card G = 1785 ≠ 0 already forces G to be finite (Nat.card returns 0 for infinite types), so adding it doesn't narrow the claim — it just surfaces an implicit premise. IsSimpleGroup in Mathlib is precisely the standard definition (Nontrivial G plus only trivial normal subgroups are ⊥ or ⊤). The formalization captures exactly the intended universal claim about finite groups of order 1785.

### 70

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures all components of the informal statement. Both rings are Noetherian via `IsNoetherianRing`, R is an integral domain via `IsDomain R`, and S is a local ring via `IsLocalRing S` (with Q implicitly being `IsLocalRing.maximalIdeal S`). The "R contained in S" is encoded via `[Algebra R S] [NoZeroSMulDivisors R S]`: since R is a domain and S is nontrivial (being local), Mathlib's `NoZeroSMulDivisors.iff_algebraMap_injective` (derived from `isTorsionFree_iff_algebraMap_injective` in `Mathlib/Algebra/Algebra/Basic.lean`) gives that this is equivalent to injectivity of `algebraMap R S`, i.e., R embeds as a subring of S. The conclusion `∃ (p : minimalPrimes S), Ideal.comap (algebraMap R S) p.1 = ⊥` correctly expresses that some minimal prime of S contracts to 0 in R. No hypotheses are silently added or dropped, and the quantifier structure matches.

### 71

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the Hochster-Eagon theorem: a finite subgroup G of R's k-algebra automorphisms (equivalent to a finite group acting by k-algebra automorphisms on R up to the fixed-point ring), over a characteristic-0 field k, with R Cohen-Macaulay, yields that the fixed subalgebra is Cohen-Macaulay. The addition of `[IsNoetherianRing R]` is not a weakening: in standard mathematical convention (Eisenbud, Matsumura), a Cohen-Macaulay ring is by definition Noetherian, but the file's custom `IsCohenMacaulayRing` (defined via localizations having depth = Krull dimension) does not automatically include Noetherianness. Adding `IsNoetherianRing R` explicitly surfaces this implicit premise of the classical CM definition. The `FixedPoints.subalgebra` construction correctly captures R^G as a k-subalgebra, and the subgroup-of-Aut formulation is logically equivalent to the abstract-group-with-action formulation since fixed-point rings depend only on the image of the action homomorphism. Types and quantifier structure align with the informal claim.

### 72

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal claim. The hypotheses match exactly: R is a commutative Noetherian ring ([CommRing R] + [IsNoetherianRing R]), M is a Cohen-Macaulay R-module ([Module.IsCohenMacaulay R M]), and n is a natural number. The conclusion uses (MvPolynomial (Fin n) R) ⊗[R] M instead of M ⊗_R R[x_1,...,x_n], but tensor products over commutative rings are naturally symmetric and the `leftModule` instance provides the canonical polynomial-ring module structure, making them mathematically equivalent. Both hypothesis and conclusion use the same `Module.IsCohenMacaulay` class defined in the file, so the comparison is internally consistent. The universe restriction to Type 0 is a standard Lean convention that doesn't change the mathematical content.

### 73

**Verdict:** `faithful`

**Reasoning**

The Lean statement formalizes the informal claim via a surjection `f : MvPolynomial (Fin n) k →+* R` (equivalent to presenting R as a quotient) with homogeneous kernel. The hypothesis `RingHom.ker f ≤ RingHom.ker MvPolynomial.constantCoeff` surfaces an implicit premise: since `ker constantCoeff = (x_0,...,x_{n-1})` is the irrelevant ideal P, and any proper homogeneous ideal is automatically contained in P, this hypothesis amounts to requiring R ≠ 0 — which is implicitly needed for the informal "R_P" to make sense as a localization at a prime ideal (exactly what `Ideal.map_isPrime_of_surjective` requires). The RHS `Localization.AtPrime ((ker constantCoeff).map f)` is R_{f(P)}, the natural meaning of R_P. The CM definitions (via Ext-depth equalling Krull dimension at all prime localizations) match the standard notion. The `Fin n` vs `n+1` variable indexing is cosmetic since both are universally quantified. No hypothesis or conclusion is genuinely strengthened or weakened.

### 74

**Verdict:** `faithful`

**Reasoning**

All components of the informal statement match the Lean formalization. `[IsRegularLocalRing R]` captures "regular local ring" per the custom class defined in the file. `RingTheory.Sequence.IsRegular R rs` is Mathlib's standard regular-sequence notion applied to R-as-a-module (non-zero-divisor chain plus properness of the generated ideal), matching "x_1,...,x_c regular sequence in R". `Ideal.ofList rs / Ideal.span {y}` unfolds via Mathlib's `Submodule.Div` (defined as `{x | ∀ z ∈ J, x·z ∈ I}`) to exactly the colon ideal `((x_1,…,x_c):y)`, matching J. Finally, since R is local and J is proper (ensured by `y ∉ (rs)`), R⧸J is local, so `IsGorensteinRing (R⧸J)` (the custom class: all maximal-ideal localizations are Gorenstein-local) is equivalent to "R⧸J is Gorenstein" in this local context. The three custom classes faithfully encode their informal definitions.

### 75

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures exactly what the informal statement asserts. The hypotheses "graded Noetherian ring with A_0 a field and A generated by A_1" are encoded via `[IsNoetherianRing A]`, `(𝒜 : ℕ → Submodule ℤ A) [GradedAlgebra 𝒜]`, `IsField (𝒜 0)`, and `Algebra.adjoin (𝒜 0) (𝒜 1) = ⊤`. The key semantic point is that Mathlib's `HomogeneousLocalization.AtPrime 𝒜 p` is defined as fractions a/b with a, b homogeneous of the SAME degree and b ∉ p (numerator/denominator of same degree), which is precisely the degree-0 part of the homogeneous localization (A_p)_0 used in the informal statement. Mathlib also shows this is a local ring. The biconditional "A is Cohen-Macaulay iff for all homogeneous primes p, (A_p)_0 is Cohen-Macaulay" is captured as an iff between `IsCohenMacaulayRing A` (all localizations at primes are CM local) and the forall-statement over homogeneous primes, which matches the informal claim.

### 76

**Verdict:** `faithful`

**Reasoning**

The Lean `IsCatenary` definition captures "all maximal chains of primes from p to q have the same length n" via the existential-over-n followed by universal quantification over maximal chains (where maximality is correctly encoded by the sublist-containment condition: any chain l' with l.toList as a sublist must equal l, meaning l cannot be refined by inserting more primes). The `LTSeries` (strictly increasing) matches the informal strict chain p_0 ⊂ p_1 ⊂ ... ⊂ p_e, with `head`/`last` matching endpoints. While the informal definition explicitly includes the "integer bounding all finite chains" clause that the Lean omits, for the specific ring A in the theorem (Noetherian with ringKrullDim ≤ 3), all chains are automatically bounded by dim+1, so the two definitions coincide for A. The hypotheses `IsNoetherianRing A`, `IsDomain A`, `UniqueFactorizationMonoid A`, and `ringKrullDim A ≤ 3` precisely match "Noetherian UFD of dimension ≤ 3". Using `p ≤ q` vs `p ⊂ q` is harmless (the p=q case is trivial). The theorem is logically equivalent to the informal statement in this context.

### 77

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal statement. The Noetherian ring, prime ideals P ⊆ Q, and height conditions ht(P) = h and ht(Q/P) = d (encoded as `(Q.map (Ideal.Quotient.mk P)).height = d`, which is the standard Mathlib convention for the height of Q/P as the image of Q in R/P) all match. The condition `1 < d` is explicit. Although the informal uses strict `P ⊂ Q` while Lean uses `P ≤ Q`, strictness is automatically forced by `d > 1` combined with the height hypothesis. Similarly, in the conclusion set `{P' | P ≤ P' ∧ P' ≤ Q ∧ ...}`, the conditions `P'.height = h + 1 ≠ h` and `(Q.map (Quotient.mk P')).height = d - 1 ≥ 1 ≠ 0` force P ≠ P' and P' ≠ Q, making `≤` equivalent to strict `<`. `Set.Infinite` correctly encodes "infinitely many". The use of `Type` instead of `Type*` is a minor universe restriction that does not affect the mathematical content.

### 78

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures all components of the informal statement: (1) `[IsCohenMacaulayLocalRing A]` encodes "A is a local CM ring"; (2) `[IsRegularLocalRing B]` together with `{f : B →+* A}` and `hf : Function.Surjective f` encode "A is a quotient of a regular local ring" — this universal-over-B,f form is logically equivalent to an existential since the conclusion doesn't depend on B or f; (3) `[IsDomain A]` + `[UniqueFactorizationMonoid A]` is the standard Mathlib encoding of "UFD" (since `UniqueFactorizationMonoid` alone doesn't imply `Nontrivial`); (4) `IsGorensteinRing A` is defined via localization at every maximal ideal, but since A is local with a unique maximal ideal whose localization is isomorphic to A, this is logically equivalent to `IsGorensteinLocalRing A`, matching the informal "A is Gorenstein". No hypotheses are silently added or dropped.

### 79

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully formalizes the informal claim. B being a regular local ring is encoded via `[IsRegularLocalRing B]` (defined correctly as dim m/m² = dim R). I is declared as `(I : Ideal B)`. "B/I is Gorenstein" is encoded as `[IsGorensteinRing (B ⧸ I)]`; since B is local, B/I is local, and for local Noetherian rings the general `IsGorensteinRing` condition (localization at every maximal ideal is Gorenstein local) is equivalent to `IsGorensteinLocalRing` because B/I is isomorphic to its localization at the unique maximal ideal. "Not a local complete intersection" is correctly given by `¬ IsLocalCompleteIntersectionRing (B ⧸ I)` (Stacks 09Q3 formulation via completions and regular sequences). The conclusion `I.height ≠ 0 ∧ I.height ≠ 1` in `ℕ∞` precisely expresses "I cannot have height 0 or 1". Quantifier structure and types all match.

### 80

**Verdict:** `faithful`

**Reasoning**

All six polynomial generators match the informal ideal (accounting for the 0-indexing of Fin 6: X i in Lean corresponds to x_{i+1} in the informal statement). The ring target_ring_aux k correctly encodes k[x_1,...,x_6]/I. The Lean theorem asserts the conjunction "IsCohenMacaulayRing (R/I) ∧ ringKrullDim (R/I) = 3", which is the natural reading of "R/I is Cohen-Macaulay of dimension 3". The CM ring definition used (every prime localization is CM local, i.e., ringKrullDim = depth via Ext-vanishing) is the standard textbook definition for Cohen-Macaulay rings, and the depth via Ext-vanishing over the maximal ideal matches the standard homological definition of depth. No hypotheses are silently added or dropped, and the quantifier structure is correct.

### 82

**Verdict:** `faithful`

**Reasoning**

The Lean formalization accurately captures the informal statement of (a corollary of) the Cohen structure theorem for mixed characteristic complete Noetherian local rings. All hypotheses translate correctly: `[IsNoetherianRing A]`, `[IsLocalRing A]`, `[IsAdicComplete (maximalIdeal A) A]`, `ringKrullDim A = d`, `[CharZero A]` and `[CharP (ResidueField A) p]` for mixed characteristic, and `(Ideal.span {(p : A)}).height = 1` for ht(pA) = 1. The extra hypothesis `hp : p.Prime` makes explicit an implicit premise: in a mixed characteristic setting with char(A) = 0, the characteristic p of the residue field (a field) must be a prime — this is exactly the kind of implicit-premise-made-explicit case that qualifies as faithful. The conclusion `∃ B : Subring A, Module.Finite B A ∧ ∃ C ..., IsDiscreteValuationRing C ∧ Nonempty (B ≃+* MvPowerSeries (Fin (d-1)) C)` faithfully encodes "A is a finitely generated B-module for some subring B ≅ C[[x_1,...,x_{d-1}]] with C a DVR". Note that `d - 1` uses ℕ truncated subtraction, but the hypothesis ht(pA) = 1 forces dim A ≥ 1, so no degenerate case arises.

### 83

**Verdict:** `faithful`

**Reasoning**

The `IsRegularLocalRing` class is defined correctly: a commutative local Noetherian ring satisfying dim_{R/m}(m/m²) = dim(R), where `CotangentSpace R` is m/m². The theorem statement faithfully captures all hypotheses: A is a regular local ring (which entails CommRing, IsLocalRing, IsNoetherianRing); B is a commutative local Noetherian ring (explicit instances); f : A →+* B is a local homomorphism (`IsLocalHom f`) and flat (`f.Flat` = Module.Flat A B via f.toAlgebra); and B/mA·B is regular (where `(maximalIdeal A).map f` is Ideal.span (f '' maximalIdeal A) = mA·B, the extension ideal). The conclusion `IsRegularLocalRing B` exactly matches "B is regular". Making B's local/Noetherian structure explicit is necessary for the informal phrase "maximal ideals mA and mB respectively" and "Noetherian rings" to make sense — these are implicit premises of the informal statement made explicit in Lean, not extra hypotheses narrowing the scope.

### 84

**Verdict:** `faithful`

**Reasoning**

The Lean statement accurately captures the informal claim. `[CommRing R]` and `[Module.Projective R M]` match the hypotheses "commutative ring R" and "projective module M". The existential `∃ (N : Type) (_ : AddCommGroup N) (_ : Module R N), Module.Free R N` expresses "there exists a free R-module N". The conclusion `Module.Free R (N × M)` correctly expresses "M ⊕ N is free", since in Mathlib the binary direct sum of two modules is encoded as the product type `N × M` (confirmed by the `Module.Free.prod` instance in `Mathlib/LinearAlgebra/Basis/Prod.lean`). The order "N × M" vs. informal "M ⊕ N" is immaterial since direct sum is commutative. The universe restriction to `Type` (Type 0) is a standard formalization choice and does not change the mathematical content — this is the classical Eilenberg swindle.

### 85

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts the existence of a transfinite Euclidean domain that cannot be equipped with a ℕ-valued Euclidean norm (Hiblot-Nagata theorem). Mathlib's `EuclideanDomain` is precisely the "transfinite Euclidean domain" (confirmed by the Mathlib docstring in `Algebra/EuclideanDomain/Defs.lean`: "sometimes called a transfinite Euclidean domain"), as it uses a well-founded relation rather than a ℕ-valued norm. The `EuclideanNormNat` class defined locally in the file mirrors the axioms of a classical Euclidean domain with norm values in ℕ. The statement `∃ R, ∃ (_ : EuclideanDomain R), IsEmpty (EuclideanNormNat R)` correctly expresses: there exists a ring R with a transfinite Euclidean domain structure such that no ℕ-valued Euclidean norm structure can be given to R. Typeclass resolution of `[CommRing R]` in `EuclideanNormNat R` will use the `CommRing R` instance derived from `EuclideanDomain R`, so the existential asks the right question about the same underlying ring. The formalization is logically equivalent to the informal statement.

### 86

**Verdict:** `faithful`

**Reasoning**

The Lean statement directly encodes the informal inequality "dim A[x,y] + dim A ≤ 2·dim A[x]" using Mathlib's `ringKrullDim`, with `MvPolynomial (Fin 2) A` correctly representing A[x,y] and `Polynomial A` correctly representing A[x]. The hypothesis `[CommRing A]` exactly matches "commutative ring A", and no additional hypotheses (e.g., Noetherian, Nontrivial, finite-dimensional) are added or dropped. The arithmetic operations `+`, `2 *`, and `≤` are well-defined on `WithBot ℕ∞` (the codomain of `ringKrullDim`). The universal quantification over arbitrary commutative rings A is preserved. This is a faithful formalization.

### 87

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly captures the informal claim: it asserts the existence of two commutative rings R, S (given via `CommRing R`, `CommRing S`) with a ring isomorphism between their polynomial rings (`Nonempty ((Polynomial R) ≃+* (Polynomial S))`) and no ring isomorphism between R and S themselves (`IsEmpty (R ≃+* S)`). `Polynomial R` is Mathlib's standard R[x], `≃+*` is the standard ring equivalence, `Nonempty` encodes "there exists an isomorphism" and `IsEmpty` encodes "there is no isomorphism". The use of `Type` (universe 0) is a standard, benign convention — known counterexamples (e.g., Hochster's) exist in small universes, so the mathematical content is unchanged.

### 88

**Verdict:** `faithful`

**Reasoning**

The informal statement asks to show that $R = \mathbb{C}[x,y,z]/(x^2+y^3+z^7)$ is a UFD. In Mathlib, "being a UFD" is standardly expressed as having both `IsDomain R` (nontrivial + cancellative multiplication = integral domain) and `UniqueFactorizationMonoid R` (well-founded divisibility + Irreducible ↔ Prime). The Lean statement `∃ (h : IsDomain R), UniqueFactorizationMonoid R` is logically equivalent to `IsDomain R ∧ UniqueFactorizationMonoid R` since the second conjunct doesn't depend on `h`. This captures exactly the standard mathematical definition of a UFD. The definition of `R` as the quotient of `MvPolynomial (Fin 3) ℂ` by the ideal spanned by `X 0 ^ 2 + X 1 ^ 3 + X 2 ^ 7` matches $\mathbb{C}[x,y,z]/(x^2+y^3+z^7)$.

### 89

**Verdict:** `faithful`

**Reasoning**

The Lean statement universally quantifies over groups G (via `G : Type` with `[Group G]`), assumes `Nat.card G = 336`, and concludes `¬ IsSimpleGroup G`. Mathlib's `IsSimpleGroup` (a group with exactly two normal subgroups, extending `Nontrivial`) is the standard definition of a simple group; nontriviality is automatic since |G| = 336 > 1. The extra `[Finite G]` hypothesis is logically redundant: `Nat.card G = 336 ≠ 0` already implies `Finite G` (an infinite type has `Nat.card = 0` per `Nat.card_eq_zero_of_infinite`/`finite_of_card_ne_zero`). Thus the Lean statement is logically equivalent to the informal claim, neither weaker nor stronger.

### 9

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes the informal claim. (1) G is a finite group with prime p, and S, T are distinct Sylow p-subgroups. (2) The maximality hypothesis `∀ S' T', S' ≠ T' → |S' ∩ T'| ≤ |S ∩ T|` matches "S ∩ T has maximal size among intersections of distinct Sylow p-subgroups" — note that `(S' : Set G) ⊓ T'` as sets equals the subgroup intersection as a set, so `Set.ncard` gives the right order. (3) The conclusion `∀ (P : Sylow p (S ⊓ T).normalizer), ¬ P.Normal` faithfully captures "N_G(S ∩ T) does not admit a normal Sylow p-subgroup" — in Mathlib, `P.Normal` for `P : Sylow p H` means the underlying subgroup is normal in H, so universally quantifying over Sylow p-subgroups of N_G(S ∩ T) and negating normality correctly expresses the claim. Types, quantifier structure, and hypotheses all match the informal statement.

### 90

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the claim: for any field $k$, there exists $n$ and an intermediate field $K$ of $k(x_1,...,x_n)/k$ such that $K \cap k[x_1,...,x_n]$ is not a finitely generated $k$-algebra. Although the informal statement says "$n > 0$" while Lean uses `n : ℕ`, the two are logically equivalent because $n = 0$ gives `FractionRing (MvPolynomial (Fin 0) k) ≃ k`, the only intermediate field is $\top$, and the intersection is trivially finitely generated — so $n = 0$ cannot witness the Lean existential. The use of `IntermediateField` (which requires $K \supseteq k$) correctly surfaces the implicit premise needed for "$K \cap k[x_1,...,x_n]$ is a $k$-algebra" to make sense. The intersection `K.toSubalgebra ⊓ (algHom ...).range` correctly represents $K \cap k[x_1,...,x_n]$ viewed inside the fraction field, and `Algebra.FiniteType` is the standard notion of finitely generated $k$-algebra.

### 91

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully captures the informal claim. The local abbreviation `CommRing.Pic R := (Skeleton <| ModuleCat.{0} R)ˣ` encodes the Picard group correctly: `Skeleton (ModuleCat R)` is a Monoid under tensor product (per `Mathlib/CategoryTheory/Monoidal/Skeleton.lean`), and its units are precisely isomorphism classes of invertible R-modules — equivalent to Mathlib's `CommRing.Pic` up to the `Shrink` universe adjustment. The ring `MvPolynomial (Fin 2) k ⧸ Ideal.span {X 0 * X 1 * (X 0 + X 1 - 1)}` is exactly $k[x,y]/(xy(x+y-1))$. The `Nonempty (... ≃* kˣ)` wrapper asserts the existence of a multiplicative/group isomorphism, which is the standard reading of "$\cong$" between groups. The hypotheses (`k` is a field) and conclusion match the informal statement with no added or dropped assumptions.

### 93

**Verdict:** `faithful`

**Reasoning**

The Lean signature matches each piece of the informal statement. `Field k` gives a field; `Ring A` gives a (not necessarily commutative) unital ring in Mathlib's convention, distinct from `CommRing`; `Algebra k A` gives the k-algebra structure. `Algebra.IsIntegral k A` (defined in Mathlib as `∀ x : A, IsIntegral k x`) requires every element of A to be integral over k — and it is the intended notion for possibly non-commutative A (only `[CommRing R] [Ring A]` is required). `Algebra.FiniteType k A` is the class `(⊤ : Subalgebra k A).FG`, meaning A is finitely generated as a k-algebra, matching the informal "finitely generated over k". `¬ FiniteDimensional k A` (which unfolds to `¬ Module.Finite k A`) is exactly "dim_k A is not finite". Restricting to `Type 0` is innocuous here since concrete counterexamples fit in `Type 0`. There is no drift in hypotheses, conclusion, quantifier structure, or ambient objects.

### 94

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement in all essential respects. The hypotheses `[Field k] [CharZero k] [CommRing A] [IsDomain A] [Algebra k A] [Algebra.FiniteType k A]` encode "k is a field of char 0, A is a finite-type k-algebra that is a domain". The set definition `{n | ∀ x : I, (ϕ.comp (f ^ n)) (x : A) = 0}` correctly encodes `{n : ℕ | (φ ∘ f^n)|_I = 0}` (where `f^n` is iterated composition via the `Monoid (A →ₐ[k] A)` instance). The conclusion `(zeroSet f ϕ I).Finite ∨ ∃ (d : ℕ+) (a : ℕ), ∀ n, a + d * n ∈ zeroSet f ϕ I` correctly captures "either finite or contains an arithmetic progression with positive common difference" (d : ℕ+ makes d positive). On the subtle point: the informal says "étale" while Lean uses `f.FormallyEtale`; however, in Mathlib `Algebra.Etale = FormallyEtale + FinitePresentation`, and in this context A is finite-type over the field k hence Noetherian, and any k-algebra endomorphism f : A → A gives A a finite-type (hence finite presentation, since A is Noetherian) A-algebra structure via f, so formally étale and étale coincide for such f. The two formulations are mathematically equivalent in this setting.

### 95

**Verdict:** `faithful`

**Reasoning**

The Lean `f` definition uses `eval₂RingHom (aeval (a•Y + C p)).toRingHom (C X)` on `ℂ[X][Y]`, which sends `Y ↦ C X` (i.e., y ↦ x) and `C X ↦ a•Y + C p` (i.e., x ↦ p(x) + ay), exactly matching the informal map. The hypotheses `p.natDegree > 1` is equivalent to "degree > 1" (they agree for both zero and nonzero polynomials), `a ≠ 0`, `𝔭.IsPrime`, and `𝔭.height = 1` (which for a prime ideal equals `primeHeight`, the standard height via chains of primes) all match the informal. `𝔭.map (f a p)` is the ideal generated by the image, which coincides with the direct image since f is an automorphism when a ≠ 0 (invertible via x ↦ y, y ↦ (x - p(y))/a). The type `ℂ[X][Y]` is canonically isomorphic to `MvPolynomial (Fin 2) ℂ` representing ℂ[x,y]. The duplicate parameter name `h` is merely cosmetic shadowing — both hypotheses remain part of the statement.

### 97

**Verdict:** `faithful`

**Reasoning**

The Lean statement is a logically equivalent rendering of the informal claim. `[Finite τ] [Nonempty τ]` encodes "n ∈ ℕ, n ≠ 0" (any positive finite cardinality). `CharZero k` plus `Field k` matches "field of characteristic zero". The hypothesis `(f i).natDegree ≥ 2` is equivalent to "degree at least two" — since natDegree = 0 for the zero polynomial, natDegree ≥ 2 forces f_i ≠ 0 and makes its true degree ≥ 2. The endomorphism `MvPolynomial.aeval (fun i ↦ (f i).toMvPolynomial i)` sends X_i ↦ f_i(X_i) via Polynomial.toMvPolynomial (verified in Mathlib/Algebra/MvPolynomial/Equiv.lean), exactly encoding φ. The `^m` on `A →ₐ[R] A` uses the `AlgHom.End` monoid instance (Mathlib/Algebra/Algebra/Hom.lean:344), i.e., m-fold composition. By `comp_aeval_apply`, `aeval a (φ p) = aeval (fun i ↦ f_i(a_i)) p = p(F(a))`, so `aeval a (φ^m p)` equals `p(F^m(a))`, matching the informal conclusion. No hypotheses are added or dropped.

### 98

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully captures each part of the informal statement. The typeclasses `[Field K] [NumberField K] [CommRing A] [IsDomain A] [Algebra K A] [Algebra.FiniteType K A]` match "K number field, A finite-type K-algebra, A domain". The endomorphism `f : A →ₐ[K] A` is the natural reading of "endomorphism" in a K-algebra context, and on `AlgHom.End` multiplication is composition with `1 = id`, so `∀ n > 0, f^n ≠ 1` is precisely `¬ IsOfFinOrder f` (via `isOfFinOrder_iff_pow_eq_one`), which is "f is not of finite order". The conclusion `∃ m, m.IsMaximal ∧ ∀ n > 0, m.comap (f^n) ≠ m` matches "exists a maximal ideal m such that for all n ∈ ℕ_+, f^{-n}(m) ≠ m", since `Ideal.comap (f^n) m` is exactly the preimage (f^n)^{-1}(m). No hypotheses are added or dropped, and the quantifier structure matches.

### 99

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully captures the informal statement. The hypotheses `[CommRing A] [IsDomain A] [Algebra ℂ A] [Algebra.FiniteType ℂ A]` correctly encode "finite-type ℂ-algebra domain". The constraint `hn : n ≥ 1` matches the explicit informal condition "n ≥ 1". The automorphism group `A ≃ₐ[ℂ] A` carries the standard `Group` instance (`AlgEquiv.aut` in Mathlib), so `≃*` correctly expresses the group isomorphism between the ℂ-automorphism groups. `MvPolynomial (Fin n) ℂ` is the standard encoding of ℂ[x_1,...,x_n], and `Nonempty (A ≃ₐ[ℂ] MvPolynomial (Fin n) ℂ)` correctly encodes "A is isomorphic to ℂ[x_1,...,x_n] as ℂ-algebras". No hypotheses are silently added or dropped, and the quantifier structure matches.

## weaker (8)

### 10

**Verdict:** `weaker`

**Reasoning**

The informal statement asserts that $A = \mathbb{R}[X,Y]/(X^2+Y^2+1)$ is a principal ideal **domain** (PID), which in Mathlib's convention requires BOTH `[IsDomain A]` AND `[IsPrincipalIdealRing A]` (as explicitly stated in `Mathlib/RingTheory/PrincipalIdealDomain.lean`: "there is no explicit definition of a PID; one should use `[IsDomain R] [IsPrincipalIdealRing R]`"). The Lean signature only asserts `IsPrincipalIdealRing`, which just means every ideal is principal — a strictly weaker property than being a PID (e.g., $\mathbb{Z}/6\mathbb{Z}$ satisfies `IsPrincipalIdealRing` but is not a domain). The `IsDomain` condition is not automatically inferred from the typeclass system for the quotient, so the Lean statement literally only requires proving one of the two parts of the PID claim. Notably, Problem 12 in the same dataset formalizes "is a PID" as `IsPrincipalIdealRing ... ∧ IsDomain ...`, confirming that the author recognizes both conjuncts are needed. The Lean statement is implied by the informal claim but does not imply it.

### 2

**Verdict:** `weaker`

**Reasoning**

The Lean formalization uses `IsMin` on the subtype `{H : Subgroup G // H.Normal}`, but this is semantically wrong for "minimal normal subgroup". `IsMin H` is defined as `∀ b, b ≤ H → H ≤ b`, i.e., H is a minimum (bottom) element. Since the trivial subgroup ⊥ is always normal (`Subgroup.normal_bot`), ⟨⊥, _⟩ is always in the subtype, and ⊥ ≤ H for every H. Thus `IsMin H` forces H = ⊥, making `{H | IsMin H}` always a singleton and its ncard always 1 ≤ 2 — a trivial tautology. The correct encoding for "minimal normal subgroup" (atom in the normal subgroup lattice, i.e., a non-trivial normal subgroup with no proper non-trivial normal subgroup inside it) would use `IsAtom`, not `IsMin`. Since the Lean statement is a tautology, it is implied by the informal statement but does not imply it, making the Lean statement strictly weaker.

### 22

**Verdict:** `weaker`

**Reasoning**

The second conjunct of the conclusion, `∀ x : F, IsIntegral ℤ x → ‖(x : ℂ)‖ = 1 → ∃ n, x ^ n = 1`, is trivially true. Since no type is given for `n`, Lean elaborates `n : ℕ` by default (using the `Monoid.npow`-derived `HPow F ℕ F` instance, as `F` is a field), and `pow_zero` gives `x ^ 0 = 1` in any monoid. Thus one can always pick `n = 0`, making this clause vacuous — it does not express "x is a root of unity". Mathlib's own convention for roots of unity requires `0 < n` (see `isOfFinOrder_iff_pow_eq_one : IsOfFinOrder x ↔ ∃ n, 0 < n ∧ x ^ n = 1` in `GroupTheory/OrderOfElement.lean`). Because the informal claim "each algebraic integer is a root of unity" implies the Lean statement but not conversely (the Lean statement is implied by even weaker facts), the formalization is logically weaker. The other pieces — `IsMulCommutative (F ≃ₐ[ℚ] F)` for abelian Galois group, `Module.Finite ℚ F` + `IsGalois ℚ F` for finite Galois, and the finiteness conjunct — are fine.

### 42

**Verdict:** `weaker`

**Reasoning**

The informal statement concerns k-algebras A = k[[x,y]]/(xy) and B = k[[u,v]]/(g), where "A and B are isomorphic" naturally means isomorphic as k-algebras (the standard reading for k-algebras in commutative algebra). The Lean formalization uses `≃+*` (RingEquiv), which is ring isomorphism, rather than `≃ₐ[k]` (AlgEquiv). Ring iso is strictly weaker than k-algebra iso in general: for fields with non-trivial automorphisms (e.g., k = ℂ with complex conjugation), there exist ring isomorphisms between k-algebras that are not k-algebra isomorphisms. The statement "for any field k" includes such cases. The other components (ambient ring, ideals, the cube-containment condition `g - X₀·X₁ ∈ (X₀, X₁)³`) are faithfully encoded. Since the existence of a k-algebra iso implies the existence of a ring iso but not conversely, the Lean claim is logically weaker.

### 63

**Verdict:** `weaker`

**Reasoning**

The informal statement explicitly asks for "a surjection of R-algebras S' → S" satisfying the universal property with a square-zero kernel. The Lean formalization only requires the existence of an R-algebra map `f : S' →ₐ[R] S` with `(RingHom.ker f)^2 = 0` and the universal property, but does NOT require `f` to be surjective. This is a genuine weakening: for instance, with R = ℚ, S = ℚ(√2), taking S' = ℚ and f = inclusion satisfies ker(f)² = 0 and the universal property (since ℚ is initial among ℚ-algebras, making existence/uniqueness of the lift trivial), yet f is not surjective. So the Lean existential can be witnessed by non-surjective maps that the informal statement would not accept. Surjectivity here is not an implicit assumption — it is an explicit part of the claim (matching Stacks 00UR) and is necessary for the universal thickening to be determined up to unique isomorphism. Hence informal ⇒ Lean but Lean ⇏ informal, making the Lean statement strictly weaker.

### 81

**Verdict:** `weaker`

**Reasoning**

The Lean statement's parsing is critical. In Lean 4, `∃ x, body` is a binder that extends the body to the right as far as possible (same as `∀` and `fun`). So `∃ (rs : List R), (IsRegular R rs) ∧ Ideal.ofList rs = I ↔ Module.Free ... ∧ (∃ n, HasProjectiveDimensionLE ...)` parses as `∃ rs, ((IsRegular R rs ∧ ofList rs = I) ↔ (Free ∧ ∃ n, HasPDLE))`, NOT as the intended `(∃ rs, IsRegular R rs ∧ ofList rs = I) ↔ (Free ∧ ∃ n, HasPDLE)`. The two forms are not logically equivalent: writing P(rs) = "rs is regular and generates I" and Q = RHS, the Lean states `∃rs, (P(rs) ↔ Q)`, while the informal states `(∃rs, P(rs)) ↔ Q`. One can show informal ⟹ Lean (pick any witness — `[]` works — when both sides are false) but not the converse: if Q is false and ∃rs with P(rs), the informal biconditional fails but the Lean version can still be satisfied by any rs with ¬P(rs). So the Lean statement is strictly weaker than the informal biconditional.

### 92

**Verdict:** `weaker`

**Reasoning**

The informal statement asserts that "all possible dimension sequences are EXACTLY the sequences of the form ... for some k ∈ ℕ ∪ {+∞}", which is a set equality requiring both (1) every 1-dim ring gives such a sequence, and (2) every such k ∈ ℕ ∪ {+∞} is realized by some 1-dim ring. The Lean formalization has two conjuncts: the first correctly captures direction (1) using ∃ (k : ℕ∞), but the second conjunct uses `∀ (k : ℕ)` — only natural numbers, not ℕ∞. This omits the case k = +∞, which corresponds to the sequence a_n = 2n+1 for all n (since n ≤ ⊤ is always true in the definition of `a`). Thus the Lean statement fails to assert that this "maximal" sequence is realized, making it strictly weaker than the informal claim: any proof of the informal statement yields the Lean one, but the Lean one could be true even if no 1-dim ring achieved the k = +∞ sequence.

### 96

**Verdict:** `weaker`

**Reasoning**

The Lean adds the hypothesis `h : ∀ n : ℕ, (f.eval (RingHom.id ℚ))^[n] a ≠ 0`, which is strictly stronger than any implicit premise of the informal statement. Since Mathlib's `RatFunc.eval` returns 0 both when the numerator evaluates to 0 (genuine zero) AND when the denominator evaluates to 0 (pole), this hypothesis excludes both. The informal statement only implicitly requires that iterates don't hit poles (so that the orbit is well-defined); it does not exclude iterates being 0 as a genuine value. For example, $f(x) = x^2 + 1$ with $\alpha = 0$ satisfies the informal hypotheses (polynomial of degree 2, orbit = {0, 1, 2, 5, 26, ...} has infinitely many integers) and conclusion ($f^2$ is a polynomial), but the Lean hypothesis `h` fails at n = 0 since the 0-th iterate equals $a = 0$. The Lean thus covers strictly fewer cases than the informal statement and is logically implied by (but does not imply) the informal claim.

## stronger (5)

### 13

**Verdict:** `stronger`

**Reasoning**

In Mathlib, `IsField R` requires commutativity (it has a `mul_comm` field). In the informal statement's noncommutative context ("Let R be a not necessarily commutative ring"), the phrase "R is not a field" must mean "R is not a (skew) field / division ring"; otherwise the hypothesis is vacuous for every noncommutative ring and the statement would be false. The Lean hypothesis `¬ IsField R` is strictly weaker than "R is not a division ring": it is satisfied by any noncommutative division ring (e.g., the quaternions ℍ). With R = ℍ, the hypothesis `∀ x, ¬ IsUnit x → x^2 = x` holds vacuously (only 0 is a non-unit), yet `x^2 = x` fails (e.g., i² = -1). So the Lean statement applies to strictly more rings and is logically stronger (indeed unprovably so) than the intended informal claim.

### 15

**Verdict:** `stronger`

**Reasoning**

The informal statement explicitly requires "p, q, r be three distinct prime numbers," but the Lean formalization only assumes `hp : p.Prime`, `hq : q.Prime`, `hr : r.Prime` without any distinctness hypotheses (no `p ≠ q`, `p ≠ r`, or `q ≠ r`). Dropping this explicitly-stated hypothesis makes the Lean statement logically stronger: a proof of the Lean version would prove the informal version (by specializing to distinct primes), but the converse is not automatic since the informal proof may well use distinctness of the primes. All other components — finiteness of G, normality of H, |G/H| = r^t, the structure of both composition series, and the conclusion asking for a swapped composition series of H — match the informal statement. This is not a case of surfacing an implicit premise; it is the removal of an explicit premise.

### 23

**Verdict:** `stronger`

**Reasoning**

The Lean statement drops an implicit premise needed for truth: that f is non-constant (positive degree). In Mathlib, `Irreducible (f : Polynomial ℤ)` includes constant prime polynomials like `C 2` (since 2 is prime/irreducible in ℤ, and `C 2` has only unit factorizations in ℤ[X]). For such `f = C 2`, `rootSet_C` gives `(C 2).rootSet (ZMod p) = ∅` for every prime p, so the numerator is identically 0 and the ratio's right limit at 1 is 0, not 1. The informal statement, read with the standard algebraic-number-theory convention that "irreducible polynomial" implicitly means non-constant (a premise needed for the claim to be true and for the Chebotarev-style argument to apply), is provable, but the Lean version drops this hypothesis and claims the result for a strictly wider class (including constants), which makes it logically stronger than the informal claim. A faithful formalization would have added `0 < f.natDegree` (or equivalent) as a hypothesis.

### 55

**Verdict:** `stronger`

**Reasoning**

The informal statement asks for a one-directional implication: "if M is stably free and not finitely generated, then M is free" — i.e., `IsStablyFree R M → Module.Free R M` under `¬ Module.Finite R M`. The Lean formalization states a biconditional `Module.Free R M ↔ IsStablyFree R M` under the same hypothesis, thus requiring both directions: (a) stably free → free (the asked-for direction), and (b) free → stably free (the reverse direction, which is trivially true since any free module M can be expressed as M ⊕ 0 with the zero module serving as the auxiliary free finitely-generated module). This is the canonical "iff when only → was asked" case. Since the Lean statement logically implies the informal claim but asserts more than was requested, the correct verdict is "stronger".

### 8

**Verdict:** `stronger`

**Reasoning**

The Lean statement is a conjunction of two claims. The first conjunct (the disjunction of `Nonempty (ℍ[ℝ, A, B] ≃ₐ[ℝ] ℍ[ℝ, -1, -1]) ∨ Nonempty (ℍ[ℝ, A, B] ≃ₐ[ℝ] Matrix (Fin 2) (Fin 2) ℝ)`) correctly captures the informal claim — `ℍ[ℝ, A, B]` in Mathlib is `QuaternionAlgebra ℝ A 0 B` with the exact multiplication i² = A, j² = B, ij = k, ji = -k, and `ℍ[ℝ, -1, -1]` is definitionally the Hamilton quaternions. However, the Lean statement additionally requires `IsEmpty (Matrix (Fin 2) (Fin 2) ℝ ≃ₐ[ℝ] ℍ[ℝ, -1, -1])`, i.e., that the 2×2 real matrix algebra and the Hamilton quaternions are not isomorphic as ℝ-algebras. The informal statement does not ask for this; it merely lists two possible isomorphism types. Although this extra fact is true, it is an additional mathematical claim beyond what the informal statement asks, making the Lean statement strictly stronger.

## incomparable (1)

### 60

**Verdict:** `incomparable`

**Reasoning**

The formalization has two critical errors. First, associatedPrimes R I computes the associated primes of I viewed as an R-module (Ass_R(I)), whereas the informal statement refers to associated primes of the ideal I, which means Ass_R(R/I). In a Noetherian domain, Ass_R(I) = {(0)} for any nonzero ideal (since I is torsion-free), making the RHS degenerate. Second, ringKrullDim (R / p.1) = 1 computes the coheight of p (dimension of R/p, longest chain above p), not the height/codimension (longest chain below p). The correct encoding would use Ideal.primeHeight or height. These two independent errors make the formalized statement assert a fundamentally different claim.
