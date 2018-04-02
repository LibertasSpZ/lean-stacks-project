import algebra.ring algebra.module linear_algebra data.set.basic tactic.ring data.equiv data.quot Kenny_comm_alg.temp

-- remove "data.equiv" in PR version
-- ring.localization

universes u v

-- <migrations>
-- <move to algebra.group>

/-
class is_submonoid (α : Type u) [monoid α] (S : set α) : Prop :=
(one_mem : (1:α) ∈ S)
(mul_mem : ∀ {s t}, s ∈ S → t ∈ S → s*t ∈ S)
-/
-- </move>

-- <move to algebra.group_power>

local infix ^ := monoid.pow

/-
def powers {α : Type u} [monoid α] (x : α) : set α := {y | ∃ n, x^n = y}
-/
/-
instance powers.is_submonoid {α : Type u} [monoid α] (x : α)  : is_submonoid α (powers x) :=
{ one_mem := ⟨0, by simp⟩,
  mul_mem := λ x₁ x₂ ⟨n₁, hn₁⟩ ⟨n₂, hn₂⟩, ⟨n₁ + n₂, by simp [pow_add, *]⟩ }
-/
-- </move>

-- <move to algebra.ring>

-- (moved to temp)

-- </move>

-- <move to ring_theory.ideals>

-- </move>

-- <move to data.quot>

-- (moved to temp)

-- </move>
-- </migrations>

namespace localization

variables (α : Type u) [comm_ring α] (S : set α) [is_submonoid α S]

def r : α × S → α × S → Prop :=
λ x y, ∃ t ∈ S, (x.2.1 * y.1 - y.2.1 * x.1) * t = 0

local infix ≈ := r α S

theorem refl : ∀ (x : α × S), x ≈ x :=
λ ⟨r₁, s₁, hs₁⟩, ⟨1, is_submonoid.one_mem S, by simp⟩

theorem symm : ∀ (x y : α × S), x ≈ y → y ≈ x :=
λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨t, hts, ht⟩, ⟨t, hts, calc
        (s₂ * r₁ - s₁ * r₂) * t
      = -((s₁ * r₂ - s₂ * r₁) * t) : by simp [add_mul]
  ... = 0 : by rw ht; simp⟩

theorem trans : ∀ (x y z : α × S), x ≈ y → y ≈ z → x ≈ z :=
λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨r₃, s₃, hs₃⟩ ⟨t, hts, ht⟩ ⟨t', hts', ht'⟩,
⟨s₂ * t' * t, is_submonoid.mul_mem (is_submonoid.mul_mem hs₂ hts') hts, calc
         (s₁ * r₃ - s₃ * r₁) * (s₂ * t' * t)
       = t' * s₃ * ((s₁ * r₂ - s₂ * r₁) * t) + t * s₁ * ((s₂ * r₃ - s₃ * r₂) * t') :
           by simp [mul_left_comm, mul_add, mul_comm]
   ... = 0 : by rw [ht, ht']; simp⟩

instance : setoid (α × S) :=
⟨r α S, refl α S, symm α S, trans α S⟩

def loc := quotient $ localization.setoid α S

private def add_aux : α × S → α × S → loc α S :=
λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩, ⟦⟨s₁ * r₂ + s₂ * r₁, s₁ * s₂, is_submonoid.mul_mem hs₁ hs₂⟩⟧

instance : has_add (loc α S) :=
⟨quotient.lift₂ (add_aux α S) $
 λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨r₃, s₃, hs₃⟩ ⟨r₄, s₄, hs₄⟩ ⟨t₅, hts₅, ht₅⟩ ⟨t₆, hts₆, ht₆⟩,
 quotient.sound ⟨t₆ * t₅, is_submonoid.mul_mem hts₆ hts₅, calc
         (s₁ * s₂ * (s₃ * r₄ + s₄ * r₃) - s₃ * s₄ * (s₁ * r₂ + s₂ * r₁)) * (t₆ * t₅)
       = s₁ * s₃ * ((s₂ * r₄ - s₄ * r₂) * t₆) * t₅ + s₂ * s₄ * ((s₁ * r₃ - s₃ * r₁) * t₅) * t₆ : by ring
   ... = 0 : by rw [ht₆, ht₅]; simp⟩⟩

private def neg_aux : α × S → loc α S :=
λ ⟨r, s, hs⟩, ⟦⟨-r, s, hs⟩⟧

instance : has_neg (loc α S) :=
⟨quotient.lift (neg_aux α S) $
 λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨t, hts, ht⟩,
 quotient.sound ⟨t, hts, calc
         (s₁ * -r₂ - s₂ * -r₁) * t
       = -((s₁ * r₂ - s₂ * r₁) * t) : by ring
   ... = 0 : by rw ht; simp⟩⟩

private def mul_aux : α × S → α × S → loc α S :=
λ x y, ⟦⟨x.1 * y.1, x.2.1 * y.2.1, is_submonoid.mul_mem x.2.2 y.2.2⟩⟧

instance : has_mul (loc α S) :=
⟨quotient.lift₂ (mul_aux α S) $
 λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨r₃, s₃, hs₃⟩ ⟨r₄, s₄, hs₄⟩ ⟨t₅, hts₅, ht₅⟩ ⟨t₆, hts₆, ht₆⟩,
 quotient.sound ⟨t₆ * t₅, is_submonoid.mul_mem hts₆ hts₅, calc
         ((s₁ * s₂) * (r₃ * r₄) - (s₃ * s₄) * (r₁ * r₂)) * (t₆ * t₅)
       = t₆ * ((s₁ * r₃ - s₃ * r₁) * t₅) * r₂ * s₄ + t₅ * ((s₂ * r₄ - s₄ * r₂) * t₆) * r₃ * s₁ : by simp [mul_left_comm, mul_add, mul_comm]
   ... = 0 : by rw [ht₅, ht₆]; simp⟩⟩

instance : comm_ring (loc α S) :=
by refine
{ add            := has_add.add,
  add_assoc      := λ m n k, quotient.induction_on₃ m n k _,
  zero           := ⟦⟨0, 1, is_submonoid.one_mem S⟩⟧,
  zero_add       := quotient.ind _,
  add_zero       := quotient.ind _,
  neg            := has_neg.neg,
  add_left_neg   := quotient.ind _,
  add_comm       := quotient.ind₂ _,
  mul            := has_mul.mul,
  mul_assoc      := λ m n k, quotient.induction_on₃ m n k _,
  one            := ⟦⟨1, 1, is_submonoid.one_mem S⟩⟧,
  one_mul        := quotient.ind _,
  mul_one        := quotient.ind _,
  left_distrib   := λ m n k, quotient.induction_on₃ m n k _,
  right_distrib  := λ m n k, quotient.induction_on₃ m n k _,
  mul_comm       := quotient.ind₂ _ };
{ intros,
  try {cases a with r₁ s₁, cases s₁ with s₁ hs₁},
  try {cases b with r₂ s₂, cases s₂ with s₂ hs₂},
  try {cases c with r₃ s₃, cases s₃ with s₃ hs₃},
  apply quotient.sound,
  existsi (1:α),
  existsi is_submonoid.one_mem S,
  simp [mul_left_comm, mul_add, mul_comm] }

def of_comm_ring : α → loc α S :=
λ r, ⟦⟨r, 1, is_submonoid.one_mem S⟩⟧

instance : is_ring_hom (of_comm_ring α S) :=
{ map_add := λ x y, quotient.sound $ by simp,
  map_mul := λ x y, quotient.sound $ by simp,
  map_one := rfl }

theorem mul_denom (r s : α) (hs : s ∈ S) : @@has_mul.mul (localization.has_mul α S) (⟦⟨r, s, hs⟩⟧ : loc α S) (of_comm_ring α S s) = of_comm_ring α S r :=
quotient.sound $ ⟨1, is_submonoid.one_mem S, by simp [mul_comm]⟩

theorem mul_inv_denom (r s : α) (hs : s ∈ S) : @@has_mul.mul (localization.has_mul α S) (of_comm_ring α S r) (⟦⟨1, s, hs⟩⟧ : loc α S) = (⟦⟨r, s, hs⟩⟧ : loc α S) :=
quotient.sound $ ⟨1, is_submonoid.one_mem S, by simp⟩

section simp_lemmas

variables (f f₁ f₂ : α × S)

def mk : loc α S := ⟦f₁⟧
lemma mk_eq : ⟦f₁⟧ = mk α S f₁ := rfl
@[simp] lemma add_frac : mk α S f₁ + mk α S f₂ =
  mk α S ⟨f₁.2.1 * f₂.1 + f₂.2.1 * f₁.1, f₁.2.1 * f₂.2.1,
    is_submonoid.mul_mem f₁.2.2 f₂.2.2⟩ :=
by cases f₁; cases f₂; cases f₁_snd; cases f₂_snd; refl
@[simp] lemma neg_frac : -mk α S f =
  mk α S ⟨-f.1, f.2⟩ :=
by cases f; cases f_snd; refl
@[simp] lemma sub_frac : mk α S f₁ - mk α S f₂ =
  mk α S ⟨f₂.2.1 * f₁.1 - f₁.2.1 * f₂.1, f₁.2.1 * f₂.2.1,
    is_submonoid.mul_mem f₁.2.2 f₂.2.2⟩ :=
by simp; refl
@[simp] lemma mul_frac : mk α S f₁ * mk α S f₂ =
  mk α S ⟨f₁.1 * f₂.1, f₁.2.1 * f₂.2.1,
    is_submonoid.mul_mem f₁.2.2 f₂.2.2⟩ :=
by cases f₁; cases f₂; cases f₁_snd; cases f₂_snd; refl
lemma one_frac : 1 = mk α S ⟨1, 1, is_submonoid.one_mem S⟩ := rfl
lemma zero_frac : 0 = mk α S ⟨0, 1, is_submonoid.one_mem S⟩ := rfl

@[simp] lemma quotient.lift_beta {β : Sort v} (f : α × S → β) (h : ∀ a b, a ≈ b → f a = f b) (x : α × S) :
quotient.lift f h (mk α S x) = f x := rfl

@[simp] lemma quotient.lift_on_beta {β : Sort v} (f : α × S → β) (h : ∀ a b, a ≈ b → f a = f b) (x : α × S) :
quotient.lift_on (mk α S x) f h = f x := rfl

@[simp] lemma div_self {y : α} {H : y ∈ S} : mk α S (y, ⟨y, H⟩) = 1 :=
quotient.sound ⟨1, is_submonoid.one_mem S, by simp⟩

end simp_lemmas

local infix ^ := monoid.pow

variable {α}

def away (x : α) := loc α (powers x)

instance away.comm_ring (x : α) : comm_ring (away x) :=
localization.comm_ring α (powers x)

section at_prime

variables (P : set α) [is_prime_ideal P]

instance prime.is_submonoid :
  is_submonoid α (set.compl P) :=
{ one_mem := λ h, is_proper_ideal.ne_univ P $
    is_submodule.univ_of_one_mem P h,
  mul_mem := λ x y hnx hny hxy, or.cases_on
    (is_prime_ideal.mem_or_mem_of_mul_mem hxy) hnx hny }

def at_prime := loc α (set.compl P)

instance at_prime.comm_ring : comm_ring (at_prime P) :=
localization.comm_ring α (set.compl P)

instance at_prime.local_ring : local_ring (at_prime P) :=
local_of_nonunits_ideal
  (λ hze, have _, from quotient.exact hze, let ⟨t, hts, ht⟩ := this in
     hts $ have htz : t = 0, by simpa using ht,
       suffices (0:α) ∈ P, by rwa htz,
       @is_submodule.zero _ _ _ _ P _)
  (λ x y hx hy ⟨z, hz⟩,
     let ⟨⟨r₁, s₁, hs₁⟩, hrs₁⟩ := quotient.exists_rep x,
         ⟨⟨r₂, s₂, hs₂⟩, hrs₂⟩ := quotient.exists_rep y,
         ⟨⟨r₃, s₃, hs₃⟩, hrs₃⟩ := quotient.exists_rep z in
     have _, by rw [← hrs₁, ← hrs₂, ← hrs₃] at hz; from quotient.exact hz,
     let ⟨t, hts, ht⟩ := this in
     have hr₁ : r₁ ∈ P, from classical.by_contradiction $
     λ hnr₁, hx ⟨⟦⟨s₁, r₁, hnr₁⟩⟧, by rw ←hrs₁;
       from quotient.sound ⟨1, is_submonoid.one_mem _, by simp [mul_comm]⟩⟩,
     have hr₂ : r₂ ∈ P, from classical.by_contradiction $
     λ hnr₂, hy ⟨⟦⟨s₂, r₂, hnr₂⟩⟧, by rw ←hrs₂;
       from quotient.sound ⟨1, is_submonoid.one_mem _, by simp [mul_comm]⟩⟩,
     have hr₃ : _ , from or.resolve_right
     (mem_or_mem_of_mul_eq_zero P ht) hts,
     have h : s₃ * (s₁ * s₂) - r₃ * (s₁ * r₂ + s₂ * r₁) ∈ P,
     by simpa using hr₃,
     have h1 : r₃ * (s₁ * r₂ + s₂ * r₁) ∈ P,
     from is_submodule.smul r₃ $ is_submodule.add
         (is_submodule.smul s₁ hr₂)
         (is_submodule.smul s₂ hr₁),
     have h2 : s₃ * (s₁ * s₂) ∈ P,
     from calc s₃ * (s₁ * s₂)
           = s₃ * (s₁ * s₂) - r₃ * (s₁ * r₂ + s₂ * r₁) + r₃ * (s₁ * r₂ + s₂ * r₁) : eq.symm $ sub_add_cancel _ _
       ... ∈ P : is_submodule.add h h1,
     have h3 : s₁ * s₂ ∈ P, from or.resolve_left
     (is_prime_ideal.mem_or_mem_of_mul_mem h2) hs₃,
     or.cases_on (is_prime_ideal.mem_or_mem_of_mul_mem h3) hs₁ hs₂)

end at_prime

def closure (S : set α) : set α := {y | ∃ (L:list α) (H:∀ x ∈ L, x ∈ S), L.prod = y }

instance closure.is_submonoid (S : set α) : is_submonoid α (closure S) :=
{ one_mem := ⟨[], by simp⟩,
  mul_mem := λ x₁ x₂ ⟨L₁, hLS₁, hL₁⟩ ⟨L₂, hLS₂, hL₂⟩,
    ⟨L₁ ++ L₂,
     λ x hx, or.cases_on (list.mem_append.1 hx) (hLS₁ x) (hLS₂ x),
     by simp [list.prod_append, *]⟩ }

variable α

def non_zero_divisors : set α := {x | ∀ z, z * x = 0 → z = 0}

instance non_zero_divisors.is_submonoid : is_submonoid α (non_zero_divisors α) :=
{ one_mem := λ z hz, by simpa using hz,
  mul_mem := λ x₁ x₂ hx₁ hx₂ z hz,
    have z * x₁ * x₂ = 0,
    by rwa mul_assoc,
    hx₁ z $ hx₂ (z * x₁) this }

def quotient_ring := loc α (non_zero_divisors α)

instance quotient_ring.comm_ring : comm_ring (quotient_ring α) :=
localization.comm_ring α (non_zero_divisors α)

section quotient_ring

variables {β : Type u} [integral_domain β] [decidable_eq β]

lemma ne_zero_of_mem_non_zero_divisors {x : β} :
  x ∈ localization.non_zero_divisors β → x ≠ 0 :=
λ hm hz, have 1 * x = 0, by simp [hz], zero_ne_one (hm 1 this).symm

lemma eq_zero_of_ne_zero_of_mul_eq_zero {x y : β} :
  x ≠ 0 → y * x = 0 → y = 0 :=
λ hnx hxy, or.resolve_right (eq_zero_or_eq_zero_of_mul_eq_zero hxy) hnx

lemma mem_non_zero_divisors_of_ne_zero {x : β} :
  x ≠ 0 → x ∈ localization.non_zero_divisors β :=
λ hnx z, eq_zero_of_ne_zero_of_mul_eq_zero hnx

variable β

private def inv_aux : β × (non_zero_divisors β) → quotient_ring β :=
λ ⟨r, s, hs⟩, if h : r = 0 then
  ⟦⟨0, 1, is_submonoid.one_mem _⟩⟧
else ⟦⟨s, r, mem_non_zero_divisors_of_ne_zero h⟩⟧

instance : has_inv (quotient_ring β) :=
⟨quotient.lift (inv_aux β) $
 λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨t, hts, ht⟩,
 begin
   have hrs : s₁ * r₂ - s₂ * r₁ = 0,
   { from hts _ ht },
   by_cases hr₁ : r₁ = 0;
   by_cases hr₂ : r₂ = 0;
   simp [inv_aux, hr₁, hr₂],
   { exfalso,
     simp [hr₁] at hrs,
     exact ne_zero_of_mem_non_zero_divisors hs₁
       (eq_zero_of_ne_zero_of_mul_eq_zero hr₂ hrs) },
   { exfalso,
     simp [hr₂] at hrs,
     exact ne_zero_of_mem_non_zero_divisors hs₂
       (eq_zero_of_ne_zero_of_mul_eq_zero hr₁ hrs) },
   { exact ⟨1, is_submonoid.one_mem _,
     by simpa [mul_comm] using congr_arg (λ x, -x) hrs⟩ }
 end⟩

-- This cannot be an instance, or we create a loop between field and integral domain.
definition quotient_ring.field.of_integral_domain : field (quotient_ring β) :=
by refine
{ inv := has_inv.inv,
  zero_ne_one := λ hzo, let ⟨t, hts, ht⟩ := quotient.exact hzo in
    zero_ne_one (by simpa using hts _ ht : 0 = 1),
  mul_inv_cancel := quotient.ind _,
  inv_mul_cancel := quotient.ind _,
  ..localization.comm_ring β _ };
{ intros x hnx,
  cases x with x hx,
  cases hx with z hz,
  have : x ≠ 0,
    intro hx,
    apply hnx,
    apply quotient.sound,
    existsi (1:β),
    existsi is_submonoid.one_mem _,
    simp [hx],
    exact non_zero_divisors.is_submonoid β,
  simp [has_inv.inv, inv_aux, inv_aux._match_1],
  rw dif_neg this,
  apply quotient.sound,
  existsi (1:β),
  existsi is_submonoid.one_mem _,
  dsimp,
  ring,
  exact non_zero_divisors.is_submonoid β }

end quotient_ring

end localization

-- Factoids (not to go to mathlib):

instance : add_comm_group int := ring.to_add_comm_group int
instance : add_group int := by apply_instance

def frac_int_to_rat : localization.quotient_ring ℤ → ℚ :=
λ f, quotient.lift_on f (λ ⟨r, s, hs⟩, rat.mk r s) $
λ ⟨r₁, s₁, hs₁⟩ ⟨r₂, s₂, hs₂⟩ ⟨t, hts, ht⟩,
have hsnz₁ : s₁ ≠ 0,
from localization.ne_zero_of_mem_non_zero_divisors hs₁,
have hsnz₂ : s₂ ≠ 0,
from localization.ne_zero_of_mem_non_zero_divisors hs₂,
have htnz : t ≠ 0,
from localization.ne_zero_of_mem_non_zero_divisors hts,
begin
  cases eq_zero_or_eq_zero_of_mul_eq_zero ht with hrs htz,
  { change rat.mk r₁ s₁ = rat.mk r₂ s₂,
    rw sub_eq_zero at hrs,
    rw rat.mk_eq hsnz₁ hsnz₂,
    simp only [mul_comm, hrs] },
  {  exfalso,
     exact htnz htz }
end

lemma coe_denom_ne_zero (r : ℚ) : (↑r.denom:ℤ) ≠ 0 :=
λ hn, ne_of_gt r.pos $ int.of_nat_inj hn

def frac_int_of_rat : ℚ → localization.quotient_ring ℤ :=
λ r, ⟦⟨r.num, r.denom, λ z hz,
or.cases_on (eq_zero_or_eq_zero_of_mul_eq_zero hz) id
  (λ hz, false.elim $ coe_denom_ne_zero r hz)⟩⟧

theorem frac_int_to_rat_to_frac_int : ∀ f, frac_int_of_rat (frac_int_to_rat f) = f :=
λ f, quotient.induction_on f $ λ ⟨r, s, hs⟩, quotient.sound
⟨1, is_submonoid.one_mem _,
   suffices r * ↑(rat.mk r s).denom = (rat.mk r s).num * s,
   from show (↑(rat.mk r s).denom * r - s * (rat.mk r s).num) * 1 = 0,
     by simp [mul_comm, this],
   have hnd : (↑(rat.mk r s).denom:ℤ) ≠ 0,
     from coe_denom_ne_zero $ rat.mk r s,
   have hns : s ≠ 0,
     from localization.ne_zero_of_mem_non_zero_divisors hs,
   have _, from rat.num_denom $ rat.mk r s,
   by rwa ← rat.mk_eq hns hnd ⟩

theorem rat_to_frac_int_to_rat : ∀ r, frac_int_to_rat (frac_int_of_rat r) = r :=
λ ⟨n, d, h, c⟩, eq.symm $ rat.num_denom _

def canonical : equiv (localization.quotient_ring ℤ) (ℚ) :=
⟨frac_int_to_rat, frac_int_of_rat,
   frac_int_to_rat_to_frac_int,
   rat_to_frac_int_to_rat⟩

def dyadic_rat := localization.away (2:ℤ)
