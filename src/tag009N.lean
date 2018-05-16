/-
\begin{lemma}
\label{lemma-extend-off-basis}
Let $X$ be a topological space.
Let $\mathcal{B}$ be a basis for the topology on $X$.
Let $\mathcal{F}$ be a sheaf of sets on $\mathcal{B}$.
There exists a unique sheaf of sets $\mathcal{F}^{ext}$
on $X$ such that $\mathcal{F}^{ext}(U) = \mathcal{F}(U)$
for all $U \in \mathcal{B}$ compatibly with the restriction
mappings.
\end{lemma}

\begin{proof}
We first construct a presheaf $\mathcal{F}^{ext}$ with the
desired property. Namely, for an arbitrary open $U \subset X$ we
define $\mathcal{F}^{ext}(U)$ as the set of elements
$(s_x)_{x \in U}$ such that $(*)$ of
Lemma \ref{lemma-condition-star-sections} holds.
It is clear that there are restriction mappings
that turn $\mathcal{F}^{ext}$ into a presheaf of sets.
Also, by Lemma \ref{lemma-condition-star-sections} we
see that $\mathcal{F}(U) = \mathcal{F}^{ext}(U)$
whenever $U$ is an element of the basis $\mathcal{B}$.
To see $\mathcal{F}^{ext}$ is a sheaf one may
argue as in the proof of Lemma \ref{lemma-sheafification-sheaf}.
\end{proof}
-/

-- sheaf on a basis = sheaf on the whole space

import analysis.topology.topological_space tag009J tag009H tag006E tag006T 
universe u

theorem basis_element_is_open {X : Type u} [T : topological_space X]
 {B : set (set X)} (HB : topological_space.is_topological_basis B)
 {U : set X} (BU : B U) : T.is_open U := 
 begin
 have : T = topological_space.generate_from B := HB.2.2,
 rw this,
show topological_space.generate_open B U,
refine topological_space.generate_open.basic U BU,
end 

 definition restriction_of_presheaf_to_basis {X : Type u} [T : topological_space X]
 {B : set (set X)} {HB : topological_space.is_topological_basis B}
 (FP : presheaf_of_types X) : presheaf_of_types_on_basis HB :=
 { F := λ U BU, FP.F (basis_element_is_open HB BU),
   res := λ {U V} BU BV H, FP.res U V (basis_element_is_open HB BU) (basis_element_is_open HB BV) H,
   Hid := λ U BU, FP.Hid U (basis_element_is_open HB BU),
   Hcomp := λ U V W BU BV BW,FP.Hcomp U V W (basis_element_is_open HB BU)
   (basis_element_is_open HB BV) (basis_element_is_open HB BW)
 }

definition extend_off_basis {X : Type u} [T : topological_space X] {B : set (set X)} 
  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
  (HF : is_sheaf_of_types_on_basis FB)
  : presheaf_of_types X := 
  { F := λ U OU, { s : Π (x ∈ U), presheaf_on_basis_stalk FB x //
      -- s is locally a section -- condition (*) of tag 009M
      ∀ (x ∈ U), ∃ (V : set X) ( BV : V ∈ B) (Hx : x ∈ V) (sigma : FB.F BV), 
        ∀ (y ∈ U ∩ V), s y = λ _,⟦{U := V, BU := BV, Hx := H.2, s := sigma}⟧  
    },
    res := λ U W OU OW HWU ssub,⟨λ x HxW,(ssub.val x $ HWU HxW),
      λ x HxW,begin
        cases (ssub.property x (HWU HxW)) with V HV,
        cases HV with BV H2,
        cases H2 with HxV H3,
        cases H3 with sigma H4,
        existsi V, existsi BV, existsi HxV,existsi sigma,
        intros y Hy,
        rw (H4 y ⟨HWU Hy.1,Hy.2⟩)
      end⟩,
    Hid := λ U OU,funext (λ x,subtype.eq rfl),
    Hcomp := λ U V W OU OV OW HUV HVW,funext (λ x, subtype.eq rfl)
  }

--  #print subtype.mk_eq_mk -- this is a simp lemma so why can't
-- I use simp?

--variables {X : Type*} [T : topological_space X] {B : set (set X)} 
--  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
--  (HF : is_sheaf_of_types_on_basis FB)

--set_option pp.notation false 
-- set_option pp.proofs true 

theorem extension_is_sheaf {X : Type u} [T : topological_space X] {B : set (set X)} 
  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
  (HF : is_sheaf_of_types_on_basis FB)
  : is_sheaf_of_types (extend_off_basis FB HF) := begin
  intros U OU γ Ui UiO Hcov,
  split,
  { intros b c Hbc,
    apply subtype.eq,
    apply funext,
    intro x,
    apply funext,
    intro HxU,
    rw ←Hcov at HxU,
    cases HxU with Uig HUig,
    cases HUig with H2 HUigx,
    cases H2 with g Hg,
    rw Hg at HUigx,
    -- Hbc is the assumption that b and c are locally equal.
    have Hig := congr_fun (subtype.mk_eq_mk.1 Hbc) g,
    have H := congr_fun (subtype.mk_eq_mk.1 Hig) x,
    --exact (congr_fun H HUigx),
    have H2 := congr_fun H HUigx,
    exact H2,
  },
  { intro s,
    existsi _,swap,
    { refine ⟨_,_⟩,
      { intros x HxU,
        rw ←Hcov at HxU,
        cases (classical.indefinite_description _ HxU) with Uig HUig,
        cases (classical.indefinite_description _ HUig) with H2 HUigx,
        cases (classical.indefinite_description _ H2) with g Hg,
        rw Hg at HUigx,
        have t := (s.val g),
        exact t.val x HUigx,
      },
      intros x HxU,
      rw ←Hcov at HxU,
      cases HxU with Uig HUig,
      cases HUig with H2 HUigx,
      cases H2 with g Hg,
      rw Hg at HUigx,
      cases (s.val g).property x HUigx with V HV,
      cases HV with BV H2,
      cases H2 with HxV H3,
      -- now replace V by W, in B, contained in V and in Uig, and containing x
      have OUig := UiO g,
      have H := ((topological_space.mem_nhds_of_is_topological_basis HB).1 _ :
        ∃ (W : set X) (H : W ∈ B), x ∈ W ∧ W ⊆ (V ∩ Ui g)),
        swap,
        have UVUig : T.is_open (V ∩ Ui g) := T.is_open_inter V (Ui g) _ OUig,
        have HxVUig : x ∈ V ∩ Ui g := ⟨_,HUigx⟩,
        exact mem_nhds_sets UVUig HxVUig,
        exact HxV,
        rw HB.2.2,
        exact topological_space.generate_open.basic V BV,
      cases H with W HW,
      cases HW with HWB HW,
      existsi W,
      existsi HWB,
      existsi HW.1,
      cases H3 with sigma Hsigma,
      have HWV := (set.subset.trans HW.2 $ set.inter_subset_left _ _),
      existsi FB.res BV HWB HWV sigma,
      intros y Hy,
      -- now apply Hsigma
      have Hy2 : y ∈ V ∩ Ui g := HW.2 Hy.2,
      have Hy3 : y ∈ (Ui g) ∩ V := ⟨Hy2.2,Hy2.1⟩,
      have H := Hsigma y Hy3,
      apply funext,
      intro Hyu,
      dsimp,
      /- goal now
      subtype.rec
      (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), y ∈ Uig),
         subtype.rec
           (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : y ∈ Uig),
              subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val y _)
                (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
           (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), y ∈ Uig) HUig))
      (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), y ∈ t) _) =
    ⟦{U := W, BU := HWB, Hx := _, s := FB.res BV HWB _ sigma}⟧
      -/
      cases (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), y ∈ t) _) with S HS,
      dsimp,
      /- goal now
      subtype.rec
      (λ (H2 : ∃ (i : γ), T = Ui i) (HUigx : y ∈ T),
         subtype.rec (λ (g : γ) (Hg : T = Ui g), (s.val g).val y _)
           (classical.indefinite_description (λ (i : γ), T = Ui i) H2))
      (classical.indefinite_description (λ (H : ∃ (i : γ), T = Ui i), y ∈ T) HT) =
    ⟦{U := W, BU := HWB, Hx := _, s := FB.res BV HWB _ sigma}⟧
      -/
      cases (classical.indefinite_description (λ (H : ∃ (i : γ), S = Ui i), y ∈ S) HS) with Hh HyS2,
      dsimp,
      /-
      subtype.rec (λ (g : γ) (Hg : T = Ui g), (s.val g).val y _)
      (classical.indefinite_description (λ (i : γ), T = Ui i) Hh) =
    ⟦{U := W, BU := HWB, Hx := _, s := FB.res BV HWB _ sigma}⟧-/
      cases (classical.indefinite_description (λ (i : γ), S = Ui i) Hh) with h HSUih,
      dsimp,
      /-
      (s.val h).val y _ = ⟦{U := W, BU := HWB, Hx := _, s := FB.res BV HWB _ sigma}⟧
      -/
      rw HSUih at HyS2,
      revert HyS2,
      intro HyS,
      suffices : (s.val h).val y HyS = (s.val g).val y Hy2.2,
        rw this,
        rw Hsigma y Hy3,
        apply quotient.sound,
        existsi W,
        existsi Hy.2,
        existsi HWB,
        existsi HWV,
        existsi set.subset.refl _,
        suffices this2 : FB.res _ HWB HWV sigma = FB.res _ HWB _ (FB.res BV HWB HWV sigma),
        simpa using this2,
        rw FB.Hid,refl,
      -- what's left here is (s.val h).val y HyT = (s.val g).val y _
      have Hy4 : y ∈ Ui g := Hy3.1,
      show (s.val h).val y HyS = (s.val g).val y Hy4, -- both of type presheaf_on_basis_stalk FB x
      have H2 := s.property g h,
      unfold res_to_inter_left at H2,
      unfold res_to_inter_right at H2,
      have OUigh : T.is_open (Ui g ∩ Ui h) := T.is_open_inter _ _ (UiO g) (UiO h),
      have H3 : (s.val g).val y Hy4 = 
        ((extend_off_basis FB HF).res (Ui g) (Ui g ∩ Ui h) (UiO g) OUigh (set.inter_subset_left _ _) (s.val g)).val y ⟨Hy4,HyS⟩ := rfl,
      have H4 : (s.val h).val y HyS = 
        ((extend_off_basis FB HF).res (Ui h) (Ui g ∩ Ui h) (UiO h) OUigh (set.inter_subset_right _ _) (s.val h)).val y ⟨Hy4,HyS⟩ := rfl,
      rw H3,
      rw H4,
      rw H2,
    },
    {
      dsimp,
      /- goal now
      gluing (extend_off_basis FB HF) U Ui Hcov
      ⟨λ (x : X) (HxU : x ∈ U),
         subtype.rec
           (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig),
              subtype.rec
                (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : x ∈ Uig),
                   subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val x _)
                     (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
                (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig) HUig))
           (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) _),
       _⟩ =
    s
    -/
    unfold gluing,

    apply subtype.eq,
    dsimp,
    apply funext,
    intro i,
    apply subtype.eq,
    /- goal now
     ((extend_off_basis FB HF).res U (Ui i) OU _ _
       ⟨λ (x : X) (HxU : x ∈ U),
          subtype.rec
            (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig),
               subtype.rec
                 (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : x ∈ Uig),
                    subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val x _)
                      (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
                 (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig) HUig))
            (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) _),
        _⟩).val =
    (s.val i).val
    -/
    apply funext,
    intro x,
    
    apply funext,
    intro HxUi,
    
    /- goal now
    ((extend_off_basis FB HF).res U (Ui i) OU _ _
       ⟨λ (x : X) (HxU : x ∈ U),
          subtype.rec
            (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig),
               subtype.rec
                 (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : x ∈ Uig),
                    subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val x _)
                      (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
                 (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig) HUig))
            (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) _),
        _⟩).val
      x
      HxUi =
    (s.val i).val x HxUi
    -/
    have HxU : x ∈ U := Hcov ▸ (set.subset_Union Ui i) (HxUi),
    
    let HHH : presheaf_on_basis_stalk FB x := subtype.rec
            (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig),
               subtype.rec
                 (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : x ∈ Uig),
                    subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val x (Hg ▸ HUigx))
                      (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
                 (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig) HUig))
            (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) ⟨Ui i,⟨i,rfl⟩,HxUi⟩),

    suffices : (subtype.rec
            (λ (Uig : set X) (HUig : ∃ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig),
               subtype.rec
                 (λ (H2 : ∃ (i : γ), Uig = Ui i) (HUigx : x ∈ Uig),
                    subtype.rec (λ (g : γ) (Hg : Uig = Ui g), (s.val g).val x (Hg ▸ HUigx))
                      (classical.indefinite_description (λ (i : γ), Uig = Ui i) H2))
                 (classical.indefinite_description (λ (H : ∃ (i : γ), Uig = Ui i), x ∈ Uig) HUig))
            (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) ⟨Ui i,⟨i,rfl⟩,HxUi⟩) 
              : presheaf_on_basis_stalk FB x)
            = (s.val i).val x HxUi,
      rw ←this,
      refl,
    cases (classical.indefinite_description (λ (t : set X), ∃ (H : ∃ (i : γ), t = Ui i), x ∈ t) ⟨Ui i,⟨i,rfl⟩,HxUi⟩) with Uij HUij,
    dsimp,
    cases (classical.indefinite_description (λ (H : ∃ (i : γ), Uij = Ui i), x ∈ Uij) HUij) with H2 HxUij,
    dsimp,
    cases (classical.indefinite_description (λ (i : γ), Uij = Ui i) H2) with j Hj,
    dsimp,
    rw Hj at HxUij,
    -- HxUi : x in Ui i
    -- HxUij : x in Ui j 
    show (s.val j).val x HxUij = (s.val i).val x HxUi,
    have HxUiUj : x ∈ Ui i ∩ Ui j := ⟨HxUi,HxUij⟩,
    have Hs := s.property i j,
    have H3 : (s.val j).val x HxUij = (@res_to_inter_right _ _ (extend_off_basis FB HF) (Ui i) (Ui j) (UiO i) (UiO j) (s.val j)).val x HxUiUj := rfl,
    rw H3,
    rw ←Hs,
    refl,
    }
  }
end 

#exit

definition extend_off_basis_map {X : Type*} [T : topological_space X] {B : set (set X)} 
  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
  (HF : is_sheaf_of_types_on_basis FB) :
  morphism_of_presheaves_of_types_on_basis FB (restriction_of_presheaf_to_basis (extend_off_basis FB HF)) := sorry

theorem extension_extends {X : Type*} [T : topological_space X] {B : set (set X)} 
  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
  (HF : is_sheaf_of_types_on_basis FB) : 
  is_isomorphism_of_presheaves_of_types_on_basis (extend_off_basis_map FB HF) := sorry 

theorem extension_unique {X : Type*} [T : topological_space X] {B : set (set X)} 
  {HB : topological_space.is_topological_basis B} (FB : presheaf_of_types_on_basis HB)
  (HF : is_sheaf_of_types_on_basis FB) (G : presheaf_of_types X)
  (HG : is_sheaf_of_types G) (psi : morphism_of_presheaves_of_types_on_basis FB (restriction_of_presheaf_to_basis G))
  (HI : is_isomorphism_of_presheaves_of_types_on_basis psi) -- we have an extension which agrees with FB on B
  : ∃ rho : morphism_of_presheaves_of_types (extend_off_basis FB HF) G, -- I would happily change the direction of the iso rho
    is_isomorphism_of_presheaves_of_types rho ∧ 
    ∀ (U : set X) (BU : B U), 
      (rho.morphism U (basis_element_is_open HB BU)) ∘ ((extend_off_basis_map FB HF).morphism BU) = (psi.morphism BU) := sorry


