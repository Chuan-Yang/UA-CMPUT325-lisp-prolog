(defun xmember (x y) (
	if (equal x nil)
	NIL
	(if (equal (car x) y) 
		T 
		(xmember (cdr x) y)))
)

