

#|
Get the argument of the function
eg. (func (+ a b) (3 4)) --> (a b)
|#
(defun search-func-arg (f L)
  (if (null L)
      nil
      (if (eq f (caar L))
	  (cadar L)
	(search-func-arg f (cdr L)))))


#|
Return the argument of the function
rg. (a = ...) --> (a)
|#
(defun return-func-arg (f)
  (if (eq (car f) '=)
    nil
    (cons (car f) (return-func-arg (cdr f)))))


#|
Map the value for the variables
eg. (map 3 5), (map (a b) (...)) --> ((a 3) (b 5))
|#
(defun map-func-arg (E P C)
  (if (null E)
      nil
    (cons (list (car E) (fl-interpc (car P) C)) (map-func-arg (cdr E) (cdr P) C))))


#|
Get the body of the function
eg. (func (+ a b) (3 4)) --> (3 4)
|#
(defun search-func-body (f L)
  (if (null L)
      nil
    (if (eq f (caar L))
	(caddar L)
      (search-func-body f (cdr L)))))


#|
Return the body of the function
eg. (func a = ...) --> (...)
|#
(defun return-func-body (f)
  (if (null f)
      nil
      (if (eq (car f) '=)
	  (cadr f)
          (return-func-body (cdr f)))))


#|
For the User defined function.
eg. (xmember '1 '(1)) (assignment #1)
|#
(defun user-defined (s L)
  (if (null L)
    nil
    (if(eq s (caar L))
      T
      (user-defined s (cdr L)))))


#|
Change the function format into (f (x) (...))
In order to find the different part easier
|#
(defun fl-interp (E P)
  (fl-interpc E (mapcar (lambda (f) (list (car f) (return-func-arg (cdr f)) (return-func-body f))) P)))

#|
Main function of the program
|#
(defun fl-interpc (E P)
    (cond
        ((atom E) (cond ((user-defined E P) (fl-interpc (search-func-arg E P) P))   (T E)))
        (t
            (let ((f (car E)) (arg (cdr E)))
                (cond
                    ; handle built-in functions
                    ((eq f 'first) (car (fl-interpc (car arg) P)))
                    ((eq f 'rest)  (cdr (fl-interpc (car arg) P)))
                    ((eq f 'null)  (null (fl-interpc (car arg) P)))
                    ((eq f 'atom)  (atom (fl-interpc (car arg) P)))
                    ((eq f 'number)(numberp (fl-interpc (car arg) P)))
                    ((eq f 'not)   (not (fl-interpc (car arg) P)))
                    ((eq f 'eq)    (eq (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f 'cons)  (cons (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f 'equal) (equal (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f '+)     (+ (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f '-)     (- (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f '*)     (* (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)))
                    ((eq f '>)     (if (> (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)) T nil))
                    ((eq f '<)     (if (< (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)) T nil))
                    ((eq f '=)     (if (= (fl-interpc (car arg) P) (fl-interpc (cadr arg) P)) T nil))
                    ((eq f 'and)   (if (and (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
                    ((eq f 'or)    (if (or (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
                    ((eq f 'if)    (if (fl-interpc (car arg) P) (fl-interpc (cadr arg) P) (fl-interpc (caddr arg) P)))
                    ; ..... 
                    
                    ; if f is a user-defined function,
                    ;    then evaluate the arguments 
                    ;         and apply f to the evaluated arguments 
                    ;             (applicative order reduction) 
                    ; .....
                    ((user-defined f P) (fl-interpc (search-func-body f P)  (append (map-func-arg (search-func-arg f P) arg P) P)))
                    ;(T (cons (fl-interpc (car E) P) (fl-interpc (cdr E) P)))
                    ; otherwise f is undefined; in this case,
                    ; E is returned as if it is quoted in lisp
                    (T E)
                )
            )
        )
    )
)