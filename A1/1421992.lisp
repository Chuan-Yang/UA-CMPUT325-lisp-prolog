#| Question 1

The function checks if y is a member of x. If it is, it will return T and NIL otherwise.

It firstly checks if x is equal to nil, if so, it will directly return nil. Or it will compare the element in x with y one by one.
If it finds one equal to y, it will return T.

Test Cases:
(xmember nil nil) => NIL
(xmember '(nil) nil) => T
(xmember '((nil)) nil) => NIL
(xmember '((1) 2 3) '(1)) => T

|#

(defun xmember (x y) 
    (if (equal x nil)
        NIL
        (if (equal (car x) y) 
            T 
            (xmember (cdr x) y)))
)

#| Question 2

The function helps the orignal list get rid of the nested brackets and make all the elements in it atoms.

It firstly checks if the x if empty, which means we done, so return x. Otherwise, we check if the current element is atom. If so, construct
it with the recursive call which will return a list. If not, use car to get rid of one floor brackets.

Test Cases:
(flatten '(a (b c) d)) => (a b c d)
(flatten '((((a))))) => (a)
(flatten '(a (b c) (d ((e)) f))) => (a b c d e f)

|#

(defun flatten (x) 
    (if (null x) 
        x  
        (if (atom (car x)) 
            (cons (car x) (flatten (cdr x)))
            (flatten (append (car x) (cdr x)))
        )
    )
)

#| Question 3

The function helps the orignal list get rid of the nested brackets and make all the elements in it atoms.

It firstly checks if the x if empty, which means we done, so return x. Otherwise, we check if the current element is atom. If so, construct
it with the recursive call which will return a list. If not, use car to get rid of one floor brackets.

Test Cases:


|#



#| Question 4

The function helps the orignal list get rid of the nested brackets and make all the elements in it atoms.

It firstly checks if the x if empty, which means we done, so return x. Otherwise, we check if the current element is atom. If so, construct
it with the recursive call which will return a list. If not, use car to get rid of one floor brackets.

Test Cases:
(flatten '(a (b c) d)) => (a b c d)
(flatten '((((a))))) => (a)
(flatten '(a (b c) (d ((e)) f))) => (a b c d e f)


|#

(defun splitFirst (L)
	(if (null (caddr L))
		(cons (car L) nil)
		(cons (car L) (splitFirst (cddr L)))
	)
)

(defun split (L)
	(if (null L)
		(list nil nil)
		(list (cons (car L) (splitFirst (cddr L))) (cons (cadr L) (splitFirst (cdddr L))) ))
)