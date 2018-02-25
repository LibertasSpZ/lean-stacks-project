
/-
Who knows how much of this we need.

Lemma 10.16.2. Let R be a ring.

    The spectrum of a ring R is empty if and only if R is the zero ring.
    Every nonzero ring has a maximal ideal.
    Every nonzero ring has a minimal prime ideal.
    Given an ideal I⊂R and a prime ideal I⊂𝔭 there exists a prime I⊂𝔮⊂𝔭 such that 𝔮 is minimal over I.
    If T⊂R, and if (T) is the ideal generated by T in R, then V((T))=V(T).
    If I is an ideal and I√ is its radical, see basic notion (27), then V(I)=V(I√).
    Given an ideal I of R we have I√=⋂I⊂𝔭𝔭.
    If I is an ideal then V(I)=∅ if and only if I is the unit ideal.
    If I, J are ideals of R then V(I)∪V(J)=V(I∩J).
    If (Ia)a∈A is a set of ideals of R then ∩a∈AV(Ia)=V(∪a∈AIa).
    If f∈R, then D(f)⨿V(f)=Spec(R).
    If f∈R then D(f)=∅ if and only if f is nilpotent.
    If f=uf′ for some unit u∈R, then D(f)=D(f′).
    If I⊂R is an ideal, and 𝔭 is a prime of R with 𝔭∉V(I), then there exists an f∈R such that 𝔭∈D(f), and D(f)∩V(I)=∅.
    If f,g∈R, then D(fg)=D(f)∩D(g).
    If fi∈R for i∈I, then ⋃i∈ID(fi) is the complement of V({fi}i∈I) in Spec(R).
    If f∈R and D(f)=Spec(R), then f is a unit. 

Proof. We address each part in the corresponding item below.

    This is a direct consequence of (2) or (3).
    Let 𝔄 be the set of all proper ideals of R. This set is ordered by inclusion and is non-empty, since (0)∈𝔄 is a proper ideal. Let A be a totally ordered subset of 𝔄. Then ⋃I∈AI is in fact an ideal. Since 1 ∉I for all I∈A, the union does not contain 1 and thus is proper. Hence ⋃I∈AI is in 𝔄 and is an upper bound for the set A. Thus by Zorn's lemma 𝔄 has a maximal element, which is the sought-after maximal ideal.
    Since R is nonzero, it contains a maximal ideal which is a prime ideal. Thus the set 𝔄 of all prime ideals of R is nonempty. 𝔄 is ordered by reverse-inclusion. Let A be a totally ordered subset of 𝔄. It's pretty clear that J=⋂I∈AI is in fact an ideal. Not so clear, however, is that it is prime. Let xy∈J. Then xy∈I for all I∈A. Now let B={I∈A|y∈I}. Let K=⋂I∈BI. Since A is totally ordered, either K=J (and we're done, since then y∈J) or K⊃J and for all I∈A such that I is properly contained in K, we have y∉I. But that means that for all those I,x∈I, since they are prime. Hence x∈J. In either case, J is prime as desired. Hence by Zorn's lemma we get a maximal element which in this case is a minimal prime ideal.
    This is the same exact argument as (3) except you only consider prime ideals contained in 𝔭 and containing I.
    (T) is the smallest ideal containing T. Hence if T⊂I, some ideal, then (T)⊂I as well. Hence if I∈V(T), then I∈V((T)) as well. The other inclusion is obvious.
    Since I⊂I√,V(I√)⊂V(I). Now let 𝔭∈V(I). Let x∈I√. Then xn∈I for some n. Hence xn∈𝔭. But since 𝔭 is prime, a boring induction argument gets you that x∈𝔭. Hence I√⊂𝔭 and 𝔭∈V(I√).
    Let f∈R∖I√. Then fn∉I for all n. Hence S={1,f,f2,…} is a multiplicative subset, not containing 0. Take a prime ideal 𝔭¯⊂S−1R containing S−1I. Then the pull-back 𝔭 in R of 𝔭¯ is a prime ideal containing I that does not intersect S. This shows that ⋂I⊂𝔭𝔭⊂I√. Now if a∈I√, then an∈I for some n. Hence if I⊂𝔭, then an∈𝔭. But since 𝔭 is prime, we have a∈𝔭. Thus the equality is shown.
    I is not the unit ideal if and only if I is contained in some maximal ideal (to see this, apply (2) to the ring R/I) which is therefore prime.
    If 𝔭∈V(I)∪V(J), then I⊂𝔭 or J⊂𝔭 which means that I∩J⊂𝔭. Now if I∩J⊂𝔭, then IJ⊂𝔭 and hence either I of J is in 𝔭, since 𝔭 is prime.
    𝔭∈⋂a∈AV(Ia)⇔Ia⊂𝔭,∀a∈A⇔𝔭∈V(∪a∈AIa)
    If 𝔭 is a prime ideal and f∈R, then either f∈𝔭 or f∉𝔭 (strictly) which is what the disjoint union says.
    If a∈R is nilpotent, then an=0 for some n. Hence an∈𝔭 for any prime ideal. Thus a∈𝔭 as can be shown by induction and D(f)=∅. Now, as shown in (7), if a∈R is not nilpotent, then there is a prime ideal that does not contain it.
    f∈𝔭⇔uf∈𝔭, since u is invertible.
    If 𝔭∉V(I), then ∃f∈I∖𝔭. Then f∉𝔭 so 𝔭∈D(f). Also if 𝔮∈D(f), then f∉𝔮 and thus I is not contained in 𝔮. Thus D(f)∩V(I)=∅.
    If fg∈𝔭, then f∈𝔭 or g∈𝔭. Hence if f∉𝔭 and g∉𝔭, then fg∉𝔭. Since 𝔭 is an ideal, if fg∉𝔭, then f∉𝔭 and g∉𝔭.
    𝔭∈⋃i∈ID(fi)⇔∃i∈I,fi∉𝔭⇔𝔭∈Spec(R)∖V({fi}i∈I)
    If D(f)=Spec(R), then V(f)=∅ and hence fR=R, so f is a unit. 


\begin{lemma}
\label{lemma-Zariski-topology}
Let $R$ be a ring.
\begin{enumerate}
\item The spectrum of a ring $R$ is empty if and only if $R$
is the zero ring.
\item Every nonzero ring has a maximal ideal.
\item Every nonzero ring has a minimal prime ideal.
\item Given an ideal $I \subset R$ and a prime ideal
$I \subset \mathfrak p$ there exists a prime
$I \subset \mathfrak q \subset \mathfrak p$ such
that $\mathfrak q$ is minimal over $I$.
\item If $T \subset R$, and if $(T)$ is the ideal generated by
$T$ in $R$, then $V((T)) = V(T)$.
\item If $I$ is an ideal and $\sqrt{I}$ is its radical,
see basic notion (\ref{item-radical-ideal}), then $V(I) = V(\sqrt{I})$.
\item Given an ideal $I$ of $R$ we have $\sqrt{I} =
\bigcap_{I \subset \mathfrak p} \mathfrak p$.
\item If $I$ is an ideal then $V(I) = \emptyset$ if and only
if $I$ is the unit ideal.
\item If $I$, $J$ are ideals of $R$ then $V(I) \cup V(J) =
V(I \cap J)$.
\item If $(I_a)_{a\in A}$ is a set of ideals of $R$ then
$\cap_{a\in A} V(I_a) = V(\cup_{a\in A} I_a)$.
\item If $f \in R$, then $D(f) \amalg V(f) = \Spec(R)$.
\item If $f \in R$ then $D(f) = \emptyset$ if and only if $f$
is nilpotent.
\item If $f = u f'$ for some unit $u \in R$, then $D(f) = D(f')$.
\item If $I \subset R$ is an ideal, and $\mathfrak p$ is a prime of
$R$ with $\mathfrak p \not\in V(I)$, then there exists an $f \in R$
such that $\mathfrak p \in D(f)$, and $D(f) \cap V(I) = \emptyset$.
\item If $f, g \in R$, then $D(fg) = D(f) \cap D(g)$.
\item If $f_i \in R$ for $i \in I$, then
$\bigcup_{i\in I} D(f_i)$ is the complement of $V(\{f_i \}_{i\in I})$
in $\Spec(R)$.
\item If $f \in R$ and $D(f) = \Spec(R)$, then $f$ is a unit.
\end{enumerate}
\end{lemma}

\begin{proof}
We address each part in the corresponding item below.
\begin{enumerate}
\item This is a direct consequence of (2) or (3).
\item Let $\mathfrak{A}$ be the set of all proper ideals of $R$. This set is
ordered by inclusion and is non-empty, since $(0) \in \mathfrak{A}$ is a proper
ideal. Let $A$ be a totally ordered subset of $\mathfrak A$.
Then $\bigcup_{I \in A} I$ is in
fact an ideal. Since 1 $\notin I$ for all $I \in A$, the union does not contain
1 and thus is proper. Hence $\bigcup_{I \in A} I$ is in $\mathfrak{A}$ and is
an upper bound for the set $A$. Thus by Zorn's lemma $\mathfrak{A}$ has a
maximal element, which is the sought-after maximal ideal.
\item Since $R$ is nonzero, it contains a maximal ideal which is a prime ideal.
Thus the set $\mathfrak{A}$ of all prime ideals of $R$ is nonempty.
$\mathfrak{A}$ is ordered by reverse-inclusion. Let $A$ be a totally ordered
subset of $\mathfrak{A}$. It's pretty clear that $J = \bigcap_{I \in A} I$ is
in fact an ideal. Not so clear, however, is that it is prime. Let $xy \in J$.
Then $xy \in I$ for all $I \in A$. Now let $B = \{I \in A | y \in I\}$. Let $K
= \bigcap_{I \in B} I$. Since $A$ is totally ordered, either $K = J$ (and we're
done, since then $y \in J$) or $K \supset J$ and for all $I \in A$ such that
$I$ is properly contained in $K$, we have $y \notin I$. But that means that for
all those $I, x \in I$, since they are prime. Hence $x \in J$. In either case,
$J$ is prime as desired. Hence by Zorn's lemma we get a maximal element which
in this case is a minimal prime ideal.
\item This is the same exact argument as (3) except you only consider prime
ideals contained in $\mathfrak{p}$ and containing $I$.
\item $(T)$ is the smallest ideal containing $T$. Hence if $T \subset I$, some
ideal, then $(T) \subset I$ as well. Hence if $I \in V(T)$, then $I \in V((T))$
as well. The other inclusion is obvious.
\item Since $I \subset \sqrt{I}, V(\sqrt{I}) \subset V(I)$. Now let
$\mathfrak{p} \in V(I)$. Let $x \in \sqrt{I}$. Then $x^n \in I$ for some $n$.
Hence $x^n \in \mathfrak{p}$. But since $\mathfrak{p}$ is prime, a boring
induction argument gets you that $x \in \mathfrak{p}$. Hence $\sqrt{I} \subset
\mathfrak{p}$ and $\mathfrak{p} \in V(\sqrt{I})$.
\item Let $f \in R \setminus \sqrt{I}$. Then $f^n \notin I$ for all $n$. Hence
$S = \{1, f, f^2, \ldots\}$ is a multiplicative subset, not containing $0$.
Take a
prime ideal $\bar{\mathfrak{p}} \subset S^{-1}R$ containing $S^{-1}I$. Then the
pull-back $\mathfrak{p}$ in $R$ of $\bar{\mathfrak{p}}$ is a prime ideal
containing $I$ that does not intersect $S$. This shows that $\bigcap_{I \subset
\mathfrak p} \mathfrak p \subset \sqrt{I}$. Now if $a \in \sqrt{I}$, then $a^n
\in I$ for some $n$. Hence if $I \subset \mathfrak{p}$, then $a^n \in
\mathfrak{p}$. But since $\mathfrak{p}$ is prime, we have $a \in \mathfrak{p}$.
Thus the equality is shown.
\item $I$ is not the unit ideal if and only if $I$
is contained in some maximal ideal (to
see this, apply (2) to the ring $R/I$) which is therefore prime.
\item If $\mathfrak{p} \in V(I) \cup V(J)$, then $I \subset \mathfrak{p}$ or $J
\subset \mathfrak{p}$ which means that $I \cap J \subset \mathfrak{p}$. Now if
$I \cap J \subset \mathfrak{p}$, then $IJ \subset \mathfrak{p}$ and hence
either $I$ of $J$ is in $\mathfrak{p}$, since $\mathfrak{p}$ is prime.
\item $\mathfrak{p} \in \bigcap_{a \in A} V(I_a) \Leftrightarrow I_a \subset
\mathfrak{p}, \forall a \in A \Leftrightarrow \mathfrak{p} \in V(\cup_{a\in A}
I_a)$
\item If $\mathfrak{p}$ is a prime ideal and $f \in R$, then either $f \in
\mathfrak{p}$ or $f \notin \mathfrak{p}$ (strictly) which is what the disjoint
union says.
\item If $a \in R$ is nilpotent, then $a^n = 0$ for some $n$. Hence $a^n \in
\mathfrak{p}$ for any prime ideal. Thus $a \in \mathfrak{p}$ as can be shown by
induction and $D(f) = \emptyset$. Now, as shown in (7), if $a \in R$ is not
nilpotent, then there is a prime ideal that does not contain it.
\item $f \in \mathfrak{p} \Leftrightarrow uf \in \mathfrak{p}$, since $u$ is
invertible.
\item If $\mathfrak{p} \notin V(I)$, then $\exists f \in I \setminus
\mathfrak{p}$. Then $f \notin \mathfrak{p}$ so $\mathfrak{p} \in D(f)$. Also if
$\mathfrak{q} \in D(f)$, then $f \notin \mathfrak{q}$ and thus $I$ is not
contained in $\mathfrak{q}$. Thus $D(f) \cap V(I) = \emptyset$.
\item If $fg \in \mathfrak{p}$, then $f \in \mathfrak{p}$ or $g \in
\mathfrak{p}$. Hence if $f \notin \mathfrak{p}$ and $g \notin \mathfrak{p}$,
then $fg \notin \mathfrak{p}$. Since $\mathfrak{p}$ is an ideal, if $fg \notin
\mathfrak{p}$, then $f \notin \mathfrak{p}$ and $g \notin \mathfrak{p}$.
\item $\mathfrak{p} \in \bigcup_{i \in I} D(f_i) \Leftrightarrow \exists i \in
I, f_i \notin \mathfrak{p} \Leftrightarrow \mathfrak{p} \in \Spec(R)
\setminus V(\{f_i\}_{i \in I})$
\item If $D(f) = \Spec(R)$, then $V(f) = \emptyset$ and
hence $fR = R$, so $f$ is a unit.
\end{enumerate}
\end{proof}
-/

import Kenny_comm_alg.maximal_ideal Kenny_comm_alg.minimal_prime_ideal
import Kenny_comm_alg.avoid_powers Kenny_comm_alg.Zariski

noncomputable theory
local attribute [instance] classical.prop_decidable

local infix ^ := monoid.pow

universe u

namespace tag00E0

variables (R : Type u) [comm_ring R]

lemma lemma01 : (X R → false) ↔ subsingleton R :=
⟨λ h, have h1 : (0:R) = 1,
   from classical.by_contradiction
     (λ hzo, h ⟨is_ideal.find_maximal_ideal.of_zero_ne_one hzo,
        (is_ideal.find_maximal_ideal.of_zero_ne_one.is_maximal_ideal hzo).to_is_prime_ideal⟩),
   ⟨λ x y, calc x = x * 0 : by rw [h1, mul_one]
              ... = y * 0 : by simp
              ... = y : by rw [h1, mul_one]⟩,
 λ h x, @@is_proper_ideal.ne_univ _ x.1 x.2.1 $
   set.eq_univ_of_forall $ λ z, calc
           z = z * 1 : eq.symm $ mul_one z
         ... = z * 0 : congr_arg _ (@subsingleton.elim R h 1 0)
         ... = 0 : mul_zero z
         ... ∈ x.val : @is_ideal.zero R _ x.val x.2.1.1⟩

lemma lemma02 : (0:R) ≠ 1 → ∃ S:set R, is_maximal_ideal S :=
λ hzo, ⟨is_ideal.find_maximal_ideal.of_zero_ne_one hzo,
  is_ideal.find_maximal_ideal.of_zero_ne_one.is_maximal_ideal hzo⟩

lemma lemma03 : (0:R) ≠ 1 → ∃ S:set R, is_prime_ideal S ∧ ∀ T, is_prime_ideal T → T ⊆ S → T = S :=
λ hzo, let M := is_ideal.find_maximal_ideal.of_zero_ne_one hzo in
have hm : is_maximal_ideal M := is_ideal.find_maximal_ideal.of_zero_ne_one.is_maximal_ideal hzo,
let S := @is_ideal.find_minimal_prime_ideal' R _ {0} _ M hm.to_is_prime_ideal
  (λ z hz, by simp at hz; rw hz; exact @is_ideal.zero R _ _ hm.1.1) in
have h1 : is_prime_ideal S := @is_ideal.find_minimal_prime_ideal'.is_prime_ideal R _ {0} _ M hm.to_is_prime_ideal
  (λ z hz, by simp at hz; rw hz; exact @is_ideal.zero R _ _ hm.1.1),
have h2 : ∀ T, is_prime_ideal T → {(0:R)} ⊆ T → T ⊆ S → T = S := @is_ideal.find_minimal_prime_ideal'.minimal R _ {0} _ M hm.to_is_prime_ideal
  (λ z hz, by simp at hz; rw hz; exact @is_ideal.zero R _ _ hm.1.1),
⟨S, h1, λ T ht hts, h2 T ht (λ z hz, by simp at hz; rw hz; exact ht.1.1.1.1) hts⟩

lemma lemma04 (I P : set R) [is_ideal I] [is_prime_ideal P] (hip : I ⊆ P) :
  ∃ Q:set R, is_prime_ideal Q ∧ I ⊆ Q ∧ Q ⊆ P ∧ ∀ S, is_prime_ideal S → I ⊆ S → S ⊆ Q → S = Q :=
let Q := is_ideal.find_minimal_prime_ideal I P hip in
have h1 : is_prime_ideal Q := is_ideal.find_minimal_prime_ideal.is_prime_ideal I P hip,
have h2 : I ⊆ Q := is_ideal.find_minimal_prime_ideal.ideal_contains I P hip,
have h3 : Q ⊆ P := is_ideal.find_minimal_prime_ideal.contains_prime I P hip,
have h4 : ∀ S, is_prime_ideal S → I ⊆ S → S ⊆ Q → S = Q,
  from is_ideal.find_minimal_prime_ideal.minimal I P hip,
⟨Q, h1, h2, h3, h4⟩

lemma lemma05 (T : set R) : Spec.V (span T) = Spec.V T :=
set.ext $ λ x,
⟨λ hx z hz, hx $ subset_span hz,
 λ hx z hz, span_minimal x.2.1.1.1 hx hz⟩

-- TODO: lemma06 lemma07

lemma lemma08 (I : set R) [is_ideal I] : Spec.V I = ∅ ↔ I = set.univ :=
⟨λ h, set.eq_univ_of_forall $ classical.by_contradiction $ λ hn,
   let ⟨f, hf⟩ := not_forall.1 hn in
   have h1 : is_proper_ideal I,
     from ⟨λ hi, by rw set.eq_univ_iff_forall at hi; cc⟩,
   suffices ∃ x, x ∈ Spec.V I,
     by rw [set.eq_empty_iff_forall_not_mem] at h; cases this with x hx; exact h x hx,
   ⟨⟨@is_ideal.find_maximal_ideal R _ I h1,
    (@is_ideal.find_maximal_ideal.is_maximal_ideal R _ I h1).to_is_prime_ideal⟩,
    @is_ideal.find_maximal_ideal.contains R _ I h1⟩,
 λ h, set.eq_empty_of_subset_empty $ λ z hz,
   @is_proper_ideal.ne_univ R _ z.1 z.2.1 $
   set.eq_univ_of_univ_subset $ h ▸ hz⟩

lemma lemma09 (I J : set R) [is_ideal I] [is_ideal J] : Spec.V I ∪ Spec.V J = Spec.V (I ∩ J) :=
have h1 : generate I = I,
  from set.eq_of_subset_of_subset
    (λ z hz, hz I $ set.subset.refl I)
    (subset_generate I),
have h2 : generate J = J,
  from set.eq_of_subset_of_subset
    (λ z hz, hz J $ set.subset.refl J)
    (subset_generate J),
have h3 : Spec.V (generate I ∩ generate J) = Spec.V I ∪ Spec.V J,
  from set.ext (Zariski._match_6 R _ _ I rfl J rfl), --hack level ≥ 9000
by rw [← h3, h1, h2]

-- we don't even need the fact that they are ideals
lemma lemma10 (SS : set (set R)) : ⋂₀ (Spec.V '' SS) = Spec.V ⋃₀ SS :=
set.ext $ λ x,
⟨λ hx f ⟨I, his, hfi⟩, hx _ ⟨I, his, rfl⟩ hfi,
 λ hx S ⟨I, his, hi⟩, hi ▸ λ f hfi, hx ⟨I, his, hfi⟩⟩

lemma lemma11a (f : R) : Spec.D' f ∪ Spec.V' f = set.univ :=
by finish [set.set_eq_def]

lemma lemma11b (f : R) : Spec.D' f ∩ Spec.V' f = ∅ :=
by finish [set.set_eq_def]

lemma lemma12 (f : R) : Spec.D' f = ∅ ↔ ∃ n, f^n = 0 :=
⟨λ h, classical.by_contradiction $ λ hf,
   have h1 : ∀ (n : ℕ), f ^ n ∉ {(0:R)},
     from λ n hfn, not_exists.1 hf n $ (set.mem_singleton_iff _ _).1 hfn,
   let x := is_ideal.avoid_powers f {0} h1 in
   have h2 : is_prime_ideal x,
     from is_ideal.avoid_powers.is_prime_ideal f {0} h1,
   have h3 : ∀ n, f^n ∉ x,
     from is_ideal.avoid_powers.avoid_powers f {0} h1,
   have h4 : f ∉ x,
     by simpa using h3 1,
   set.eq_empty_iff_forall_not_mem.1 h ⟨x, h2⟩ h4,
 λ ⟨n, hfn⟩, set.eq_empty_of_subset_empty $
   λ x hx, hx $ @@is_prime_ideal.mem_of_pow_mem _ x.2
   (set.mem_of_eq_of_mem hfn $
    @@is_ideal.zero _ x.1 x.2.1.1)⟩

-- slightly modified
lemma lemma13 (f g u v : R) (hf : f = g * u) (hg : g = f * v)
  (huv : u * v = 1) : Spec.D' f = Spec.D' g :=
set.ext $ λ x, not_iff_not.2
⟨assume hfx : f ∈ x.val,
   have h1 : g * u ∈ x.val,
     from set.mem_of_eq_of_mem hf.symm hfx,
   or.cases_on
     (@@is_prime_ideal.mem_or_mem_of_mul_mem _ x.2 h1)
     id (λ hu, false.elim $
       @@is_proper_ideal.not_mem_of_mul_right_one _ x.2.1 huv hu),
 assume hgx : g ∈ x.val,
   have h1 : f * v ∈ x.val,
     from set.mem_of_eq_of_mem hg.symm hgx,
   or.cases_on
     (@@is_prime_ideal.mem_or_mem_of_mul_mem _ x.2 h1)
     id (λ hv, false.elim $
       @@is_proper_ideal.not_mem_of_mul_left_one _ x.2.1 huv hv),⟩

-- people need to stop abstracting things by existentials
lemma lemma14 (f : R) (I : set R) [is_ideal I] (hfi : f ∈ I) :
  Spec.D' f ∩ Spec.V I = ∅ :=
set.eq_empty_of_subset_empty $ λ z ⟨hzf, hzi⟩, hzf $ hzi hfi

lemma lemma15 (f g : R) : Spec.D' (f * g) = Spec.D' f ∩ Spec.D' g :=
set.ext $ λ x,
⟨λ hx, ⟨λ hfx, hx $ @@is_ideal.mul_right _ x.2.1.1 hfx,
   λ hgx, hx $ @@is_ideal.mul_left _ x.2.1.1 hgx⟩,
 λ ⟨hfx, hgx⟩ hx, or.cases_on
   (@@is_prime_ideal.mem_or_mem_of_mul_mem _ x.2 hx)
   hfx hgx⟩

lemma lemma16 (F : set R) : ⋃₀ ((Spec.D') '' F) = -Spec.V F :=
set.ext $ λ x,
⟨λ ⟨S, ⟨f, hff, hfs⟩, hx⟩ h,
   have h1 : x ∈ Spec.D' f, by rwa ← hfs at hx,
   h1 $ h hff,
 λ hx, let ⟨f, hf⟩ := not_forall.1 hx in
   let ⟨hff, hfx⟩ := not_imp.1 hf in
   ⟨_, ⟨f, hff, rfl⟩, hfx⟩⟩

lemma lemma17 (f : R) (hf : Spec.D' f = set.univ) : ∃ g, f * g = 1 :=
have h1 : Spec.V' f = ∅,
  from set.eq_empty_of_subset_empty $
    λ x hx, by rw [set.eq_univ_iff_forall] at hf; specialize hf x; exact hf hx,
have h2 : Spec.V {f} = Spec.V' f,
  by simp [Spec.V, Spec.V'],
have h3 : _,
  from @lemma05 R _ {f},
have h4 : _,
  from @lemma08 R _ (span {f}) is_ideal_span,
have h5 : _,
  from (set.eq_univ_iff_forall.1 $ h4.1 $ h3.trans $ h2.trans h1) 1,
begin
  rw span_singleton at h5,
  cases h5 with g hg,
  existsi g,
  rw mul_comm,
  exact hg
end

end tag00E0