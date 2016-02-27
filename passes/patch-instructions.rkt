#lang racket
(provide patch-instructions)

;;
;; Patch Instructions
;;
;; patch-instruction : x86' -> x86'
;;
;; Pass removes stack to stack operations and ones that have ints in their
;; righthand-side
;;

(define patch-instructions
  (lambda (e)
    (match e
     [`(program ,v ,t ,es ...)
      `(program ,v ,t ,@(foldr (lambda (e^ acc) (append (patch e^) acc))
			       '()
			       es))])))

(define (patch e)
  (match e
   [`(,op (stack ,var1) (stack ,var2))
    `((movq (stack ,var1) (reg rax))
      (,op (reg rax) (stack ,var2)))]

   [`(,op ,var1 (int ,x))
    `((movq (int ,x) (reg rax))
      (,op ,var1 (reg rax)))]



   ;; >>           Moving something from the stack to a vec                   <<
   [`(,op (stack ,a) (offset ,b ,j))
    `((pushq (stack ,a))
      (movq ,b (reg rax))
      (popq (offset (reg rax) ,j)))]

   [`(,op (offset ,a ,i) (stack ,b))
    `((pushq (stack ,b))
      (movq ,a (reg rax))
      (popq (offset (reg rax) ,i)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



   ;; >>                 When a vector is on the stack                        <<
   [`(,op ,a (offset (stack ,loc) ,i))
    `((movq (stack ,loc) (reg rax))
      (,op ,a (offset (reg rax) ,i)))]

   [`(,op (offset (stack ,loc) ,i) ,b)
    `((movq (stack ,loc) (reg rax))
      (,op (offset (reg rax) ,i) ,b))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




   ;; >>                      Global-value to stack                           <<
   [`(,op (global-value ,v) (stack ,i))
    `((movq (global-value ,v) (reg rax))
      (movq (reg rax) (stack ,i)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



   ;; >>                      cmpq  from stack                                <<
   [`(cmpq (stack ,i) ,b)
    `((movq (stack ,i) (reg rax))
      (cmpq (reg rax) ,b))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   ;; >>                      movzbq to stack                                 <<
   [`(movzbq ,al (stack ,i))
    `((movq (stack ,i) (reg rax))
      (movzbq ,al (reg rax))
      (movq (reg rax) (stack ,i)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   [else `(,e)]))
