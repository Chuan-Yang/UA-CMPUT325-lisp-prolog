#|
    Assignment 2
    Chuan Yang
    1421992
|#

;----------------------------------------------------------------------------------------------
; Helper functions for the initial call of the interpreter

; Extract the arguements from the given function
(defun ext-arg (P)
    (cond 
        ((eq (car P) '=) nil)
        (t (cons (car P) (ext-arg (cdr P))) )
    )
)

;Extract the main body from the given function
(defun ext-body (P)
    (if (eq (car P) '=) 
        (cadr P)
        (ext-body (cdr P))
    )
)

; Initial call
; Transfer the body formula of P:
; (f arg = body) -> (f (arg) (body)) 
; Use to help add the context into the body part
(defun fl-interp (E P)
    (fl-interp1 E (mapcar #'(lambda (a) (list (car a) (ext-arg (cdr a)) (ext-body a) )) P))     
)


;----------------------------------------------------------
; Main function part with helper-functions

; Evaluate the variable passed using the value list
(defun eval-var (var P)
    (cond
        ((null P) nil)
        ((eq var (caar P)) (cadar P))
        (t (eval-var var (cdr P)))
    )
)


; Check if the function-name is defined in the P
(defun find-def (name P)
    (cond
        ((null P) nil)
        ((eq name (caar P)) T)
        (t (find-def name (cdr P)))
    )
)

; Find the function body for the calling function-name
(defun find-body (name P)
    (if (eq name (caar P))
        (caddar P)
        (find-body name (cdr P))
    )
) 

; Find the argument for the calling function-name
(defun find-arg (name P)
    (if (eq name (caar P))
        (cadar P)
        (find-arg name (cdr P))
    )
)

; The key part: AOR
; Find the value for each argument and construct them to the formula: (argument value)
; then list all this kind of pairs  
; Each time checking the value, it will call the main function agian to make sure getting the final form for the argument
(defun AOR (arg E P)
    (if (null arg) 
        nil
        (cons (list (car arg) (fl-interp1 (car E) P)) (AOR (cdr arg) (cdr E) P))
    )
)

; Extend the context and add it into P, which will kinda treat it as a function which will return the value of the variable
(defun extend-ct (E P)
    (append (AOR (find-arg (car E) P) (cdr E) P) P)
)

; Main Function
(defun fl-interp1 (E P)
    (cond 
        ; evaluate the arguements in the function
	    ((atom E)   ;this includes the case where expr is nil
            (if (find-def E P) 
                (fl-interp1 (eval-var E P) P)       ;find the variable in the value list 
                E                                   ;else, it's a number or not defined
            )
        )   
        (t
           (let ( (f (car E))  (arg (cdr E)) )
              (cond 
                    
                    ; handle built-in functions
                    ((eq f 'first)  (car (fl-interp1 (car arg) P)))
                    ((eq f 'rest)   (cdr (fl-interp1 (car arg) P)))
                    ((eq f 'null)   (if (null (fl-interp1 (car arg) P)) t nil))
                    ((eq f 'equal)  (if (equal (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P))  t nil) )
                    ((eq f 'eq)  (if (eq (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P))  t nil) )
                    ((eq f 'isnumber)  (if (numberp (fl-interp1 (car arg) P))  t nil) )
                    ((eq f 'atom)  (if (atom (fl-interp1 (car arg) P))  t nil) )
                    ((eq f 'if)  (if (fl-interp1 (car arg) P)  (fl-interp1 (cadr arg) P) (fl-interp1 (caddr arg) P) ))
                    ((eq f 'cons)  (cons (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '+)  (+ (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '-)  (- (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '*)  (* (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '>)  (> (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '<)  (< (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f '=)  (= (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f 'and)  (and (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f 'or)  (or (fl-interp1 (car arg) P) (fl-interp1 (cadr arg) P)))
                    ((eq f 'not)  (not (fl-interp1 (car arg) P)) )
                    
                    ; handle user-defined functions
                    ((find-def f P) (fl-interp1 (find-body f P) (extend-ct E P)) )
                    
                    ; f not defined
                    (t E)
              )
           )
        )
    )
)
