#| Question 5

5.1: No. Pair (1 2) (3 4 5 6)

5.2: Yes. 
     Proof: we can know (split L) will give 2 lists and their lengths will not be diffenrent from 1.
            So, assume (split L) -> (L1 L2)
            (mix (cadr (split L)) (car (split L))) -> (mix (cadr (L1 L2)) (car (L1 L2))) -> (mix L2 L1)
            According to the definition of mix, we will get the sequence which choosing elements from L1 and L2 alternatingly.
            And because L1's and L2's lengths are not different from 1, so they will finally get the same list as L.


|#