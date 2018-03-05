import analysis.topology.topological_space data.set
import analysis.topology.continuity 
import Kenny_comm_alg.Zariski
import Kenny_comm_alg.temp
import tag00EJ_statement
import localization

universes u v 

structure ring_morphism {α : Type*} {β : Type*} [Ra : comm_ring α] [Rb : comm_ring β] (f : α → β) :=
(f_zero : f 0 = 0)
(f_one : f 1 = 1)
(f_add : ∀ {a₁ a₂ : α}, f (a₁ + a₂) = f a₁ + f a₂)
(f_mul : ∀ {a₁ a₂ : α}, f (a₁ * a₂) = f a₁ * f a₂) 

local attribute [class] topological_space.is_open 

structure presheaf_of_types (α : Type*) [T : topological_space α] := 
(F : Π U : set α, T.is_open U → Type*)
(res : ∀ (U V : set α) (OU : T.is_open U) (OV : T.is_open V) (H : V ⊆ U), 
  (F U OU) → (F V OV))
(Hid : ∀ (U : set α) (OU : T.is_open U), (res U U OU _ (set.subset.refl U)) = id)  
(Hcomp : ∀ (U V W : set α) (OU : T.is_open U) (OV : T.is_open V) (OW : T.is_open W)
  (HUV : V ⊆ U) (HVW : W ⊆ V),
  (res U W OU OW (set.subset.trans HVW HUV)) = (res V W OV _ HVW) ∘ (res U V _ _ HUV) )

structure presheaf_of_rings {α : Type*} [T : topological_space α] 
  FPT : presheaf_of_types α :=
(Fring : ∀ U O, comm_ring (FPT.F U O))
(res_is_ring_morphism : ∀ (U V : set α) (OU : T.is_open U) (OV : T.is_open V) (H : V ⊆ U),
ring_morphism (FPT.res U V OU OV H))

--attribute [class] presheaf_of_rings
--attribute [instance] presheaf_of_rings.Fring
--local attribute [instance] topological_space.is_open_inter

definition presheaf_of_types_pushforward
  {α : Type*} [Tα : topological_space α]
  {β : Type*} [Tβ : topological_space β]
  (f : α → β)
  (fcont: continuous f)
  (FPT : presheaf_of_types α)
  : presheaf_of_types β :=
  { F := λ V OV, FPT.F (f ⁻¹' V) (fcont V OV),
    res := λ V₁ V₂ OV₁ OV₂ H, 
      FPT.res (f ⁻¹' V₁) (f⁻¹' V₂) (fcont V₁ OV₁) (fcont V₂ OV₂) (λ x Hx,H Hx),
    Hid := λ V OV, FPT.Hid (f ⁻¹' V) (fcont V OV),
    Hcomp := λ Uβ Vβ Wβ OUβ OVβ OWβ HUV HVW,
      FPT.Hcomp (f ⁻¹' Uβ)(f ⁻¹' Vβ)(f ⁻¹' Wβ) (fcont Uβ OUβ) (fcont Vβ OVβ) (fcont Wβ OWβ)
      (λ x Hx, HUV Hx) (λ x Hx, HVW Hx)
  }

definition presheaf_of_rings_pushforward
  {α : Type*} [Tα : topological_space α]
  {β : Type*} [Tβ : topological_space β]
  (f : α → β)
  (fcont: continuous f)
  (FPT : presheaf_of_types α)
  (FPR : presheaf_of_rings FPT)
  : presheaf_of_rings (presheaf_of_types_pushforward f fcont FPT) :=
  { Fring := λ U OU,FPR.Fring (f ⁻¹' U) (fcont U OU),
    res_is_ring_morphism := λ U V OU OV H,
      FPR.res_is_ring_morphism (f ⁻¹' U) (f ⁻¹' V) (fcont U OU) (fcont V OV) (λ x Hx, H Hx)
  }

definition presheaf_of_types_pullback_under_open_immersion
  {α : Type*} [Tα : topological_space α]
  (U : set α) (OU : is_open U)
  (FPT : presheaf_of_types α)
  : presheaf_of_types {x : α // U x} := sorry 

definition presheaf_of_rings_pullback_under_open_immersion
  {α : Type*} [Tα : topological_space α]
  (U : set α) (OU : is_open U)
  (FPT : presheaf_of_types α)
  (FPR : presheaf_of_rings (FPT))
  : presheaf_of_rings (presheaf_of_types_pullback_under_open_immersion U OU FPT) := sorry 



structure morphism_of_presheaves_of_types {α : Type*} [Tα : topological_space α] 
(FPT : presheaf_of_types α) (GPT : presheaf_of_types α)
:= 
(morphism : ∀ U : set α, ∀ HU : Tα.is_open U, (FPT.F U HU) → GPT.F U HU)
(commutes : ∀ U V : set α, ∀ HU : Tα.is_open U, ∀ HV : Tα.is_open V, ∀ Hsub : V ⊆ U,
  (GPT.res U V HU HV Hsub) ∘ (morphism U HU) = (morphism V HV) ∘ (FPT.res U V HU HV Hsub))

def composition_of_morphisms_of_presheaves_of_types {α : Type*} [Tα : topological_space α]
  {FPT GPT HPT : presheaf_of_types α} (fg : morphism_of_presheaves_of_types FPT GPT)
  (gh : morphism_of_presheaves_of_types GPT HPT)
: morphism_of_presheaves_of_types FPT HPT :=
  { morphism := λ U HU, gh.morphism U HU ∘ fg.morphism U HU,
    commutes := λ U V HU HV Hsub, begin
    show (HPT.res U V HU HV Hsub ∘ gh.morphism U HU) ∘ fg.morphism U HU =
    gh.morphism V HV ∘ (fg.morphism V HV ∘ FPT.res U V HU HV Hsub),
    rw gh.commutes U V HU HV Hsub,
    rw ←fg.commutes U V HU HV Hsub,
    end
  }

def identity_morphism_of_presheaves_of_types {α : Type*} [Tα : topological_space α]
  (FPT : presheaf_of_types α) : morphism_of_presheaves_of_types FPT FPT :=
  { morphism := λ _ _,id,
    commutes := λ _ _ _ _ _,rfl
  }

def isomorphism_of_presheaves_of_types {α : Type} [Tα : topological_space α]
(FPT : presheaf_of_types α) (GPT : presheaf_of_types α) (fg : morphism_of_presheaves_of_types FPT GPT)
: Prop 
:= ∃ gf : morphism_of_presheaves_of_types GPT FPT, 
  composition_of_morphisms_of_presheaves_of_types fg gf = identity_morphism_of_presheaves_of_types FPT
  ∧ composition_of_morphisms_of_presheaves_of_types gf fg = identity_morphism_of_presheaves_of_types GPT

def res_to_inter_left {α : Type*} [T : topological_space α] 
  (FT : presheaf_of_types α)
  (U V : set α) [OU : T.is_open U] [OV : T.is_open V] 
  : (FT.F U OU) → (FT.F (U ∩ V) (T.is_open_inter U V OU OV)) 
  := FT.res U (U ∩ V) OU (T.is_open_inter U V OU OV) (set.inter_subset_left U V)

def res_to_inter_right {α : Type*} [T : topological_space α]
  (FT : presheaf_of_types α)
  (U V : set α) [OU : T.is_open U] [OV : T.is_open V]
  : (FT.F V OV) → (FT.F (U ∩ V) (T.is_open_inter U V OU OV)) 
  := FT.res V (U ∩ V) OV (T.is_open_inter U V OU OV) (set.inter_subset_right U V)

def gluing {α : Type*} [T : topological_space α] (FP : presheaf_of_types α) 
  (U :  set α)
  [UO : T.is_open U]
  {γ : Type*} (Ui : γ → set α)
  [UiO : ∀ i : γ, T.is_open (Ui i)]
  (Hcov : (⋃ (x : γ), (Ui x)) = U) 
  : (FP.F U UO) → 
    {a : (Π (x : γ), (FP.F (Ui x) (UiO x))) | ∀ (x y : γ), 
      (res_to_inter_left FP (Ui x) (Ui y)) (a x) = 
      (res_to_inter_right FP (Ui x) (Ui y)) (a y)} :=
λ r,⟨λ x,(FP.res U (Ui x) UO (UiO x) (Hcov ▸ set.subset_Union Ui x) r),
  λ x₁ y₁,
  have Hopen : T.is_open ((Ui x₁) ∩ (Ui y₁)) := (T.is_open_inter _ _ (UiO x₁) (UiO y₁)),
show ((FP.res (Ui x₁) ((Ui x₁) ∩ (Ui y₁)) _ Hopen _) ∘ 
      (FP.res U (Ui x₁) _ _ _)) r =
    ((FP.res (Ui y₁) ((Ui x₁) ∩ (Ui y₁)) _ Hopen _) ∘ 
      (FP.res U (Ui y₁) _ _ _)) r,by rw [←presheaf_of_types.Hcomp,←presheaf_of_types.Hcomp]⟩

structure sheaf_of_types (α : Type*) [T : topological_space α] :=
(FPT : presheaf_of_types α)
(Fsheaf : ∀ (U : set α) [OU : T.is_open U] 
          {γ : Type*} (Ui : γ → set α)
          [UiO : ∀ x : γ, T.is_open (Ui x)] 
          (Hcov : (⋃ (x : γ), (Ui x)) = U),
        function.bijective (gluing FPT U Ui Hcov)
)

structure sheaf_of_rings (α : Type*) [T : topological_space α] :=
(FT : sheaf_of_types α)
(Hsheaf : presheaf_of_rings FT.FPT)

--theorem D_f_are_a_basis {R : Type u} [comm_ring R] : ∀ U : set (X R), topological_space.is_open (Zariski R) U → ∃ α : Type v, ∃ f : α → R, U = set.Union (Spec.D' ∘ f) := sorry

--definition structure_sheaf_on_union {R : Type u} [comm_ring R] {α : Type} (f : α → R) := 
--  {x : (Π i : α, localization.loc R (powers $ f i)) // ∀ j k : α, localise_more_left (f j) (f k) (x j) = localise_more_right (f j) (f k) (x k) } 

--#check topological_space.is_open 
--#check @localization.at_prime
-- #check @sheaf_of_rings 


definition canonical_map {R : Type*} [comm_ring R] (g : R) (u : X R) (H : u ∈ Spec.D' g) 
: localization.away g → @localization.at_prime R _ u.val u.property 
:= sorry 

definition structure_presheaf_of_types_on_affine_scheme (R : Type*) [comm_ring R] 
: presheaf_of_types (X R) :=
{ F := λ U HU, { f : Π P : {u : X R // U u}, @localization.at_prime R _ P.val.val P.val.property // 
  ∀ u : X R, U u → ∃ g : R, Π H : u ∈ Spec.D' g, Π H2 : Spec.D' g ⊆ U, ∃ r : localization.away g, ∀ v : {v : X R // Spec.D' g v},
  f ⟨v.val, H2 (v.property)⟩ = canonical_map g v v.property r },
  res := sorry,
  Hid := sorry,
  Hcomp := sorry
}

definition structure_presheaf_of_rings_on_affine_scheme (R : Type*) [comm_ring R] 
: presheaf_of_rings (structure_presheaf_of_types_on_affine_scheme (R))
:= {
    Fring := sorry,
    res_is_ring_morphism := sorry,
}

definition structure_sheaf_of_rings_on_affine_scheme (R : Type*) [comm_ring R] 
: sheaf_of_rings (X R)
:= {
  FT := sorry,
  Hsheaf := sorry
}

structure scheme :=
(α : Type u)
(T :topological_space α)
(O_X : Π U : set α, topological_space.is_open T U → Type*)
(O_X_sheaf_of_rings : sheaf_of_rings α)
(locally_affine : ∃ β : Type v, ∃ cov : β → {U : set α // T.is_open U}, 
  set.Union (λ b, (cov b).val) = set.univ ∧
  ∀ b : β, ∃ R : Type*, ∃ RR : comm_ring R, ∃ fR : (X R) → α, 
    function.injective fR
    ∧ set.image fR set.univ = (cov b).val 
    ∧ ∀ V : set (X R), (Zariski R).is_open V ↔ T.is_open (fR '' V)
    ∧ ∀ VX : set (X R), ∀ VS : set α, 
      (Zariski R).is_open VX → fR '' VX = VS → T.is_open (fR '' VX)
      → ∃ 

n : ℕ,sorry)
-- now back to stuff not stolen from Patrick
/-
universes u v

theorem D_f_are_a_basis {R : Type u} [comm_ring R] : ∀ U : set (X R), topological_space.is_open (Zariski R) U → ∃ α : Type v, ∃ f : α → R, U = set.Union (Spec.D' ∘ f) := sorry

definition structure_sheaf_on_union {R : Type u} [comm_ring R] {α : Type} (f : α → R) := 
  {x : (Π i : α, localization.loc R (powers $ f i)) // ∀ j k : α, localise_more_left (f j) (f k) (x j) = localise_more_right (f j) (f k) (x k) } 

-- a theorem says that this is a subring.

definition structure_sheaf (R : Type u) [comm_ring R] : {U : set (X R) // topological_space.is_open (Zariski R) U} → Type u :=
λ ⟨U,HU⟩, let exf := D_f_are_a_basis U HU in let fH := classical.some_spec exf in structure_sheaf_on_union (classical.some fH)

-- the pair consisting of Spec(R) and its structure sheaf are an affine scheme, although it is currently not even clear
-- from the definition that everything is well-defined (I choose a cover; I still didn't do the work to check that
-- the resulting ring is independent of choices (or even that it is a ring!)

-- Just begun to think about general schemes below.


-/
