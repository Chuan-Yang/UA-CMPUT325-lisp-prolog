(defun sum (list)
    (if (null list) 
        0
        (+ (car list) (sum (cdr list)))
    )
)

(defun  subsetsum (S L)
    (cond
        ((null L) nil)  
        ((= S (car L)) (list S) )
        
        ((< (sum L) S) nil)
        ((= S (sum L)) L)
        ((> (car(sort (copy-list L) #'<)) S) nil)
        ((> (car L) S) (subsetsum S (cdr L)))

        (t (let( 
                (opt_cal (subsetsum (- S (car L)) (cdr L))))
                (if opt_cal
                    (cons (car L) opt_cal)
                    (subsetsum S (cdr L))
                )
            ) 
        )
    )
)
