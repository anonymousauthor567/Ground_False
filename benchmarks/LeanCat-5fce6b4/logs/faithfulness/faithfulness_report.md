# Faithfulness audit of `proofnet_verified/`

For each Lean file we asked Claude to read the full file content (informal statement + Lean theorem signature) and decide whether the Lean encoding is a *strictly faithful* formalization (neither stronger nor weaker).

## Summary

| verdict | count |
|---|---|
| faithful | 83 |
| weaker | 7 |
| stronger | 7 |
| incomparable | 3 |
| unclear | 0 |
| error | 0 |
| **total** | **100** |

## faithful (83)

### S_0001

**Verdict:** `faithful`

**Reasoning**

The informal claim is that the endomorphism monoid End(Id_C) of the identity functor of any category C is commutative. In Mathlib, this monoid's elements are natural transformations 𝟭 C ⟶ 𝟭 C and the multiplication is vertical composition, denoted `≫`. The Lean statement asserts exactly that for all α, β : 𝟭 C ⟶ 𝟭 C, α ≫ β = β ≫ α, which is precisely the commutativity of that monoid. The category C is kept general via the `variable` declaration, matching "Let C be a category". This is the exact statement of Mathlib's own `CategoryTheory.NatTrans.id_comm`, so the formalization is logically equivalent to the informal claim.

### S_0002

**Verdict:** `faithful`

**Reasoning**

The informal statement says: in a category C, if f∘g is monic then g is monic. In Lean's categorical composition notation `g ≫ f` equals `f ∘ g` in standard notation (apply g first, then f). The Lean signature takes `g : X ⟶ Y`, `f : Y ⟶ Z`, hypothesizes `Mono (g ≫ f)`, and concludes `Mono g`, which matches the informal claim exactly. The quantification over an arbitrary category C is captured via the `variable {C : Type*} [Category C]` declaration, and quantification over objects and morphisms is universal. This is precisely Mathlib's `mono_of_mono` (in `CategoryTheory/Category/Basic.lean`) with variables renamed. No hypotheses are added or omitted.

### S_0003

**Verdict:** `faithful`

**Reasoning**

The Lean file encodes all four claims from the informal statement as four separate theorems, each a conjunction `Faithful ∧ ¬ Full`. (1) `forget TopCat` is the forgetful functor Top → Type, the standard encoding of Top → Set in Mathlib. (2) `forget Grp` is Grp → Type, matching Grp → Set. (3) `forget₂ RingCat Ab` matches Ring → Ab, since in Mathlib `Ab := AddCommGrp` and `HasForget₂ RingCat AddCommGrp` is defined as the expected forgetful functor. (4) `Under.forget (terminal TopCat)` is the standard categorical encoding of the forgetful functor Top_* → Top: pointed topological spaces are equivalent to `Under *` where * is the terminal object, and `Under.forget` drops the structure map. Each theorem's conclusion `Faithful ∧ ¬ Full` directly mirrors "faithful but not full". No hypotheses are added or dropped, and the mathematical content is logically equivalent.

### S_0004

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly represents the informal theorem. `Type u` is Mathlib's standard model of the category of sets (via `instance types : LargeCategory (Type u)` with `Hom a b := a → b`). `PUnit.{u}` is confirmed as a terminal object in `Type u` (via `Types.isTerminalPunit`). The functor `fromTerminalFunctor` maps `α` to `PUnit → α`, which is precisely `Hom_{Type u}(PUnit, α)`, and its action on morphisms `fun g => f ∘ g` is the standard post-composition action of the covariant Hom functor. `Functor.IsEquivalence` is Mathlib's standard notion of equivalence of categories (faithful + full + essentially surjective). So the Lean statement asserts exactly: Hom_Set({*}, -) : Set → Set is an equivalence of categories, matching the informal claim.

### S_0005

**Verdict:** `faithful`

**Reasoning**

The informal statement says: if every idempotent in C factors as an epi followed by a mono, then every idempotent splits in C. The Lean hypothesis `∀ X p, p ≫ p = p → ∃ Y e (Epi e) m (Mono m), p = e ≫ m` encodes "every idempotent endomorphism has an epi-mono factorization" exactly as stated. The conclusion `IsIdempotentComplete C` is the Mathlib class whose defining field `idempotents_split` literally asserts "for every idempotent p there exists Y, i, e with i ≫ e = 𝟙 Y and e ≫ i = p", i.e., the standard definition of all idempotents splitting. Both the hypothesis and the conclusion match the informal statement with no added or dropped premises and no shift in quantifier structure or mathematical meaning.

### S_0006

**Verdict:** `faithful`

**Reasoning**

The LHS `∃ G : D ⥤ C, Nonempty (𝟭 C ≅ F ⋙ G) ∧ Nonempty (G ⋙ F ≅ 𝟭 D)` is the standard formulation of "F has a quasi-inverse": a functor G with natural isomorphisms to the identities on both sides. The RHS `F.IsEquivalence` is defined in Mathlib (Mathlib/CategoryTheory/Equivalence.lean line 515) as the class bundling `F.Faithful`, `F.Full`, and `F.EssSurj`, which is exactly "fully faithful and essentially surjective" from the informal statement. The composition directions match Mathlib's `Equivalence.mk'` pattern (`η : 𝟭 C ≅ F ⋙ G` and `ε : G ⋙ F ≅ 𝟭 D`), and using `Nonempty` for the isos correctly encodes the existence claim. The universe polymorphism `{C D : Type*} [Category C] [Category D]` faithfully expresses "let C and D be two categories". The two sides of the iff match the informal theorem exactly.

### S_0007

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts existence and uniqueness (up to isomorphism) of a factorization F' : Kar(C) → D of F through I. The Lean formalization splits this into two companion theorems which together capture exactly this claim: (1) existence of F' with a natural isomorphism toKaroubi C ⋙ F' ≅ F, and (2) uniqueness up to isomorphism, i.e. any two such F₁, F₂ are isomorphic. The types are correct: C, D are arbitrary categories, `[IsIdempotentComplete D]` matches "D in which idempotents split", `Idempotents.Karoubi C` is the idempotent completion, and `Idempotents.toKaroubi C` is the standard inclusion functor I. The use of `≅` (natural isomorphism) rather than strict equality is the standard interpretation of "F' ∘ I = F" in the statement of a universal property, and `Nonempty` around the iso is the standard way to express "there exists an isomorphism" in Lean. Together the two theorems are logically equivalent to the informal statement.

### S_0008

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that in the category Grp, the categorical coproduct of two groups G_1, G_2 is isomorphic to their free product. The Lean statement expresses exactly this: `coprod G H` is the categorical binary coproduct in Grp (from CategoryTheory.Limits), and `Monoid.Coprod G H` is Mathlib's name for the free product of two groups/monoids. The claimed `≅` is an isomorphism between these two objects. The `HasBinaryCoproduct G H` hypothesis is required as a technical prerequisite so that `coprod G H` is even defined; since Grp has all binary coproducts in Mathlib, this hypothesis is always satisfiable and does not restrict the scope of the claim beyond the informal statement. The `Nonempty` wrapper is a standard way to state "there exists an isomorphism" which matches the informal phrasing "is equivalent to." No hypotheses are added or dropped that would change the mathematical content.

### S_0009

**Verdict:** `faithful`

**Reasoning**

The informal statement claims there exists a morphism in the category of rings that is epic but not surjective. The Lean theorem uses `RingCat` (Mathlib's category of rings, defined in `Mathlib/Algebra/Category/Ring/Basic.lean`), `Epi f` (the standard categorical notion of epimorphism), and `Function.Surjective f` which, via the `ConcreteCategory`/`HasForget.instFunLike` coercion on `RingCat`, means the underlying function `A → B` is surjective. The existential `∃ (A B : RingCat) (f : A ⟶ B), Epi f ∧ ¬ Function.Surjective f` precisely expresses the existence of such a morphism. There are no missing or added hypotheses, and the logical structure (existence of A, B, f with the conjunction of being epic and not being surjective) matches the informal claim exactly.

### S_0010

**Verdict:** `faithful`

**Reasoning**

The informal statement describes a covariant functor F : Grp → Set sending G to the set of involutions {g ∈ G | g² = 1}, and asserts F is representable. The Lean definition `functor_involution` correctly encodes this: on objects, it returns {g : G.carrier | g * g = 1}, and on morphisms it applies the group homomorphism pointwise (with the correct proof that f(g)·f(g) = f(g·g) = f(1) = 1). For representability, Mathlib uses `IsRepresentable` for contravariant functors (Cᵒᵖ ⥤ Type) and `IsCorepresentable` for covariant functors (C ⥤ Type), both meaning F ≅ Hom(X, -) for some object X. Since the functor here is covariant, `IsCorepresentable` is the correct and standard Mathlib notion matching the informal word "representable" (this is the same convention used, e.g., in `Mathlib/Algebra/Category/Grp/ForgetCorepresentable.lean`). The formalization is therefore strictly faithful.

### S_0011

**Verdict:** `faithful`

**Reasoning**

The Lean formalization carefully encodes all the AHS definitions. `ConcreteCat` requires a faithful functor `U : C ⥤ X`, matching "concrete category over B". `IsInitialHom` correctly encodes "g is a C-morphism whenever f∘g is a C-morphism" as "(∃ h, U(h) = g ≫ U(f)) → (∃ k, U(k) = g)", with the composition convention g ≫ U(f) correctly corresponding to U(f) ∘ g in math notation. `IsEmbedding` is initial plus U(f) monic in the base category. `IsInjectiveObj` correctly has `m ≫ g = f` which is `g ∘ m = f`. `HasEnoughInj` states every object has an embedding into an injective, matching "initial subobject of an injective". `CompHausConcrete` uses `forget CompHaus : CompHaus ⥤ Type u`, which is automatically faithful via Mathlib's `HasForget` for CompHaus, correctly instantiating compact Hausdorff spaces as a concrete category over Set. The theorem asserts exactly what the informal statement claims.

### S_0012

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal iff statement. The key correspondences are: (1) "f is a monomorphism" ↔ `Mono f`; (2) "faithful functor I" ↔ `Faithful I` (Mathlib's definition is exactly: injective on morphisms); (3) "f is a section in D" ↔ `IsSplitMono (I.map f)`. In category theory, a morphism is called a "section" precisely when it has a left inverse (a retraction), which is exactly Mathlib's `SplitMono` / `IsSplitMono`: `f ≫ retraction = 𝟙 X`. The universe choice `D : Type (max u v)` with `Category.{v} D` is a standard Mathlib convention for existential statements over categories — large enough to admit the classical construction (e.g., a Yoneda-style embedding or retraction completion) that witnesses the forward direction, while the reverse direction (split mono reflected under faithful functor yields mono) holds for any D. The pinning of the morphism universe to v matches C's, which is the natural choice. No hypotheses are silently added or dropped, and the quantifier structure matches.

### S_0013

**Verdict:** `faithful`

**Reasoning**

The Lean statement `Nonempty (CompHaus.{u} ≌ (CommCStarAlgCat.{u})ᵒᵖ)` correctly encodes the classical Gelfand duality theorem. `CompHaus` is Mathlib's category of compact Hausdorff spaces, `CommCStarAlgCat` (defined in this file) is the category of commutative unital C*-algebras over ℂ with morphisms as unital *-algebra homomorphisms (`A →⋆ₐ[ℂ] B`), and `CompHaus ≌ CommCStarAlgCatᵒᵖ` is the standard Lean encoding of "dual equivalence." The `Nonempty` wrapping correctly captures "is equivalent to" as existence of an equivalence. While the informal says "algebra homomorphisms" and Lean uses *-algebra homomorphisms, this is the universally standard morphism choice for the C*-algebra category in Gelfand duality (as seen in Murphy, Conway, Takesaki, and in Mathlib's own GelfandDuality.lean development), so this matches the intended mathematical content.

### S_0014

**Verdict:** `faithful`

**Reasoning**

The Lean formalization precisely captures the informal content. `IsInitialHom` encodes "g lifts whenever f∘g lifts" correctly (the non-trivial direction of the informal definition; the other direction is automatic). `IsEmbedding` is the conjunction of initiality and monic U-image, matching "initial morphism with U(f) monic". `IsInjectiveObj` quantifies over all embeddings m and all f : A → I, demanding an extension g : B → I with m ≫ g = f, exactly matching the informal definition. `PosetConcrete` is correctly constructed using `PartOrd` (Mathlib's category of posets with order-preserving maps) with the standard forgetful functor to `Type u` (the base "Set"). The conclusion `∀ (s : Set P), ∃ x, IsLUB s x` is precisely the definition of a sup-lattice (= complete lattice, since all sups implies all infs). This is the classical theorem characterizing injective objects in PoSet as complete lattices, faithfully formalized.

### S_0016

**Verdict:** `faithful`

**Reasoning**

The Lean file defines `IsInitialHom`, `IsEmbedding`, and `IsInjectiveObj` exactly along the lines of the AHS definitions: initial says that if $U(f) \circ g$ lifts through $U$ then so does $g$; embedding adds $\mathrm{Mono}(U(f))$; injective object $I$ says every map from the domain of an embedding extends along it. The concrete category `AddCommGrpConcrete` is `AddCommGrp.{u}` with forgetful functor to `Type u`, which is the categorical setup of $\mathcal{A}b$ over $\mathbf{Set}$. The right-hand side of the iff, $\forall n \neq 0, \forall a, \exists b, n \bullet b = a$ with $n : \mathbb{N}$, is the standard divisibility condition for an abelian group (equivalent to the integer version by group inversion and triviality of $n=0$). The informal statement contains a harmless typo ($f: A \to C$ rather than $f: A \to I$), which the Lean reading correctly resolves. No hypotheses are silently added or dropped, and the quantifier structure matches. Hence the formalization is logically equivalent to the intended informal claim.

### S_0017

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. (1) `ConcreteCat` with a faithful functor matches AHS-style concrete categories. (2) `IsInitialHom` correctly encodes: "g lifts (is `U k` for some `k`) whenever f∘g lifts (is `U h` for some `h`)". (3) `IsEmbedding` = initial + Mono on U(f). (4) `IsInjectiveObj` matches "for any embedding m, any f: A→I extends along m". (5) `S` uses `generateFrom {({0,1} : Set (Fin 3))}`, which generates exactly the open sets {∅, {0,1}, {0,1,2}} as specified; the `letI` is a local instance that takes precedence in instance search, and `ULift` only wraps without changing topological structure. (6) `piObj (fun _ : I => S)` is the categorical product in TopCat (= Tychonoff power $C^I$), and `Nonempty (Retract Y _)` captures "Y is a retract of". The ∃ over `Type u` is a standard universe-polymorphic encoding of "some index set". The iff correctly matches "are precisely".

### S_0018

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly encodes all three definitions (initial morphism, embedding, injective object) from the informal statement. `IsInitialHom` uses existentials over lifts through the faithful functor U, which (since U is faithful) exactly captures "g is a morphism in C" and "f ∘ g is a morphism in C". `IsEmbedding` correctly combines being initial with U(f) being monic. `IsInjectiveObj` correctly encodes the extension property (noting that `m ≫ g = f` in Mathlib's convention matches `g ∘ m = f` in standard notation). The target category `CompHausConcrete` is the concrete category (CompHaus, forget CompHaus), which is faithful. The theorem statement `IsInjectiveObj Y ↔ ∃ ι : Type u, Nonempty (Retract Y (CompHaus.of (∀ i : ι, unitInterval)))` properly expresses "Y is a retract of some power [0,1]^I" using Mathlib's `Retract` structure and the natural universe level for the index type. Typo in the informal ("f: A → C" instead of "f: A → I") is resolved correctly per standard definition.

### S_0019

**Verdict:** `faithful`

**Reasoning**

The Lean statement is logically equivalent to the informal one. "$G$ has a left adjoint" is exactly `G.IsRightAdjoint` in Mathlib (defined as `∃ left, Nonempty (left ⊣ G)`). The comma category $(c \downarrow G)$, whose objects are morphisms $c \to G(Y)$, is precisely `StructuredArrow c G` in Mathlib. The universal quantifier "for each $c \in \mathcal{C}$" matches `∀ c : C`, and "has an initial object" matches `HasInitial`. In fact, this is essentially `Mathlib.CategoryTheory.Adjunction.Comma.isRightAdjoint_iff_hasInitial_structuredArrow` verbatim. The formalization is faithful.

### S_0020

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal one. `adj : F ⊣ G` captures "F has right adjoint G". `F.Full ∧ F.Faithful` (Mathlib's propositional typeclasses for the map on hom-sets being surjective and injective) is equivalent to "F is fully faithful". `adj.unit` in Mathlib is the natural transformation `𝟭 C ⟶ F ⋙ G`, which in standard math notation is Id_C → G∘F (Lean's `F ⋙ G` reads as "F then G" = mathematical G∘F), matching the informal u. `IsIso adj.unit` means the unit is an isomorphism of natural transformations. The biconditional matches the informal iff exactly, and indeed Mathlib proves both directions in `CategoryTheory/Adjunction/FullyFaithful.lean`.

### S_0021

**Verdict:** `faithful`

**Reasoning**

The Lean statement precisely matches the informal claim. `F ⊣ G` encodes "F admits right adjoint G". `G.IsEquivalence` is the Mathlib formalization of "G is an equivalence of categories". `F.Full ∧ F.Faithful` is exactly "F is fully faithful" (equivalent to `F.FullyFaithful`). Crucially, `G.ReflectsIsomorphisms` is the standard Mathlib formalization of "G is conservative" — a conservative functor is by definition one that reflects isomorphisms (Mathlib has no separate `Conservative` class in category theory; this IS it, as shown in `CategoryTheory/Functor/ReflectsIso/Basic.lean`). The iff-structure, hypotheses, and conclusion all match the informal statement.

### S_0022

**Verdict:** `faithful`

**Reasoning**

The Lean statement matches the informal one precisely. `F.IsLeftAdjoint` in Mathlib is defined as "there exists a right adjoint" (∃ right : D ⥤ C, Nonempty (F ⊣ right)), which is exactly "F admits a right adjoint". The functor `F.op ⋙ yoneda.obj d : Cᵒᵖ ⥤ Type v` computes, at X : Cᵒᵖ, to `F.obj X.unop ⟶ d`, which is exactly $\hom_{\mathcal{D}}(F(-), d)$. `IsRepresentable` on a `Cᵒᵖ ⥤ Type v` functor is the standard notion of representability (∃ Y, Nonempty (yoneda.obj Y ≅ F)). The universal quantification over `d : D` matches "for each d ∈ D". The locally small hypothesis is encoded by the `Category.{v}` instances with a common morphism universe (required for type-checking of yoneda and IsRepresentable). The iff structure and all quantifier placements match exactly.

### S_0024

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that the forgetful functor from abelian groups to groups admits a left adjoint. The Lean statement `(forget₂ CommGrp.{u} Grp.{u}).IsRightAdjoint` asserts exactly this: `IsRightAdjoint` is defined in Mathlib (CategoryTheory/Adjunction/Basic.lean line 121) as "A class asserting the existence of a left adjoint", which matches "admits a left adjoint" precisely. Although Mathlib uses `Ab := AddCommGrp` (additive convention) while the Lean statement uses the multiplicative `CommGrp`, these categories are equivalent — the mathematical claim about the forgetful functor from abelian groups to groups is the same regardless of additive vs. multiplicative notation. Mathlib explicitly uses `forget₂ CommGrp Grp` for this forgetful functor (with `abelianize` as its known left adjoint via `abelianizeAdj`). No hypotheses are added or dropped, and the conclusion is logically equivalent to the informal claim.

### S_0026

**Verdict:** `faithful`

**Reasoning**

The Lean statement quantifies (via variables) over categories C, D and functors F : C ⥤ D, G : D ⥤ C, H : C ⥤ D, assumes the two adjunctions F ⊣ G and G ⊣ H (i.e., an adjoint triple F ⊣ G ⊣ H), and concludes (F.Full ∧ F.Faithful) ↔ (H.Full ∧ H.Faithful). In Mathlib, `Functor.Full` (F.map surjective on homs) together with `Functor.Faithful` (F.map injective on homs) is the standard propositional encoding of "fully faithful". So the conclusion is exactly "F is fully faithful iff H is fully faithful". The configuration of domains/codomains matches the adjoint triple, and this is a well-known theorem (also present in Mathlib's Adjunction/Triple.lean as `fullyFaithfulEquiv`). No hypotheses are silently added or removed. The formalization is strictly faithful.

### S_0027

**Verdict:** `faithful`

**Reasoning**

The informal statement says: for f an endofunctor of ℤ (viewed as the poset category), f has a left adjoint iff f has a right adjoint. In Mathlib, `ℤ ⥤ ℤ` with the default `Preorder.smallCategory` instance is exactly the poset category of ℤ, matching "ℤ regarded as a category". Mathlib defines `Functor.IsLeftAdjoint f` as "∃ g, f ⊣ g" (f has a right adjoint) and `Functor.IsRightAdjoint f` as "∃ g, g ⊣ f" (f has a left adjoint). So "f has a left adjoint ↔ f has a right adjoint" corresponds precisely to `f.IsRightAdjoint ↔ f.IsLeftAdjoint`, which is exactly what the Lean statement asserts. Furthermore, because the claim is a biconditional, the order of the two sides is immaterial. The formalization is logically equivalent to the informal statement.

### S_0028

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures each piece of the informal statement: (1) ℕ as a category uses the automatic `Preorder.smallCategory` instance, so `ℕ ⥤ ℕ` is functors of the poset category; (2) `Function.Injective G` correctly encodes "distinct functors" (pairwise distinct across the sequence); (3) `(G 0).obj x = x + 1` matches G_0(x) = x+1 using the functor's object map; (4) `Nonempty (G (n + 1) ⊣ G n)` matches "G_{n+1} ⊣ G_n" — since `Adjunction` is a structure (data), `Nonempty` is the standard way to assert its existence as a proposition, and moreover in a thin/poset category adjunctions are unique when they exist, so this is semantically equivalent to "there is an adjunction". The direction of the adjunction matches the informal claim. No hypotheses are added or dropped, and the quantifier structure (over n ∈ ℕ) is preserved.

### S_0029

**Verdict:** `faithful`

**Reasoning**

The Lean formalization introduces `RingCat.units : RingCat ⥤ Grp` sending R to Rˣ (the group of units) and acting on morphisms by `Units.map`—this is exactly the units functor $(-)^\times$ from the informal statement, mirroring Mathlib's existing `MonCat.units`. The theorem `∃ (left : Grp ⥤ RingCat), Nonempty (left ⊣ RingCat.units)` is the standard Prop-level formalization of "admits a left adjoint" — it is literally the body of Mathlib's `Functor.IsRightAdjoint` definition (`class IsRightAdjoint (right : D ⥤ C) : Prop where exists_leftAdjoint : ∃ (left : C ⥤ D), Nonempty (left ⊣ right)`). The functor source/target, the object/morphism mapping, and the adjunction existence quantifier all match the informal claim with no extra or missing hypotheses.

### S_0030

**Verdict:** `faithful`

**Reasoning**

The Lean formalization carefully captures the informal statement. The custom `Reflective2` class is defined as `extends R.Faithful` with a left adjoint — deliberately omitting the `R.Full` requirement that Mathlib's built-in `Reflective` has, which exactly matches the note "we do not require a reflective subcategory to be full." The "subcategory" relation is encoded as a faithful functor (`Faithful i`, `Faithful j`), which is the standard categorical encoding of a not-necessarily-full subcategory. The adjunction direction is correct: since `Reflective2 (R : D ⥤ C)` requires `L ⊣ R`, applying it to `i : C ⥤ D` gives a left adjoint to the inclusion `i`, which is the correct notion of "C reflective in D". The `IsEmpty`/`Nonempty` pair correctly expresses "not reflective in D" and "reflective in E" respectively. The existential quantification over categories, functors, and faithfulness witnesses matches the "there exist" claim in the informal statement.

### S_0032

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully formalizes "Set has precisely three full, isomorphism-closed, reflective subcategories." Encoding subcategories as predicates `Type u → Prop` via `ObjectProperty.ι P` automatically makes them full (since `ObjectProperty.ι` is fully faithful by construction in Mathlib). `IsIsoClosed` captures closure under categorical isomorphism in the category `Type u` (which is the standard Set category). `IsReflectiveSubcategory P := Nonempty (Reflective (ObjectProperty.ι P))` correctly asserts existence of a left adjoint to the inclusion, since Mathlib's `Reflective` class requires fully faithful + left adjoint and the inclusion is automatically fully faithful. The "precisely three" is encoded correctly: three witnesses that are pairwise non-equivalent (distinctness) plus universality (every iso-closed reflective Q equals one of them). `SubcategoryEquiv` via pointwise ↔ is the correct notion of two full subcategories having the same object class. No hypotheses are added or dropped beyond the informal claim.

### S_0034

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly encodes all three ingredients: (1) `IsFreeObject U d I` expresses the universal-arrow property (∃ η : I → U(d), ∀ y f, ∃! g, U.map g ∘ η = f), matching the informal definition of free object over I with the composition $U(\underline{f}) \circ u = f$ (the informal text writes "$\underline{f}\circ u$" as implicit abuse since $u$ lives in Set). (2) `IsCopower x d I` with `Cofan.mk d ι` forces the indexing family to be constantly `x`, so this is exactly the I-th copower of x (colimit of the constant discrete diagram). (3) `hU : U ≅ coyoneda.obj (op x)` is the representability hypothesis (coyoneda gives Hom(x, -)). The added `[Faithful U]` surfaces an implicit premise: "construct" in the AHS sense means a concrete category over Set, whose definition requires the forgetful functor to be faithful. Making this explicit is not a weakening but a faithful reading of "construct."

### S_0035

**Verdict:** `faithful`

**Reasoning**

The Lean `Construct` structure correctly encodes "construct" = concrete category over Set (category C with faithful functor U : C ⥤ Type). The `IsRealization` predicate captures "full concrete embedding": `F ⋙ T.U = S.U` is the concreteness condition (V∘F = U with strict equality, standard for concrete functors); `Functor.Full F` is fullness; `Function.Injective F.obj` is injective-on-objects. Faithfulness of F is automatic since `S.U` is faithful and F is concrete, so the three stated conditions correctly characterize a full concrete embedding (= realization). The theorem's quantifier structure `∃ T, ∀ S, ∃ F, IsRealization S T F` directly mirrors "there is a construct (C,U) such that every construct has a realization to (C,U)". Universe levels are consistently parameterized, which is the standard way to formalize such universally quantified categorical statements.

### S_0036

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures exactly 'there exist categories not concretizable over Set'. The outer `∃ C, Category C` expresses 'a category exists'; the inner `¬ ∃ F : C ⥤ Type v, F.Faithful` expresses 'not concretizable over Set'. In Mathlib, `Functor.Faithful` is defined as injectivity of the morphism map, matching the standard mathematical notion of faithful functor. The target `Type v` is Mathlib's standard representation of Set at the morphism-universe of C, consistent with Mathlib's own `HasForget`/`ConcreteCategory` which define a concrete category as one equipped with a faithful functor `C ⥤ Type w`. The universe polymorphism (free `u`, `v`) is the natural Lean rendering of a universe-agnostic informal claim, and matches the definition literally: category + no faithful functor to Set.

### S_0038

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures each component of the informal statement: (1) `IsConcretizable (Type u) C` expands to `∃ (U : C ⥤ Type u), U.Faithful`, matching "C has a faithful functor to Set"; (2) `RegularWellPowered C` requires that for each X : C, the subtype `{P : Subobject X // Nonempty (RegularMono P.arrow)}` is Small, correctly capturing "the collection of regular subobjects is a set" — RegularMono is preserved under pre-composition with isomorphisms so the filter is well-defined on equivalence classes; (3) the `HasFiniteLimits C` hypothesis is included via the `variable` declaration; (4) `U.Faithful`, `Subobject`, and `RegularMono` all match standard Mathlib definitions. The free universe `v` in `Small.{v}` is a standard Mathlib convention (cf. `WellPowered.{w}`) for parameterizing smallness universes and does not misrepresent the informal mathematical content — the biconditional structure and logical content match the classical Freyd-style theorem being stated.

### S_0039

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts the existence of a unique concrete functor T: Top_0^op → Frm over Set. The Lean formalization defines ConcreteCat as a category with a faithful forgetful functor, defines IsConcreteFunc via the standard condition F ⋙ U_B ≅ U_A, defines the relevant concrete categories (T0TopCat^op with the opens functor L, and Frm with the forgetful functor), and states Nat.card (ConcreteFuncsIso T0TopCatopConcrete FrmConcrete) = 1. This correctly encodes "there exists a unique concrete functor" as the cardinality of the type of such functors being exactly 1. The helper definitions (T0TopCat, forgetFrm, L) correctly model the mathematical objects involved.

### S_0040

**Verdict:** `faithful`

**Reasoning**

The Lean file carefully encodes all the relevant definitions: (1) `ConcreteCat` is a category with a faithful functor U to X (matching "concrete category over 𝓑"); (2) `IsUniversalArrowOver` states that for every structured arrow v, there exists a unique g with `u.hom ≫ U.map g = v.hom`, i.e., U(g) ∘ u = v — exactly the universal property for a universal arrow from x to U; (3) `IsFreeObjectOver x z` says there exists a universal arrow whose codomain is z, matching the informal definition; (4) `HasFreeObject` quantifies over all x, matching "for each x ∈ 𝓑 there is a free object over x". The category of suplattices is modeled via `CompleteSemilatticeSup` (posets with all sups, which captures $\mathcal{L}\mathrm{at}_{\lor}^{\infty}$), with morphisms preserving arbitrary sSup, and a faithful forgetful functor to Type u. The theorem `HasFreeObject SupLatCatConcrete` asserts exactly that the category of suplattices has free objects, as required.

### S_0041

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully captures the informal statement. The category `CompleteLat` in Mathlib is the category of complete lattices with morphisms `CompleteLatticeHom` that preserve arbitrary suprema (sSup) and arbitrary infima (sInf) — this precisely matches the informal "non-full subcategory of suplattices with meet- and join-preserving maps" (where in the context of complete lattices, "meet/join-preserving" naturally means preserving arbitrary meets/joins). The `FreeObject` structure correctly encodes the universal arrow definition: `emb` is the map u: x → U(c), and `uniq` encodes "for each f: x → U(b), there exists a unique f': c → b with U(f') ∘ u = f" using `∃!` and the composition `emb ≫ (forget C).map g = f`, which in the Type category means U(g) ∘ emb = f. `Nonempty (FreeObject ...) ↔ Cardinal.mk X ≤ 2` matches "free object exists iff |X| ≤ 2" — this is the classical Whitman-Hales-Gaifman result that free complete lattices exist on ≤ 2 generators but not on ≥ 3 generators. The universe levels align correctly: `CompleteLat.{u}` has HasForget.{u}, so X: Type u matches FreeObject's requirement.

### S_0042

**Verdict:** `faithful`

**Reasoning**

The Lean signature has `(F : C ⥤ D) [Full F] [Faithful F]` which encodes "fully faithful functor between categories C and D", matching the informal hypothesis. The conclusion `ReflectsLimits F ∧ ReflectsColimits F` uses Mathlib's standard abbreviations, where `ReflectsLimits F := ReflectsLimitsOfSize.{v₂, v₂} F`. The Mathlib definitions of `ReflectsLimits`/`ReflectsColimits` explicitly do not require D to already have the limits/colimits — they state that if F maps a cone/cocone to a limit/colimit in D, then it was already one in C. This precisely matches "reflects any limits and colimits admitted in the codomain". Mathlib even has direct instances `fullyFaithful_reflectsLimits` and `fullyFaithful_reflectsColimits` proving exactly this theorem. The encoding is the standard, faithful formalization.

### S_0043

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly encodes both claims about the category of sets (formalized as `Type u`). `PUnit : Type u` is the canonical one-point type, and `ULift.{u} Bool` is a two-point type in universe u (the ULift is merely a universe-lift of the 2-element type `Bool`; it still has exactly 2 elements). Checking Mathlib's definitions in `CategoryTheory/Generator/Basic.lean`: `IsSeparator G` is defined as `IsSeparating {G}` and `IsCoseparator G` as `IsCoseparating {G}`, so the singleton-set version and the single-object version are definitionally the same. Thus "the two-point set forms a coseparating set" (i.e., the singleton family `{ULift Bool}` is coseparating) is exactly `IsCoseparator (ULift Bool)`. The universe-polymorphic encoding `Type u` is the standard Lean formalization of "Set". Both statements capture the intended mathematical content without weakening or strengthening.

### S_0044

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures exactly the canonical Mathlib formulation of "filtered colimits commute with finite limits in Set". The hypotheses match precisely: `FinCategory J` encodes "finite" (the shape of limits), `IsFiltered K` encodes "filtered" (the shape of colimits), and `F : J ⥤ K ⥤ Type u` encodes "in Set". The conclusion `colimit (limit F) ≅ limit (colimit F.flip)` is literally the form of Mathlib's `colimitLimitIso`, which the Mathlib library itself documents as "A curried version of the fact that filtered colimits commute with finite limits." The `Nonempty` wrapping simply turns the data-carrying isomorphism into a proposition asserting such an iso exists, which is the standard propositional reading of "these two objects are isomorphic." Using `SmallCategory` and a common universe `u` is the standard way to make everything size-compatible so that the relevant (co)limits exist in `Type u` — this is an implicit premise any mathematician would assume when formalizing the statement in Set.

### S_0045

**Verdict:** `faithful`

**Reasoning**

The Lean encoding mirrors the informal statement directly. The category `ℕᵒᵖ` matches the ordinal $\omega^{op}$ (since $\omega$ is the poset of naturals viewed as a category), `RingCat` matches $\mathcal{R}\text{ing}$, and `RingCat.of (ZMod (p ^ (unop n)))` is $\mathbb{Z}/p^n\mathbb{Z}$. For a morphism `m ⟶ n` in `ℕᵒᵖ`, `leOfHom f.unop` yields `n ≤ m`, so `pow_dvd_pow p` gives `p^n ∣ p^m` and `ZMod.castHom` produces the canonical reduction $\mathbb{Z}/p^m\mathbb{Z} \to \mathbb{Z}/p^n\mathbb{Z}$, which exactly realizes the transition maps $f_n : F_{n+1} \to F_n$ and their compositions. The conclusion `HasLimit (pAdicFunctor p)` is precisely the claim "the limit exists". Neither side assumes $p$ is prime, and the claim is true for any `p : ℕ` since `RingCat` has all small limits.

### S_0046

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes the classical theorem that Nat(F,G) is the end of the hom bifunctor. The `homIntegrandBifunctor` is built as `(Functor.prod F.op G) ⋙ Functor.hom D : Cᵒᵖ × C ⥤ Type u`, which sends (c_op, c') ↦ hom_D(F(c), G(c')), matching the intended bifunctor. Currying it gives `Cᵒᵖ ⥤ C ⥤ Type u`, which is the proper input shape for Mathlib's `end_`. The end of this functor is precisely ∫_c hom_D(F(c), G(c)) since the multiequalizer condition unfolds to the naturality squares. The `Nonempty (... ≅ ...)` wrapper asserts the existence of an isomorphism in Type u, which is a bijection — this matches the informal "≅". The SmallCategory hypotheses are the standard Mathlib encoding of "small category", and HasEnd is automatically inferred since Type u has all small limits. No hypotheses are added or dropped relative to the informal statement.

### S_0047

**Verdict:** `faithful`

**Reasoning**

The Lean statement negates the existence of a `CategoryTheory.Equivalence` between `Type u` and `(Type u)ᵒᵖ`. In Mathlib, the category of sets (Set) at universe u is standardly formalized as `Type u` with its `LargeCategory` instance (confirmed in Mathlib/CategoryTheory/Types.lean: `instance types : LargeCategory (Type u)`), and `(Type u)ᵒᵖ` is its opposite category (confirmed in Opposites.lean: `instance Category.opposite : Category.{v₁} Cᵒᵖ`). `CategoryTheory.Equivalence C D` is exactly the bundled notion of equivalence of categories. `¬ Nonempty (Equivalence ...)` precisely captures 'there is no equivalence of categories between Set and Set^op'. The universe polymorphism `u` matches the standard reading of 'Set'. No hypotheses are added or dropped.

### S_0048

**Verdict:** `faithful`

**Reasoning**

The informal statement says "a reflective subcategory C of a cocomplete category D is also cocomplete." The Lean theorem takes a functor i : C ⥤ D with `[Reflective i]`, which in Mathlib means i is fully faithful with a left adjoint — this is exactly the standard category-theoretic notion of a reflective subcategory inclusion. `HasColimits D` is the standard Mathlib abbreviation for "D is cocomplete" (i.e., `HasColimitsOfSize.{v,v} D` for a category with hom-sets in universe v), and likewise `HasColimits C` correctly encodes "C is cocomplete." The universe setup (both C and D in Type u with hom-sets in Type v) is the natural ambient setting. This matches Mathlib's own `hasColimits_of_reflective` in `CategoryTheory/Monad/Limits.lean` (specialized from `HasColimitsOfSize.{v,u}` to `HasColimits`). Hypotheses and conclusion correspond exactly to the informal statement.

### S_0049

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal statement. `PUnit` has a `Category` instance in Mathlib (via the chain `LinearOrder PUnit → Preorder PUnit → Preorder.smallCategory`), which makes it a category with one object (`PUnit.unit`) and one morphism (the identity) — precisely the terminal category described informally. The hypotheses `[HasColimit F]` and `[K.HasLeftKanExtension F]` surface implicit premises needed for `colimit F` and `K.leftKanExtension F` to be well-defined; the informal statement implicitly assumes both quantities exist for the equation `Lan_K F(•) = colim F` to make sense. The conclusion `Nonempty ((K.leftKanExtension F).obj PUnit.unit ≅ colimit F)` is the idiomatic encoding of the equation between objects in category E (equality of categorical objects is canonically interpreted up to isomorphism). The universal quantification over K matches the informal statement's generality (and is essentially trivial since the terminal category has a unique functor into it). No hypotheses are silently added or dropped that change the mathematical content.

### S_0050

**Verdict:** `faithful`

**Reasoning**

The Lean statement accurately captures the informal claim. `coyoneda.obj (Opposite.op X)` is precisely the hom-functor `Y ↦ (X ⟶ Y)`, i.e., `Hom_{Set}(X, -)` when `X : Type u`. `PreservesFilteredColimits` is Mathlib's standard notion of preserving filtered colimits (specifically `PreservesFilteredColimitsOfSize.{u,u}` for the `Type u ⥤ Type u` functor), matching the informal definition of "compact". `Finite X` is the standard proposition stating X is a finite set. The biconditional thus asserts exactly: an object X in Set is compact iff it is finite. Universes are handled consistently (X : Type u, with the hom-functor landing in Type u), so no silent strengthening or weakening occurs.

### S_0051

**Verdict:** `faithful`

**Reasoning**

The Lean statement is logically equivalent to the informal theorem under Mathlib's standard definitions. `HasLimitsOfSize.{v, v} C` unfolds to `HasLimits C` ("all small limits" relative to the category's hom-set universe v). `∀ (J : Type v), HasLimitsOfShape (Discrete J) C` is exactly the unfolded definition of `HasProducts.{v} C` in Mathlib. `HasLimitsOfShape WalkingCospan C` is exactly the unfolded definition of `HasPullbacks C`. Thus the Lean statement is `HasLimits C ↔ HasProducts.{v} C ∧ HasPullbacks C`, matching "C admits all small limits iff C admits all small products and pullbacks" faithfully in both hypotheses, conclusion, and universe conventions.

### S_0052

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures exactly the informal claim. `Function.Pullback f g` is defined in Mathlib as `{p : X × Y // f p.1 = g p.2}`, which is literally the set `{(x,y) ∈ X × Y | f(x) = g(y)}` from the informal statement. The projections `Function.Pullback.fst` and `.snd` are the obvious first/second component maps into X and Y respectively. `IsPullback (C := Type u) fst snd f g` asserts that this square (with legs fst, snd and cospan f, g) is a pullback in the category Type u, which is exactly the informal claim that the given set is the pullback X ×_Z Y. The universe restriction to a single Type u is standard and does not introduce a meaningful weakness. No hypotheses or conclusions are added or dropped.

### S_0053

**Verdict:** `faithful`

**Reasoning**

The Lean formalization matches the informal statement of the General Adjoint Functor Theorem precisely. The hypotheses `[HasLimits D]` (small-complete) and `[LocallySmall.{v} D]` (locally small) match "Let D be a small-complete locally small category". The iff is correctly stated: `G.IsRightAdjoint` means "G has a left adjoint" (per Mathlib's `class IsRightAdjoint` asserting the existence of a left adjoint); `PreservesLimits G` means "G is continuous" (preserves all small limits at level v); and `∀ (c : C), HasInitial (StructuredArrow c G)` correctly encodes "for each c ∈ C, the comma category (c↓G) has an initial object" since in Mathlib `StructuredArrow c G` IS exactly the comma category (c↓G). The quantifier structure, conclusion, and hypotheses all align with the informal claim.

### S_0054

**Verdict:** `faithful`

**Reasoning**

The Lean statement exactly captures Freyd's Initial Object Theorem. `HasLimits B` is Mathlib's notion of completeness (`HasLimitsOfSize.{v,v} B`, i.e., having all small limits relative to the hom universe). `HasInitial B` is the existence of an initial object. The weakly initial set condition `∃ (I : Type v) (x : I → B), ∀ (s : B), ∃ (i : I), Nonempty (x i ⟶ s)` precisely matches Mathlib's standard formalization in `CategoryTheory/Limits/Constructions/WeaklyInitial.lean` (compare `∀ A : C, ∃ i, Nonempty (B i ⟶ A)` with `{ι : Type v}`). Using `Type v` for the indexing type is the natural rendering of "small" in a category with hom-universe `v`, matching the universe convention throughout Mathlib's category theory. The iff statement corresponds to the standard equivalence: forward direction is trivial (use the initial object as a singleton weakly initial set), and backward follows from combining `has_weakly_initial_of_weakly_initial_set_and_hasProducts` with `hasInitial_of_weakly_initial_and_hasWideEqualizers`. Hypothesis, conclusion, and quantifier structure all align.

### S_0056

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the classical theorem that $G : D \to C$ has a left adjoint iff $R = \mathrm{Ran}_G \mathrm{Id}_D$ exists and is preserved by $G$. (1) `G.IsRightAdjoint` is Mathlib's "G has a left adjoint" (line 121 of Adjunction/Basic.lean). (2) The existence `∃ R α, R.IsRightKanExtension α` with `α : G ⋙ R ⟶ 𝟭 D` correctly encodes existence of the right Kan extension $R : C \to D$ of $\mathrm{Id}_D$ along $G$. (3) `(R ⋙ G).IsRightKanExtension β`, where β is the whiskered $\alpha$ composed with the associator/unitor, says that $(R \circ G)$ with the induced natural transformation is a right Kan extension of $G$ along $G$ — this is the standard definition of "G preserves the Kan extension" (equivalent to the comparison map $G \circ R \to \mathrm{Ran}_G G$ being iso). The types, direction of natural transformations, and quantifier structure all match the informal statement.

### S_0057

**Verdict:** `faithful`

**Reasoning**

The Lean file provides two separate theorems matching the two alternatives in "A functor that reflects equalizers (or finite products) reflects isomorphisms". (1) `ReflectsLimitsOfShape WalkingParallelPair F` is exactly "F reflects equalizers" since `WalkingParallelPair` is Mathlib's indexing category for equalizer diagrams — this is a direct faithful formalization. (2) `ReflectsLimitsOfShape (Discrete PEmpty) F` together with `ReflectsLimitsOfShape (Discrete WalkingPair) F` encodes "reflects terminal objects and binary products", which is the standard categorical reading of "reflects finite products" (terminal + binary are the generators; in classical texts like Borceux/Mac Lane, "finite products" refers to this structure). The conclusion `F.ReflectsIsomorphisms` matches Mathlib's standard `Functor.ReflectsIsomorphisms` class. Both theorems accurately capture the two branches of the informal claim under standard categorical convention.

### S_0058

**Verdict:** `faithful`

**Reasoning**

The Lean signature correctly formalizes both sides of the iff. `CompactSpace X` is Mathlib's standard compact topological space predicate. `Op X := TopologicalSpace.Opens X` is the poset of open subsets, which automatically gets a `SmallCategory` instance via `Preorder` (from `CategoryTheory/Category/Preorder.lean`), with morphisms `U ⟶ V` corresponding to inclusion `U ≤ V` — this matches "the category Op(X) of open subsets". `(⊤ : Op X)` is the whole space viewed as an open set (`coe_top : (⊤ : Opens α) = Set.univ`). `IsFinitelyPresentable` is defined in `CategoryTheory/Presentable/Finite.lean` as `IsCardinalPresentable X ℵ₀`, which unfolds to `coyoneda.obj (op X)` preserving ℵ₀-filtered (= filtered) colimits — precisely the informal definition "Hom(c, -) preserves filtered colimits". The statement matches the classical equivalence, so it is strictly faithful.

### S_0059

**Verdict:** `faithful`

**Reasoning**

The Lean formalization defines a custom `LiftableCone₂` structure that extends Mathlib's `LiftableCone` with an additional `isLimit` field — this correctly captures the informal requirement that L' be a limit (not merely a cone). The `LiftsLimit K F` class then says: for every limit cone c of K⋙F, there exists a lifted limit cone. The theorem asserts the existence of categories C, D and a functor F such that for every diagram K: J → C, F lifts limits, and F is not faithful (using Mathlib's `Functor.Faithful`). This correctly distinguishes "lifts limits" (existence only) from Mathlib's `CreatesLimit` (which requires reflecting limits). The universe polymorphic treatment of J (objects in Type u₁, morphisms in Type w') is standard and matches "every diagram". The `Nonempty` wrapper is appropriate since `LiftsLimit` is data-carrying. All three required pieces — the universal quantification over diagrams and their limits, the existence of a limit lift, and the non-faithfulness — match exactly.

### S_0060

**Verdict:** `faithful`

**Reasoning**

The Lean formalization faithfully encodes each of the four informal hypotheses: `LocallySmall.{w} ℬ` (locally small), `HasLimitsOfSize.{w, w} ℬ` (complete), `{S : Set ℬ} [Small.{w} S] (hS : IsCoseparating S)` (small coseparating set S), and the explicit condition `∀ A s, ∃ f, IsGLB s f` (every family of subobjects has an intersection — an `IsGLB` in the `Subobject A` poset is exactly a meet/intersection). The conclusion `HasInitial ℬ` matches "has an initial object". The universe `w` is used consistently for all the "small" constraints. Note: the standard Mathlib theorem `hasInitial_of_isCoseparating` uses `WellPowered` rather than the intersection hypothesis, but the Lean here directly mirrors the informal statement's literal fourth hypothesis (the classical Freyd SAFT formulation) rather than substituting a related Mathlib notion.

### S_0062

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the informal theorem. `StronglyComplete C` bundles `HasLimits C` with `HasIntersections C`, and `StronglyCocomplete C` is defined as `StronglyComplete Cᵒᵖ` (giving `HasColimits C` and cointersections). Although `IsIntersectionOf` uses a lattice-GLB formulation (quantifying over subobjects rather than arbitrary morphisms), this is equivalent to the informal universal-property definition in any category with HasLimits — and HasLimits is precisely what's bundled in `StronglyComplete`, since in Mathlib `sInf` on subobjects is constructed as the wide pullback (see Subobject/Lattice.lean). `IsSeparating` matches the informal "separating set" definition. The `[Small.{v} 𝒢]` hypothesis is a standard Mathlib encoding that makes explicit the implicit smallness of "separating set" (cf. `hasLimits_of_hasColimits_of_isSeparating` in AdjointFunctorTheorems.lean which uses the same convention). No hypothesis is dropped or added beyond surfacing implicit premises, and the conclusion matches. The theorem as stated is logically equivalent to the informal claim.

### S_0063

**Verdict:** `faithful`

**Reasoning**

Both theorems faithfully capture the informal statement. (1) `IsFinitelyPresentable` in Mathlib is defined as `IsCardinalPresentable X ℵ₀`, which unfolds to "`coyoneda.obj (op X)` (= Hom(X,-)) preserves ℵ₀-filtered (= filtered) colimits"—exactly the informal definition of "compact." (2) `IsFinitelyPresentedGrp` correctly encodes "finitely presented as a group" using `PresentedGroup rels = FreeGroup α / normalClosure rels` with both `Finite α` (finite generators) and `rels.Finite` (finite relations). (3) The second theorem's awkward structure `∀ j, P(j) ∧ Q` where Q doesn't depend on j is logically equivalent to `(∀ j, P(j)) ∧ Q` because the Mathlib `IsFiltered` class requires `[nonempty : Nonempty C]`, so J cannot be empty. (4) `Grp.FilteredColimits.colimit F` genuinely constructs the filtered colimit in Grp, and "direct limit" is standardly interpreted as filtered/directed colimit (equivalent in Grp). (5) The universe handling is consistent: with `J : Type u` and `F : J ⥤ Grp.{u}`, `max u u = u` matches the colimit's universe signature.

### S_0065

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully encodes the informal statement. "Complete" is `HasLimits C`, "wellpowered" is `WellPowered C`, "cowellpowered" is `WellPowered Cᵒᵖ` (the standard Mathlib encoding used, e.g., in `hasLimits_of_hasColimits_of_hasSeparator`), and "has a separator S" is `(S : C) (hS : IsSeparator S)`. The conclusion is a biconditional between `HasColimits C` (cocomplete) and the existence of all $I$-indexed copowers of $S$, expressed as `∀ I : Type v, HasColimit (Discrete.functor (fun _ : I => S))`, which is by definition `HasCoproduct` of the constant family $S$, i.e., the $I$-th copower. The universe `Type v` for `I` is the canonical choice matching `HasColimits` = `HasColimitsOfSize.{v,v}`. No hypotheses are added or dropped, and the quantifier structure and conclusion match precisely.

### S_0066

**Verdict:** `faithful`

**Reasoning**

The Lean formalization captures the informal statement well. `IsIntersectionOf` encodes the meet/infimum in the subobject poset: (1) A ≤ each member of S (A's arrow factors through each i_n), and (2) any subobject A' below all members is ≤ A. While the informal condition (2) quantifies over any morphism f:z→c, rather than just monos/subobjects, these two formulations of "intersection of subobjects" are the standard equivalent notions in category theory (equivalence holds in categories with image factorizations, which always holds in strongly complete categories — the setting being considered). `HasIntersections`, `StronglyComplete`, and `StronglyCocomplete` (via `StronglyComplete Cᵒᵖ`) correctly mirror the informal definitions. The theorem asserts `∃ C, StronglyCocomplete C ∧ HasSeparator C ∧ ¬WellPowered C ∧ ¬WellPowered Cᵒᵖ`, which directly matches "there exists a strongly cocomplete category with a separator that is neither wellpowered nor co-wellpowered" (co-wellpowered = wellpowered in the opposite category, following Mathlib convention). The existential structure and universe handling are standard for asserting existence of a category.

### S_0067

**Verdict:** `faithful`

**Reasoning**

The Lean functor `F : Natᵒᵖ ⥤ RingCat` correctly encodes F_n := k[x]/(x^n) via `k[X] ⧸ Ideal.span {X^n}`, with transition morphisms given by `Ideal.Quotient.factor` derived from `pow_dvd_pow`, which are precisely the canonical quotient maps k[x]/(x^{n+1}) → k[x]/(x^n) specified informally. The cone `cone_F k` has apex `PowerSeries k` (= k[[x]]) with cone maps given by `PowerSeries.trunc n` — the natural truncation maps. The theorem asserts `Nonempty (IsLimit (cone_F k))`, i.e., this specific cone is a limit cone. The informal claim "the limit exists and is isomorphic to k[[x]]" in context naturally means k[[x]] with truncation maps is the limit; picking these canonical maps is the standard reading rather than an added strength. Being a limit cone entails both that the limit exists and that its apex is k[[x]]. The functor direction, ordinal indexing, and cone maps all match faithfully.

### S_0068

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts the existence of a category C with regular epimorphisms f : c → d and g : c' → d' whose product is not regularly epic. The Lean signature captures exactly this: it existentially binds a category (with some universe), objects, the two morphisms, RegularEpi instances for f and g (matching Mathlib's definition of coequalizer of a parallel pair), and asserts IsEmpty (RegularEpi (prod.map f g)), which is logically equivalent to "prod.map f g is not a regular epi". The HasBinaryProduct c c' and HasBinaryProduct d d' hypotheses are not additional assumptions that weaken the claim — they are necessary implicit premises for the phrase "the product of f and g" to be well-defined as the morphism prod.map f g. Making these explicit surfaces what the informal statement already implicitly assumes. The quantifier structure, object types, morphism types, and conclusion all match the informal claim, so this is a strictly faithful formalization.

### S_0069

**Verdict:** `faithful`

**Reasoning**

The Lean statement uses standard Mathlib idioms that correctly capture the informal claim: (1) `ModuleCat ℤ` is equivalent to the category of abelian groups Ab; (2) `NoZeroSMulDivisors ℤ A` is Mathlib's standard formalization of torsion-free for a ℤ-module (the docstring explicitly says "this is a version of saying that M is torsion free"); (3) `Module.Free ℤ` is the correct notion of free abelian group; (4) the encoding `∃ J, SmallCategory J, IsFiltered J, F : J ⥤ ModuleCat ℤ, Nonempty (A ≅ colimit F)` expresses "A is isomorphic to a colimit of a filtered diagram" — which, up to isomorphism, coincides with "directed colimit" in the informal sense (every filtered colimit is isomorphic to a directed colimit via cofinality, and directed posets are filtered). The iff holds in both directions (filtered colimits in Ab are exact, so preserve torsion-freeness; conversely every torsion-free abelian group is the directed colimit of its finitely-generated—hence free—subgroups). The formalization captures the same mathematical content as the informal statement.

### S_0070

**Verdict:** `faithful`

**Reasoning**

The informal statement assumes the framework of a "concrete category (C, U) over B", which by universal mathematical convention (nLab, Joy of Cats, Mac Lane, Riehl) definitionally requires U to be faithful. The Lean formalization correctly surfaces this implicit premise by adding `CategoryTheory.Functor.Faithful U`. The other hypotheses match exactly: `HasLimitsOfSize.{v, v} C` matches "C has all small limits", `PreservesLimitsOfSize.{v, v} U` matches "U preserves them", and the bi-conditional conclusion `ReflectsLimitsOfSize.{v, v} U ↔ U.ReflectsIsomorphisms` matches "U reflects small limits iff U reflects isomorphisms". The `.{v, v}` universe annotations encode "small" limits in the standard Mathlib way. This is a textbook case of surfacing an implicit premise (the faithfulness of U in the definition of a concrete category) that the informal statement relies on but does not spell out in the theorem line itself.

### S_0071

**Verdict:** `faithful`

**Reasoning**

The custom `LiftsLimit` class matches the informal definition precisely: for any cone over `K ⋙ F` that is a limit, there exists a cone over `K` that is a limit and whose image under `F` is isomorphic to the given cone. (The informal statement's "$L' \in \mathcal D$" is a clear typo — $L'$ must be in $\mathcal C$ for $F(L')$ to typecheck, which the Lean correctly captures.) "Lifts equalizers" is correctly encoded as `LiftsLimitsOfShape Limits.WalkingParallelPair F`, since `WalkingParallelPair` is the standard indexing category for equalizer diagrams in Mathlib. The conclusion `F.Faithful ↔ F.ReflectsEpimorphisms` uses the correct Mathlib definitions (injective on morphisms; morphism is epi if its image is epi). The author deliberately avoids `CreatesLimit` (which would be strictly stronger by adding reflection). The universe setup and quantifier structure match the informal claim.

### S_0072

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully captures the informal claim. A "full subcategory of CompHaus" is encoded as a category D with a fully faithful functor i : D ⥤ CompHaus (the standard Mathlib encoding). `Nonempty (Reflective i)` correctly captures "is reflective": `Reflective` is a class with data fields (a left adjoint L and adjunction L ⊣ i), and since `Full i`/`Faithful i` are already in scope, its existence is exactly "i has a left adjoint". `Nonempty (HasColimits D)` is logically equivalent to `HasColimits D` (since it's a Prop), matching "cocomplete". `∃ X : D, Nonempty (i.obj X)` uses the `CoeSort` on `CompHaus` to state that some object's underlying space is nonempty, matching "contains at least one non-empty space". Universes are consistent. No hypotheses are silently dropped or added, and both directions of the iff are preserved.

### S_0073

**Verdict:** `faithful`

**Reasoning**

The Lean statement `LiftsLimits (forget TopCat) ∧ IsEmpty (ReflectsLimits (forget TopCat))` matches the informal claim "U : Top → Set lifts limits, but not reflects limits." The locally-defined `LiftsLimit` class correctly encodes the standard categorical notion: for every limit cone c of K ⋙ F, there exists a cone c' over K that is a limit and whose image F.mapCone c' is (cone-)isomorphic to c — this matches the informal "F(L') ≅ L" reading under the standard categorical convention (despite the informal statement's minor typo writing "L' ∈ D" instead of L' ∈ C). The `LiftsLimitsOfShape`/`LiftsLimitsOfSize`/`LiftsLimits` hierarchy then quantifies over all small diagrams, which matches "for every diagram". Since `ReflectsLimits` is a `Prop` (as `ReflectsLimitsOfSize` is declared `: Prop`), `IsEmpty (ReflectsLimits _)` is logically equivalent to `¬ ReflectsLimits _` by `IsEmpty.prop_iff` in Mathlib, correctly encoding "not reflects limits". The universe choice `.{v₂, v₂}` for both `LiftsLimits` and `ReflectsLimits` resolves to `.{u, u}` for `forget TopCat : TopCat.{u} ⥤ Type u`, a standard convention for "all small limits". No hypotheses are added or dropped, and the conjunction faithfully captures both clauses of the informal theorem.

### S_0074

**Verdict:** `faithful`

**Reasoning**

The Lean statement reproduces the informal claim piece-by-piece. `IsProCompletion ι` encodes "L is a pro-completion of C (containing C as full subcategory via ι)" by requiring an equivalence `L ≌ Pro C := (Ind Cᵒᵖ)ᵒᵖ` under which ι corresponds to the standard `proYoneda` embedding; the full/faithful hypotheses on ι capture "C as a full subcategory". `HasCofilteredColimits L` matches condition (1) verbatim. `IsCofilteredColimitOf ι X` (existence of a small cofiltered J and F: J → C with colim(F ⋙ ι) ≅ X) matches condition (2) verbatim — including the informal statement's literal "colimit of a cofiltered diagram". `IsFinitelyCopresentable X := IsFinitelyPresentable (op X)` in Lᵒᵖ is the standard op-dual of Mathlib's `IsFinitelyPresentable`, matching condition (3). The universe-polymorphic parameter `w` is a standard Lean generality, not a semantic restriction. No hypothesis is silently added or dropped, no quantifier structure is altered, and the biconditional is preserved.

### S_0075

**Verdict:** `faithful`

**Reasoning**

The Lean signature faithfully formalizes the informal statement. Mathlib's `IsSifted` (diagonal functor `C ⥤ C × C` is final, plus nonempty) is the standard equivalent of "category of cocones over any finite discrete family is connected" per nLab. `HasPullbacks` matches "with pullbacks", and `IsFiltered` matches "is filtered". The `Rec C` construction encodes the free cocompletion under reflexive coequalizers via the inductive `RecObjectPresentation` (generated from the Yoneda embedding, closed under isomorphism and reflexive coequalizers), materialized as a full subcategory of `Psh C` — this is the standard model of the free reflexive-coequalizer cocompletion. The `[LocallySmall C]` requirement on `Rec` is a universe/size technicality automatically satisfied by `locallySmall_self` and doesn't add mathematical content. The theorem's hypotheses and conclusion match the informal statement's hypotheses and conclusion exactly.

### S_0076

**Verdict:** `faithful`

**Reasoning**

The Lean statement correctly formalizes each component of the informal claim. The local `abbrev Pro C := (Ind Cᵒᵖ)ᵒᵖ` is the standard categorical definition of the pro-completion. `FintypeCat` in Mathlib is the category of finite types with functions as morphisms, matching "finite sets and functions". `Profinite` in Mathlib is defined as compact Hausdorff totally disconnected spaces with continuous maps — which is exactly the category of Stone spaces described informally ("compact topological spaces in which distinct elements can be separated by clopen subsets"); for compact spaces, separability by clopens is equivalent to being totally disconnected and Hausdorff. The conclusion `Nonempty ((Pro FintypeCat) ≌ Profinite)` is the standard way to state the existence of a categorical equivalence as a proposition, matching "Pro(Set^fin) = Stone". Indeed, the Mathlib `Profinite` file lists this equivalence as a TODO. No hypotheses are added or dropped.

### S_0078

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures the informal theorem: small categories (`[SmallCategory C]`, `[SmallCategory D]`), full and faithful functor (`[Full I] [Faithful I]`), presheaf `φ : Cᵒᵖ ⥤ Type u`, and the iff between `IsSindObject φ` and `IsSindObject (lanPresheaf I φ)`. The definition `lanPresheaf I φ := weightedColimit φ (I ⋙ yoneda)` matches `Lan_{I^op}(φ) = φ ⋆ yI`. `IsSindObject A` asserts existence of a small sifted indexing category I, a functor F : I ⥤ C, and a colimit cocone from F ⋙ yoneda to the constant functor on A — the standard characterization of objects in the free cocompletion under sifted colimits (small sifted colimits of representables). The `[HasWeightedColimit φ (lanDiagram I)]` hypothesis is a technical Lean prerequisite for `lanPresheaf I φ` to be defined (it holds automatically in the cocomplete presheaf category `Dᵒᵖ ⥤ Type u`), so it makes explicit a latent premise needed for the statement to be well-formed rather than narrowing the scope.

### S_0079

**Verdict:** `faithful`

**Reasoning**

The informal statement asks to prove that composition in an additive category is bilinear in each argument. The Lean formalization uses `[Preadditive C]`, which is Mathlib's formalization of an Ab-enriched category (abelian group hom-sets with bilinear composition). Although "additive category" in strict modern convention includes finite biproducts, the bilinearity claim here is purely about the hom-set abelian-group structure, which is exactly what `Preadditive` captures — the biproduct structure is completely irrelevant to bilinearity. Mathlib's own documentation uses "additive, preadditive, Ab-category, Ab-enriched" interchangeably as tags for `Preadditive`, so this is the natural formalization. The `IsBilinear` structure encodes standard bilinearity (additivity and zero-preservation in each argument), and the theorem `f ↦ (g ↦ g ≫ f)` being bilinear is precisely the Preadditive axioms `add_comp`/`comp_add` plus zero-composition laws. The Lean signature captures the mathematical content of the informal statement exactly.

### S_0080

**Verdict:** `faithful`

**Reasoning**

The informal statement says: in an abelian category, a morphism is an isomorphism iff it is both monic and epic. The Lean signature fixes `C` with `[Category C] [Abelian C]`, takes an arbitrary morphism `f : X ⟶ Y`, and states `IsIso f ↔ (Mono f ∧ Epi f)`. These correspond exactly: `IsIso` is "isomorphism", `Mono f` is "monic", `Epi f` is "epic", and `↔` is "if and only if". Abelian categories are balanced in Mathlib (via `IsNormalMonoCategory` → `IsRegularMonoCategory` → `StrongMonoCategory` → `Balanced`), so this is the standard encoding. No hypotheses are added or dropped, no types are altered, and quantification over `f` is preserved. This is a direct, logically equivalent formalization.

### S_0081

**Verdict:** `faithful`

**Reasoning**

The Lean statement captures the informal claim precisely: the abelian category hypothesis `[Abelian C]` is present, f is an arbitrary morphism between arbitrary objects X, Y in C, and the conclusion `Mono f ↔ IsZero (kernel f)` expresses 'f is monic iff ker(f) = 0' in the standard Mathlib way. In Mathlib's abelian category API (e.g. `Abelian.tfae_mono` in `CategoryTheory/Abelian/Exact.lean`), `Mono f`, `kernel.ι f = 0`, and `IsZero (kernel f)` are all equivalent characterizations, and `IsZero (kernel f)` is the natural formalization of 'the kernel object is zero.' There is no strengthening or weakening of the hypotheses or conclusion.

### S_0082

**Verdict:** `faithful`

**Reasoning**

The informal claim decomposes into: (a) 𝕜 is simple in Vect_𝕜, and (b) every simple 𝕜-vector space is isomorphic to 𝕜. The Lean file provides both: the instance `isSimpleModule_self` proves (a), and the theorem `unique_simple_object` asserts (b) by stating that any type M with `[AddCommGroup M] [Module 𝕜 M] [IsSimpleModule 𝕜 M]` admits a linear equivalence `M ≃ₗ[𝕜] 𝕜`. Mathlib's `IsSimpleModule R M` unfolds to `IsSimpleOrder (Submodule R M)` — the submodule lattice has only ⊥ and ⊤ and is nontrivial — which is exactly the categorical notion of a simple object in Vect_𝕜. The `Nonempty (M ≃ₗ[𝕜] 𝕜)` correctly captures "isomorphic as 𝕜-vector spaces" (up to isomorphism). The universal quantification over M (implicit via Lean's variable) matches the informal claim. No hidden hypotheses or type mismatches.

### S_0083

**Verdict:** `faithful`

**Reasoning**

The informal statement claims ZMod p is a simple object in Ab (category of abelian groups) when p is prime. The Lean statement claims `Simple (ModuleCat.of ℤ (ZMod p))` — simple object in the category of ℤ-modules. These are logically equivalent because: (1) the forgetful functor `ModuleCat ℤ → AddCommGrp` is an equivalence of categories (Mathlib's `forget₂AddCommGroupIsEquivalence`); (2) ℤ-submodules of an abelian group are exactly its subgroups; (3) the categorical `Simple` predicate is preserved under equivalence of categories. Furthermore, Mathlib has `simple_iff_isSimpleModule : Simple (of R M) ↔ IsSimpleModule R M`, so the Lean statement reduces to "ZMod p is a simple ℤ-module," which matches "ZMod p is a simple abelian group." The encoding choice (ℤ-module rather than AddCommGrp directly) is a standard, mathematically equivalent formalization.

### S_0084

**Verdict:** `faithful`

**Reasoning**

The informal statement claims Grp is not an additive category. The Lean file defines `IsAdditiveCategory C` as the existence of a Preadditive structure on C together with a zero object and finite biproducts, which matches the standard definition of an additive category (confirmed in Mathlib's documentation where "additive category (i.e. is preadditive and has finite biproducts)" is used; the extra `HasZeroObject` is redundant but not incorrect since it is implied by Preadditive + HasFiniteBiproducts). `IsEmpty (IsAdditiveCategory Grp.{u})` for a proposition expands to `¬ IsAdditiveCategory Grp.{u}`, so it literally states "there is no way to make Grp an additive category." The existential `∃ (_ : Preadditive C), ...` correctly encodes "there exists preadditive structure such that..." — the right form when asserting non-existence of the structure. Universes, types (Grp.{u} is Mathlib's bundled category of groups), and quantifier structure all match. This is a faithful formalization.

### S_0086

**Verdict:** `faithful`

**Reasoning**

The Lean signature uses `{A : Type u} [Category.{v} A] [Abelian A]` to express "let A be an abelian category" and `(P : A)` to universally quantify over objects P, matching the informal statement's setup. The functor `preadditiveCoyoneda.obj (op P)` is exactly Hom_A(P, -) : A ⥤ AddCommGrp (i.e., A → Ab), per the Mathlib definition (sends Y ↦ (P ⟶ Y) as an abelian group). `PreservesFiniteColimits` is Mathlib's canonical encoding of "right exact" (confirmed in `CategoryTheory/Limits/ExactFunctor.lean`), and `Functor.PreservesEpimorphisms` is the standard "preserves epimorphisms" predicate. The biconditional `↔` matches "if and only if". No hypotheses are added or dropped, no types are altered, and the target `AddCommGrp` matches Ab.

### S_0087

**Verdict:** `faithful`

**Reasoning**

The Lean statement faithfully encodes the informal claim. `IsSemisimple A` is defined as "every short exact sequence admits a splitting" via `Nonempty S.Splitting`, which matches the informal definition (the `Nonempty` wrapping is required since `ShortComplex.Splitting` is structured data, not a proposition). The informal three-way equivalence (1) ↔ (2) ↔ (3) is captured as `(1 ↔ 2) ∧ (1 ↔ 3)`, which is logically equivalent to the three-way equivalence by transitivity. `CategoryTheory.Injective` and `CategoryTheory.Projective` are the standard Mathlib definitions for categorical injective/projective objects. The quantification over a general abelian category `A` with universes `{u, v}` matches "Let $\mathcal{A}$ be an abelian category."

### S_0088

**Verdict:** `faithful`

**Reasoning**

The Lean file contains three theorems that together capture the three parts of Schur's lemma from the informal statement. (1) `simple_objects_nonzero_morphisms_iso` directly corresponds to the claim that nonzero morphisms between simples are isomorphisms, matching Mathlib's `isIso_of_hom_simple`. (2) `simple_object_end_is_division_ring` uses `Nonempty (DivisionRing (End x))`—since `End x := x ⟶ x` is exactly Hom(x,x) and `DivisionRing` is a data-carrying typeclass, wrapping in `Nonempty` is the standard way to assert as a Prop that such a structure exists, matching Mathlib's canonical `DivisionRing (End X)` instance for simple X. (3) `simple_objects_hom_zero_of_ne` uses `IsEmpty (x ≅ y)` to formalize "x ≠ y"; in the abstract abelian category setting this is the correct reading (literal object inequality would make the claim false for isomorphic-but-unequal objects), so this appropriately surfaces the implicit premise. The `Abelian 𝒜` hypothesis provides the required `Preadditive` and `HasKernels` structure.

### S_0090

**Verdict:** `faithful`

**Reasoning**

The Lean formalization correctly captures the informal statement. `IsNormalMonoCategory` exactly encodes "each mono is a kernel" (normal), and `IsNormalEpiCategory` encodes "each epi is a cokernel" (conormal); together they give binormality. The mono-simplicity condition `∀ y (f : y ⟶ x) [Mono f], f = 0 ∨ IsIso f` correctly captures "no proper subobjects" (the standard algebraic meaning, matching Mathlib's `Simple` class: every mono is either the zero subobject or represents the whole object), and dually for epi-simplicity. The iff quantifier structure matches. The extra `HasKernels`/`HasCokernels` hypotheses are implicit structural premises that any mathematician would understand as part of working with binormal categories in practice — they are needed to make the proof go through (e.g., to form kernels of arbitrary epis and apply epi-mono factorization) and don't narrow the theorem beyond its intended scope.

### S_0091

**Verdict:** `faithful`

**Reasoning**

The informal statement says: for any monad T on a category C, the forgetful functor U : C^T → C from the Eilenberg-Moore category admits a left adjoint. In Mathlib, `T.forget : Monad.Algebra T ⥤ C` is defined as the forgetful functor from the Eilenberg-Moore category of T. The class `Functor.IsRightAdjoint right` unfolds to `∃ (left : C ⥤ D), Nonempty (left ⊣ right)`, i.e. "there exists a left adjoint to `right`". Thus `T.forget.IsRightAdjoint` asserts precisely that the forgetful functor admits a left adjoint. The universal quantification over C and T is captured by the `variable` declaration and `(T : Monad C)` parameter. This is a faithful encoding.

### S_0093

**Verdict:** `faithful`

**Reasoning**

The Lean statement matches the informal theorem exactly. `HasColimitsOfSize.{w, w'} C/D` is the standard Lean encoding of "cocomplete" (parameterized over universe levels as is conventional in Mathlib — compare `hasColimits_of_reflective` which uses the same pattern). `HasCoequalizers D` is defined as `HasColimitsOfShape WalkingParallelPair D`, the standard notion of "has coequalizers". `MonadicRightAdjoint G` is Mathlib's definition of a monadic right adjoint (the Monad.comparison is an equivalence). The biconditional structure `HasColimitsOfSize.{w, w'} D ↔ HasCoequalizers D` under the hypothesis that C has colimits of the same size exactly formalizes "D is cocomplete iff D has coequalizers" given "C is cocomplete" and "G is monadic". The universe polymorphism is a natural Lean formalism and doesn't alter the mathematical content.

### S_0094

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts: for a full reflective subcategory (fully faithful right adjoint inclusion U : C → B), the associated monad on B is idempotent. In Lean 4, the theorem's auto-bound arguments are only those referenced in the type (transitively), plus instance-implicit arguments on already-bound variables. Since the theorem type references `U` and `monadOfRightAdjoint U` (which needs `[IsRightAdjoint U]`), the auto-bound arguments are `C`, `B`, their `Category` instances, `U`, and the instance-implicit `[Full U]`, `[Faithful U]`, `[IsRightAdjoint U]`. The non-instance-implicit variables `{h_inj : Function.Injective U.obj}` and `{h_iso_closed : IsIsoClosed U}` are NOT auto-bound since they aren't referenced anywhere in the theorem type or proof (no `include` is used). The conclusion `IsIso T.μ` where `T = (Adjunction.ofIsRightAdjoint U).toMonad` correctly encodes "idempotent monad" (μ is an iso, which is the standard definition). This matches Mathlib's `counit_isIso_of_R_fully_faithful` — which implies μ of the associated monad is an iso. Hence the theorem signature is logically equivalent to the informal statement.

### S_0099

**Verdict:** `faithful`

**Reasoning**

The informal statement asserts that the monad on Set induced by the forgetful functor Top → Set is idempotent. In Mathlib, `TopCat.adj₁ : discrete ⊣ forget TopCat` is exactly this adjunction, with `discrete` as the left adjoint of `forget`. Then `TopCat.adj₁.toMonad` is the monad on `Type` whose underlying endofunctor is `discrete ⋙ forget` (verified in `Mathlib/CategoryTheory/Monad/Adjunction.lean` where `toMonad` is defined with `toFunctor := L ⋙ R` and `μ := whiskerRight (whiskerLeft L h.counit) R`). The standard category-theoretic definition of an idempotent monad is that the multiplication `μ : T ⋙ T ⟶ T` is a natural isomorphism; `IsIso` applied to this natural transformation expresses precisely this (Mathlib itself uses this formulation in `μ_iso_of_reflective`). Hence the Lean statement correctly captures the informal claim with no hidden assumptions or strengthening/weakening.

### S_0100

**Verdict:** `faithful`

**Reasoning**

The Lean formalization encodes all three conditions correctly and asserts their mutual equivalence via `List.TFAE`. (1) `cond1` uses `K.Full ∧ K.Faithful`, which is Mathlib's standard way to express fully faithful, and `K` is defined as `Monad.comparison adj : D ⥤ adj.toMonad.Algebra`, matching K : D → C^T. (2) `cond2` correctly defines the cofork: `epsFG d = adj.counit.app (FG.obj d) = ε_{FG(d)}` and `FGeps d = FG.map (adj.counit.app d) = FG(ε_d)`, both FGFG(d) → FG(d), with π = ε_d, and asserts this is a colimit — exactly "ε_d is a coequalizer of ε_{FG(d)} and FG(ε_d)". (3) `cond3` encodes "G reflects split epis to regular epis" as: for every f : X → Y in D, if G.map f is a split epi (in C), then f is a regular epi (in D), which is the standard reading. `IsRegularEpi' f := Nonempty (RegularEpi f)` correctly propositionalizes Mathlib's data-carrying `RegularEpi` class. The quantifier structure, types, and cofork orientation all match the informal claim.

## weaker (7)

### S_0023

**Verdict:** `weaker`

**Reasoning**

The informal statement asserts a specific claim: the restriction-of-scalars functor φ_* has B ⊗_A - as left adjoint and Hom_A(B, -) as right adjoint. The Lean statement, however, only asserts the existence of some functors φ_pull : ModuleCat B ⥤ ModuleCat A, φ_push, φ_coind : ModuleCat A ⥤ ModuleCat B forming an adjoint triple φ_push ⊣ φ_pull ⊣ φ_coind, without any requirement that φ_pull be the restriction of scalars functor associated with φ (nor that φ_push/φ_coind be the specific tensor/Hom functors). Indeed, φ is only used to fix the rings A and B — the existentials are not tied to φ at all. The informal statement implies the Lean existential (choose the canonical functors), but the Lean statement does not imply the informal one, since it could be witnessed by any adjoint triple. Hence the Lean formalization is strictly weaker.

### S_0031

**Verdict:** `weaker`

**Reasoning**

The informal statement is a conjunction covering two categories: "Neither Set nor Top has a proper iso-closed full subcategory that is both reflective and coreflective." The Lean formalization only covers the Set case — it quantifies `P : ObjectProperty (Type u)` where `Type u` is Mathlib's category of sets (per `Mathlib/CategoryTheory/Types.lean`'s `instance types : LargeCategory (Type u)`). There is no corresponding statement about `TopCat` (the category of topological spaces). The Set-half of the statement is correctly formalized (iso-closed via `IsClosedUnderIsomorphisms`, proper via `∃ X, ¬ P X`, and the "not both reflective and coreflective" via the disjunction of `IsEmpty`), but the omission of the topological spaces half makes the Lean statement strictly weaker than the informal claim.

### S_0037

**Verdict:** `weaker`

**Reasoning**

The informal statement is a conjunction of two claims: (1) there are precisely two concrete functors from Set to Top, and (2) there is a proper class of concrete functors from Top to itself. The Lean theorem `only_two_concrete_functors_from_Set_to_Top_iso` formalizes only the first conjunct (`Nat.card (ConcreteFuncClasses SetConcrete TopConcrete) = 2`) and entirely omits the second claim about a proper class of concrete functors from Top to Top. Since the Lean statement proves strictly less than the informal statement asks for, it is logically weaker: the informal statement implies the Lean statement, but the Lean statement does not imply the informal one.

### S_0064

**Verdict:** `weaker`

**Reasoning**

The first theorem `isCompactObject_Grp_iff_finite_presented` includes an extraneous `[Group X]` hypothesis on top of `[AddCommGroup X] [Module A X]`. In Mathlib, `Group` is the multiplicative group typeclass (extending `DivInvMonoid`), completely independent from `AddCommGroup`. The informal statement quantifies over all A-modules, but the Lean version restricts X to types that also happen to carry a (wholly unrelated) multiplicative group structure — most natural A-modules (e.g., ℤ, ℚ, ℝ as modules) do not automatically have such an instance. This is not making an implicit premise explicit (the iff compact ↔ finitely presented holds for all A-modules without needing a multiplicative group structure); it is a scope-narrowing extraneous hypothesis. Hence the Lean formalization is logically implied by the informal claim but does not imply it, making it strictly weaker. Theorem 2 appears faithful on its own, but the file as a whole is weaker due to theorem 1.

### S_0077

**Verdict:** `weaker`

**Reasoning**

The informal statement just requires "a category with pullbacks" — conventionally meaning a locally small category. The Lean statement adds `[SmallCategory C]`, which by Mathlib's convention means `Category.{u} C` with objects and morphisms in the same universe, a strictly stronger hypothesis than a general `[Category.{v} C]`. Mathlib's `Ind`, along with the `Sind`/`Rec` constructions defined in this very file (declared under `variable {C : Type u} [Category.{v} C]`), work universe-polymorphically and do not require `SmallCategory`. Thus the Lean theorem proves only the special case where C is small, not the general result claimed informally. Since this is not merely surfacing an implicit premise needed for truth (the non-small universe-polymorphic version is sensible and standard in Mathlib), the added smallness hypothesis makes the Lean statement logically weaker.

### S_0092

**Verdict:** `weaker`

**Reasoning**

The informal statement says "Let R be a ring" — a universal claim over arbitrary (not necessarily commutative) rings. The Lean formalization adds `[CommRing R]`, restricting the theorem to commutative rings only. This is strictly weaker: the informal statement implies the Lean statement (since commutative rings are a special case), but the Lean statement does not imply the informal one. Commutativity is not an implicit premise needed for truth — indeed, Mathlib's own formalization of this exact result in `Mathlib/Algebra/Category/ModuleCat/Colimits.lean` uses `[Ring R]` (not `CommRing`), confirming the theorem is true for all rings. The rest of the encoding (`Nonempty (CreatesColimits ...)`, the forgetful functor `forget₂ (ModuleCat R) AddCommGrp`) reasonably matches the informal content — `CreatesColimits` is the abbreviation for `CreatesColimitsOfSize.{v₂, v₂}`, i.e., small colimits, which matches "all colimits Ab admits" since Ab has all small colimits. But the extra `CommRing` hypothesis narrows scope beyond what was asked.

### S_0096

**Verdict:** `weaker`

**Reasoning**

The informal statement describes the classical adjunction $-\otimes_{\mathbb{Z}} R : \mathrm{Ab} \to \mathrm{Ab}_R$ with no restriction on R, and specifically concludes that T-algebras are *right* R-modules — a distinction that matters for non-commutative R. The Lean formalization adds `[CommRing R]` (required by Mathlib's `extendScalars` / `extendRestrictScalarsAdj`, which are defined only for commutative rings in `ChangeOfRings.lean:336, 817`) and uses `ModuleCat R`, which is the category of *left* R-modules. For commutative R, left = right modules, so the Lean statement is provable and correct — but only for the commutative case. The informal theorem covers all rings R (including non-commutative), where the result is a genuine, non-trivial statement about right modules. Thus the Lean signature only proves a strict special case of the informal claim, making it strictly weaker.

## stronger (7)

### S_0015

**Verdict:** `stronger`

**Reasoning**

The Lean formalization correctly encodes the category $\mathcal{L}at_\wedge$ as `SemilatInfCat` (inf-semilattices with top, `InfTopHom` morphisms), and the definitions of initial morphism, embedding, and injective object faithfully match the informal definitions. `IsFrameObj` correctly captures "frame structure on P" via LUB/GLB functions plus the frame distributive law. However, the informal statement says "injective objects are frames," which in mathematical English literally asserts only one direction: every injective object is a frame (Injective → Frame). The Lean theorem, by contrast, uses `↔`, which also asserts the converse — every frame is an injective object. The converse direction is mathematically true (classical characterization theorem), but it is an additional claim beyond what the informal text literally asks. Hence the Lean statement is strictly stronger than the informal statement.

### S_0025

**Verdict:** `stronger`

**Reasoning**

The informal statement explicitly requires "D admits coequalizers" as one of its hypotheses. The Lean formalization omits this hypothesis entirely — there is no `HasCoequalizers D` or `HasReflexiveCoequalizers D` assumption. This is the hypothesis that drives the classical adjoint triangle theorem construction (cf. Mathlib's `isRightAdjoint_triangle_lift`, which requires `HasReflexiveCoequalizers A` on the domain). By dropping an explicitly stated hypothesis from the informal statement while keeping the same conclusion, the Lean statement makes a strictly stronger claim: if the Lean statement holds, it implies the informal one, but not conversely. This is not an implicit premise being surfaced — it is an explicit premise being removed.

### S_0055

**Verdict:** `stronger`

**Reasoning**

The "creates limits" portion is reasonably formalized as `Nonempty (CreatesLimits (forget Grp.{u}))`. However, the "do not preserve coproducts" portion is formalized as `¬ Nonempty (PreservesColimitsOfShape (Discrete Bool) (forget Grp.{u}))`, which specifically says the functor fails to preserve BINARY coproducts (since `Bool` has exactly 2 elements, `Discrete Bool` is the indexing category for binary coproducts). The informal statement "do not preserve coproducts" is most naturally read as the negation of "preserves all coproducts" — i.e., ∃ some indexing shape J for which coproducts are not preserved. The Lean version picks a specific witness (binary/Bool) for this existential, which is logically stronger: failing on binary coproducts implies failing on "all coproducts" preservation, but the informal claim doesn't specifically restrict to binary. So Lean → Informal, but not conversely.

### S_0085

**Verdict:** `stronger`

**Reasoning**

The informal statement asks for a single biconditional: F is left exact ⟺ (F is additive AND F preserves 0→x→y→z sequences). The Lean statement is Mathlib's `preservesFiniteLimits_tfae`, which, under the hypothesis [F.Additive], asserts a 4-way TFAE including: (1) F preserves short exact sequences 0→A→B→C→0 with mono; (2) F preserves left-exact sequences 0→X→Y→Z (this matches the informal's condition); (3) F preserves kernels (via `PreservesLimit (parallelPair f 0)`); (4) F preserves finite limits. The item-2 ↔ item-4 equivalence under [F.Additive] corresponds to the informal biconditional (since in abelian categories `PreservesFiniteLimits → Additive` is automatic via `additive_of_preserves_binary_products`). However, the Lean TFAE asserts two additional equivalences (items 1 and 3: preservation of short exact sequences and preservation of kernels) that are genuine extra conclusions beyond the informal biconditional. These are separate mathematical claims not requested by the informal statement, making the Lean strictly stronger.

### S_0089

**Verdict:** `stronger`

**Reasoning**

The informal statement assumes "hom(x,x) is a division ring", but the Lean formalization uses the strictly weaker hypothesis `[NoZeroDivisors (End x)]`. In Mathlib, `NoZeroDivisors` only requires `a*b = 0 → a = 0 ∨ b = 0`, while `DivisionRing` additionally requires nontriviality (0 ≠ 1) and that every nonzero element have a multiplicative inverse. `DivisionRing (End x)` implies `NoZeroDivisors (End x)` (via the `GroupWithZero.noZeroDivisors` instance), but the converse fails in general (e.g., ℤ has no zero divisors but is not a division ring). In particular, when `x` is a zero object, `End x` is the trivial ring, which vacuously satisfies `NoZeroDivisors` but is NOT a division ring — so the Lean theorem applies to cases the informal statement excludes. The proof only needs `NoZeroDivisors` (it works by showing that `fr` for a split mono/epi is an idempotent, which must be 0 or 1 under NZD). Since the conclusion matches exactly and the Lean theorem is provable under a weaker hypothesis than the informal, the Lean statement is logically stronger: it implies the informal claim but is strictly more general.

### S_0095

**Verdict:** `stronger`

**Reasoning**

The informal statement has four hypotheses: (i) D has coequalizers, (ii) G has a left adjoint, (iii) G is conservative, (iv) G preserves coequalizers. The Lean formalization declares `(adjFG : F ⊣ G)` as an explicit (non-instance) binder via `variable`, intending it as hypothesis (ii). However, in Lean 4 the auto-inclusion rule for `variable` only pulls an explicit `(...)` binder into a subsequent declaration when that declaration references the binder's name (or something depending on it). The theorem body is `sorry` and the signature `Nonempty (MonadicRightAdjoint G)` does not reference `adjFG` or `F`. Instance-style binders (HasCoequalizers D, G.ReflectsIsomorphisms, PreservesColimitsOfShape WalkingParallelPair G) are auto-included since their types reference the already-included `G` / `D`, but `adjFG` is not. Evidence in Mathlib confirms this behavior: authors use `include adj in` directives (e.g., Mathlib/CategoryTheory/Localization/Adjunction.lean:130) specifically because an unreferenced `(adj : G ⊣ F)` variable is otherwise omitted. Thus the elaborated theorem asserts that G is monadic (which via MonadicRightAdjoint G bundles a left adjoint) from only (i), (iii), (iv) — dropping the explicit assumption that G has a left adjoint. This is logically stronger than the informal statement, which requires (ii) as a hypothesis.

### S_0097

**Verdict:** `stronger`

**Reasoning**

The informal statement assumes "D admits coequalizers" — standardly meaning D has all coequalizers (HasCoequalizers D, i.e., for every parallel pair). The Lean formalization instead assumes only that for each monad algebra A, the specific "main pair" (F.map A.a, adj.counit.app (F.obj A.A)) has a coequalizer. This is a strictly weaker hypothesis: having all coequalizers trivially gives these particular ones, but many categories have these specific coequalizers without having all coequalizers. Because the Lean theorem derives the same conclusion (existence of a left adjoint to the comparison functor) from a weaker hypothesis, the Lean statement logically implies the informal one but is not implied by it. Thus the Lean formalization is stronger than what was asked — it proves the minimal-hypothesis version rather than the textbook version literally stated.

## incomparable (3)

### S_0033

**Verdict:** `incomparable`

**Reasoning**

The informal statement counts the number of full, isomorphism-closed, coreflective subcategories of CompHaus as mathematical objects — subcategories are identified by their underlying object-property. The Lean formalization defines `FullCoreflectiveSubcategory` as a structure whose third field is `coreflective : Coreflective obj.ι`, where Mathlib's `Coreflective` is a data-carrying class (containing an explicit right-adjoint functor `R : D ⥤ C` and an adjunction `L ⊣ R`), not a `Prop`. Thus `Nat.card (FullCoreflectiveSubcategory CompHaus)` counts tuples `(obj, iso_closed, Coreflective structure)`, where different (but naturally isomorphic) choices of `R` or `adj` yield distinct elements. The counts can diverge in both directions: a single mathematical coreflective subcategory can produce many (often infinitely many) Coreflective instances up to strict Lean equality, so the Lean count may be 0 (infinite type) or inflated; conversely, in principle the Lean count could hit 2 without there being exactly 2 underlying subcategories. Neither statement logically implies the other in general, so the formalization is incomparable. A faithful formalization would have used `Nonempty (Coreflective obj.ι)` or wrapped the coreflective condition as a propositional predicate.

### S_0061

**Verdict:** `incomparable`

**Reasoning**

The Lean statement diverges from the informal one in several incompatible ways. (1) Category: the informal claim is about finite-dimensional vector spaces Vec_𝕜, but the Lean uses `ModuleCat 𝕜` (all 𝕜-modules); finite-dimensionality is essential for trace and for the coend being 𝕜. (2) Construction: `IsColimit (Cofan.mk T tr)` is the categorical coproduct (colimit over a discrete diagram, per `Cofan := Cocone (Discrete.functor _)` in Mathlib's Products.lean) — NOT a coend, which requires the dinaturality coequalizer structure. The coend of Hom and the coproduct of Hom(X,X) are fundamentally different objects. (3) The specific identification T = 𝕜 with tr = trace is replaced by existential quantifiers over T and tr, making the Lean a trivially-true existence-of-coproduct claim in ModuleCat. (4) The Lean universally quantifies over functors F pointwise-iso to Hom, while the informal concerns Hom itself. These differences mean the Lean statement neither implies nor is implied by the informal one — they are about different mathematical objects.

### S_0098

**Verdict:** `incomparable`

**Reasoning**

The informal statement defines Adj_T with strict equalities: objects are adjunctions inducing the same monad T (equality), and morphisms are functors K satisfying KF = F' and G'K = G (strict equalities). The Lean formalization replaces all three of these equalities with isomorphisms: `monad_eq : T ≅ Adjunction.toMonad adj`, `comm_left : X.F ⋙ K ≅ Y.F`, and `comm_right : K ⋙ Y.U ≅ X.U`. This defines a pseudo/bicategorical version of Adj_T rather than the strict category in the informal statement. These are genuinely different categories: the pseudo version has more objects (monad_eq is only required up to iso) and morphisms carry extra iso data. Neither "Kleisli initial in strict Adj_T" nor "Kleisli initial in pseudo AdjCat T" straightforwardly implies the other — pseudo uniqueness must distinguish morphisms with different iso components, while strict uniqueness considers fewer morphisms but over a different class of objects. The initiality/terminality claims are therefore about different mathematical structures.
