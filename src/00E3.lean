/-
Lemma 10.16.5. Let R be a ring. Let S⊂R be a multiplicative subset. The map R→S−1R induces via the functoriality of Spec a homeomorphism
Spec(S−1R)⟶{𝔭∈Spec(R)∣S∩𝔭=∅}
where the topology on the right hand side is that induced from the Zariski topology on Spec(R). The inverse map is given by 𝔭↦S−1𝔭.

Proof. Denote the right hand side of the arrow of the lemma by D. Choose a prime 𝔭′⊂S−1R and let 𝔭 the inverse image of 𝔭′ in R. Since 𝔭′ does not contain 1 we see that 𝔭 does not contain any element of S. Hence 𝔭∈D and we see that the image is contained in D. Let 𝔭∈D. By assumption the image S⎯⎯⎯ does not contain 0. By basic notion (54) (= tag 00C6) S⎯⎯⎯−1(R/𝔭) is not the zero ring. By basic notion (62) (=tag 00CD) we see S−1R/S−1𝔭=S⎯⎯⎯−1(R/𝔭) is a domain, and hence S−1𝔭 is a prime. The equality of rings also shows that the inverse image of S−1𝔭 in R is equal to 𝔭, because R/𝔭→S⎯⎯⎯−1(R/𝔭) is injective by basic notion (55) (=tag 00C7). This proves that the map Spec(S−1R)→Spec(R) is bijective onto D with inverse as given. It is continuous by Lemma 10.16.4 (=tag 00E2). Finally, let D(g)⊂Spec(S−1R) be a standard open. Write g=h/s for some h∈R and s∈S. Since g and h/1 differ by a unit we have D(g)=D(h/1) in Spec(S−1R). Hence by Lemma 10.16.4 (=tag 00E2) and the bijectivity above the image of D(g)=D(h/1) is D∩D(h). This proves the map is open as well. 
-/
