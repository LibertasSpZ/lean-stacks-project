/-
Lemma 10.16.10. Let R be a ring. The space Spec(R) is quasi-compact.

Proof. It suffices to prove that any covering of Spec(R) by standard opens can be refined by a finite covering.
 Thus suppose that Spec(R)=∪D(fi) for a set of elements {fi}i∈I of R. This means that ∩V(fi)=∅. According to 
 Lemma 10.16.2 (00E0) this means that V({fi})=∅. According to the same lemma this means that the ideal generated
  by the fi is the unit ideal of R. This means that we can write 1 as a finite sum: 1=∑i∈Jrifi with J⊂I finite.
   And then it follows that Spec(R)=∪i∈JD(fi). 
-/

-- status of this lemma: I've reduced it to the case of a cover by basis elts
import Kenny_comm_alg.Zariski algebra.module Kenny_comm_alg.maximal_ideal tag00DY tag00E0
universe u

local attribute [instance] classical.prop_decidable

-- Kenny wrote this and it is unfinished and he got stuck I think
lemma lemma_quasi_compact_Kenny {R : Type u} [comm_ring R] : compact (@set.univ (X R)) :=
begin
  rw compact_iff_finite_subcover,
  intros c h1 h2,
  let S := generate (⋃₀{E : set R | ∃ (A : set (X R)) (H : A ∈ set.compl ⁻¹' c), Spec.V E = A}),
  have h3 := set.ext (Zariski._match_3 R (set.compl ⁻¹' c) (λ x hx, begin cases h1 (-x) hx with w h, existsi w, simpa using h, end)),
  replace h2 := set.eq_univ_of_univ_subset h2,
  have h4 : ⋂₀(set.compl ⁻¹' c) = -⋃₀ c,
  { rw set.compl_sUnion,
    apply congr_arg,
    apply set.ext,
    intro z,
    split,
    { intro hz,
      existsi -z,
      existsi hz,
      exact set.compl_compl z },
    { intro hz,
      cases hz with z1 hz1,
      cases hz1 with hz1 hz2,
      rw ← hz2,
      apply set.mem_of_eq_of_mem _ hz1,
      exact set.compl_compl z1 } },
  rw h4 at h3,
  rw h2 at h3,
  rw set.compl_univ at h3,
  rw V_set_eq_V_generate at h3,
  have h5 : S = set.univ,
  { apply classical.by_contradiction,
    intro h6,
    have h7 : is_proper_ideal S,
    from { ne_univ := h6 },
    have h8 := @@is_ideal.find_maximal_ideal.is_maximal_ideal _ S h7,
    have h9 := @is_ideal.find_maximal_ideal.contains _ _ S h7,
    rw set.eq_empty_iff_forall_not_mem at h3,
    specialize h3 ⟨@@is_ideal.find_maximal_ideal _ S h7, h8.to_is_prime_ideal⟩,
    exact h3 h9 },
  rw set.eq_univ_iff_forall at h5,
  specialize h5 1 (span (⋃₀{E : set R | ∃ (A : set (X R)) (H : A ∈ set.compl ⁻¹' c), Spec.V E = A})) subset_span,
  rcases h5 with ⟨v, hv1, hv2⟩,
  dsimp [lc] at v,
  have hv3 : ∀ x : {x // x ∈ finsupp.support v}, ∃ T, T ∈ c ∧ ∃ E, Spec.D E = T ∧ x.1 ∈ E,
  { intros x,
    cases x with x hx,
    simp [finsupp.support] at hx,
    have hv4 := classical.by_contradiction (mt (hv1 x) hx),
    rcases hv4 with ⟨T1, H, ht1⟩,
    rcases H with ⟨A, H, ht2⟩,
    existsi -A,
    split,
    { exact H },
    { existsi T1,
      split,
      { rw ← ht2, refl },
      { exact ht1 } } },
  existsi {x | x ∈ finset.image (λ x, classical.some $ hv3 x) v.support.attach},
  split,
  { intros z hz,
    dsimp at hz,
    rw finset.mem_image at hz,
    rcases hz with ⟨x, hx, hz⟩,
    rw ← hz,
    exact (classical.some_spec (hv3 x)).1 },
  split,
  { constructor,
    apply set.fintype_of_finset (finset.image (λ (x : {x // x ∈ finsupp.support v}), classical.some (hv3 x))
      (finset.attach (finsupp.support v))),
    intro z, simp },
  { admit }
end

-- the above was Kenny's effort. It seems easier to just try this myself than to understand
-- what he wrote.

-- this next lemma will go to mathlib one day
lemma mem_subset_basis_of_mem_open {X : Type u} [T : topological_space X] {b : set (set X)}
  (hb : topological_space.is_topological_basis b) {a:X} (u : set X) (au : a ∈ u)
  (ou : _root_.is_open u) : ∃v ∈ b, a ∈ v ∧ v ⊆ u :=
(topological_space.mem_nhds_of_is_topological_basis hb).1 $ mem_nhds_sets ou au


-- this was warm-up : I never use it
/-
lemma cover_open_by_basis {X : Type u} [T : topological_space X] {U : set X} (HU : T.is_open U)
(B : set (set X)) (HB : topological_space.is_topological_basis B) 
  : ∃ (g : {x : X // U x} → set X), (∀ j, B (g j)) ∧ set.Union g = U :=
begin
  existsi λ (xUx : {x : X // U x}), classical.some (mem_subset_basis_of_mem_open HB U xUx.property HU),
  split,
  { intro xUx,
    exact classical.some (classical.some_spec (mem_subset_basis_of_mem_open HB U xUx.property HU)),
  },
  apply set.subset.antisymm,
  { intros x Hx, 
    cases Hx with V HV,
    cases HV with HV Hx,
    cases HV with xUx HV,
    have H := classical.some_spec (classical.some_spec (mem_subset_basis_of_mem_open HB U xUx.property HU)),
    have H2 := H.2,
    rw (eq.symm HV : classical.some (mem_subset_basis_of_mem_open HB U (xUx.property) HU) = V) at H2,
    exact H2 Hx,
  },
  intros x Hx,
  let xUx : { x // U x} := ⟨x,Hx⟩,
  existsi classical.some (mem_subset_basis_of_mem_open HB U (xUx.property) HU),
  existsi _,
  { exact (classical.some_spec (classical.some_spec (mem_subset_basis_of_mem_open HB U (xUx.property) HU))).1,
  },
  existsi xUx,
  refl
end 
-/

-- a cover can be refined to a cover by a basis
lemma refine_cover_with_basis {X : Type u} [T : topological_space X] 
  (B : set (set X)) (HB : topological_space.is_topological_basis B) 
  (c : set (set X)) (Oc : ∀ U ∈ c, T.is_open U) (Hcov : set.sUnion c = set.univ) :
∃ (d : set (set X)), d ⊆ B ∧ (∀ V ∈ d, ∃ U ∈ c, V ⊆ U) ∧ set.sUnion d = set.univ :=
begin
  existsi λ V, V ∈ B ∧ ∃ U ∈ c, V ⊆ U,
  split,intros V HV,exact HV.1,
  split,intros V HV,exact HV.2,
  apply set.subset.antisymm,simp,
  intros x Hx,
  rw ←Hcov at Hx,
  cases Hx with U HU,
  cases HU with HU Hx,
  cases (mem_subset_basis_of_mem_open HB U Hx (Oc U HU)) with V HV,
  cases HV with HV1 HV2,
  existsi V,
  existsi _,exact HV2.1,
  split,exact HV1,
  existsi U,
  existsi HU,
  exact HV2.2
end 

-- a cover by basis elements has a finite subcover
lemma basis_quasi_compact {R : Type u} [comm_ring R] :
∀ F : set R, @set.univ (X R) = set.Union (λ fF : {f // f ∈ F}, Spec.D' fF.val) →
∃ G : set R, G ⊆ F ∧ set.finite G ∧ 
  @set.univ (X R) = set.Union (λ gG : {g // g ∈ G}, Spec.D' gG.val) :=
begin
  intros F Hcover,
  -- first let's show that the union of D(f), f in F, is all Spec(R)
  have H : @set.univ (X R) = ⋃₀(Spec.D' '' F),
    rw Hcover,
    apply set.ext,
    intro x,simp,
  -- now let's deduce that V(F) is empty.
  rw tag00E0.lemma16 at H,
  have H2 : Spec.V F = ∅,
    rw [←set.compl_compl (Spec.V F),←H,set.compl_univ],
  -- now let's deduce that the ideal gen by F is all of R.
  rw ←tag00E0.lemma05 at H2,
  letI : is_ideal (span F) := is_ideal_span,
  have H3 : span F = set.univ := (tag00E0.lemma08 _ _).1 H2,
  -- now let's write 1 as a finite linear combination of elements of F
  have H4 : (1 : R) ∈ span F := by simp [H3],
  cases H4 with f Hf, -- f is a function R -> R supported on a finite subset of F
  -- now let's build G, finite, with 1 in span G, and then let's run the entire argument backwards.
  let G : set R := {r | r ∈ f.support},
  existsi G, -- need to prove G in F, G finite, and D(g) covers for g in G
  split,
  { show G ⊆ F,
    intros g Hg,
    cases classical.em (g ∈ F) with H5 H5,assumption,
    exfalso,
    have H6 : f g = 0 := Hf.1 g H5,
    exact (f.mem_support_to_fun g).1 Hg H6
  },
  split,
  { show set.finite G, -- G = f.support which is a finset
    exact set.finite_mem_finset _,
  },
  -- goal now to show that union of D(g) is Spec(R)
  -- first reformulate so we can apply lemma16
  suffices H' : @set.univ (X R) = ⋃₀(Spec.D' '' G),
    apply set.ext,simp [H'],
  -- now reduce goal to complement of V(G) is everything
  rw tag00E0.lemma16,
  -- now reduce to V(G) empty
  rw ←set.compl_empty,
  congr,
  -- now reduce to span(G) = R
  rw ←tag00E0.lemma05,
  apply eq.symm,
  letI : is_ideal (span G) := is_ideal_span,
  rw tag00E0.lemma08,
  -- now reduce to 1 in span(G)
  apply is_submodule.univ_of_one_mem (span G),
  -- now prove this
  rw Hf.2,
  existsi f,
  split,swap,refl,
  intros x Hx,
  cases classical.em (f x = 0) with H4 H4,assumption,
  exfalso,
  exact Hx ((f.mem_support_to_fun x).2 H4),
end

-- now deduce main result from compact basis result
lemma lemma_quasi_compact {R : Type u} [comm_ring R] : compact (@set.univ (X R)) :=
begin
  rw compact_iff_finite_subcover,
  intros c HOc Hccov,
  let B := {U : set (X R) | ∃ (f : R), U = Spec.D' f},
  have HB : topological_space.is_topological_basis B := D_f_form_basis R,
  cases (refine_cover_with_basis B HB c HOc (set.subset.antisymm (by simp) Hccov)) with d Hd,
  have HdB : ∀ V ∈ d, ∃ f : R, V = Spec.D' f := λ _ HV,Hd.1 HV,
  have H := basis_quasi_compact (λ f, (Spec.D' f) ∈ d),
  have Hdcov : (⋃ (fHf : {f // Spec.D' f ∈ d}), Spec.D' (fHf.val)) = set.univ,
  { apply set.subset.antisymm,simp,
    rw ←Hd.2.2,
    intros x Hx,cases Hx with V HV,cases HV with HVd HxV,
    existsi V,
    existsi _,
    exact HxV,
    cases Hd.1 HVd with f Hf,
    rw Hf at HVd,
    existsi (⟨f,HVd⟩ : {f // Spec.D' f ∈ d}),
    exact Hf
  },
  cases H (eq.symm Hdcov) with G HG,
  let m : {g // g ∈ G} → set (X R) := λ gG,classical.some (Hd.2.1 (Spec.D' gG.val) (HG.1 gG.property)),
  have mH : ∀ (gG : {g // g ∈ G}), ∃ (H : (m gG) ∈ c), Spec.D' (gG.val) ⊆ (m gG)
      := λ (gG : {g // g ∈ G}), classical.some_spec (Hd.2.1 (Spec.D' gG.val) (HG.1 gG.property)),
  existsi set.range m,
  existsi _,split,
  { have HGfin : set.finite G := HG.2.1,
    exact let ⟨HF⟩ := HGfin in ⟨@set.fintype_range _ _ _ m HF⟩,
  },
  { rw HG.2.2,
    intros x Hx,
    cases Hx with U HU,cases HU with HU HxU,cases HU with gG HU,
    change U = Spec.D' (gG.val)  at HU,
    cases mH gG with H1 H2,
    existsi m gG,
    existsi _,
    { apply H2,
      rw ←HU,
      exact HxU },
    existsi gG,refl
  },
  intros U HU,cases HU with gG HU,
  cases (mH gG) with Hc,
  rw HU at Hc,exact Hc,
end
