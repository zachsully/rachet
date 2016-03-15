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

(define (patch-instructions p)
 (match p
  [`(program ,extra ,t (defines ,defs ...) ,instrs ...)
   `(program ,extra
	     ,t
	     (defines ,@(map patch-instructions defs))
	     ,@(append-map patch instrs))]

  [`(define (,f) ,num-locals (,vars ,max-stack) ,locals ,instrs ...)
   `(define (,f)
      ,num-locals
      (,vars ,max-stack)
      ,locals
      ,@(append-map patch instrs))]))

(define (patch instr)
  (match instr
   [`(,op (stack ,var1) (stack ,var2))
    `((movq (stack ,var1) (reg rax))
      (,op (reg rax) (stack ,var2)))]

   [`(,op ,var1 (int ,x))
    `((movq (int ,x) (reg rax))
      (,op ,var1 (reg rax)))]



   ;; >>  Moving something from the stack to a vec, when vec is on the stack  <<
   [`(movq (stack ,a) (offset (stack ,b-loc) ,j))
    `((pushq (stack ,a))
      (movq (stack ,b-loc) (reg rax))
      (popq (offset (reg rax) ,j)))]

   ;; (movq (stack -16) (offset (stack -8) 8))
   ;; = >
   ;; pushq -16(%rbp)
   ;; movq -8(%rbp), %rax
   ;; popq 8(%rax)

   [`(movq (offset (stack ,a-loc) ,i) (stack ,b))
    `((pushq (stack ,a-loc))
      (popq (reg rax))
      (movq (offset (reg rax) ,i) (reg rax))
      (movq (reg rax) (stack ,b)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


   ;; >> Moving something from the stack to a vec, when vec NOT on the stack  <<
   [`(movq (stack ,a) (offset ,b ,j))
    `((movq (stack ,a) (reg rax))
      (movq (reg rax) (offset ,b ,j)))]

   [`(movq (offset ,a ,i) (stack ,b))
    `((movq (offset ,a ,i) (reg rax))
      (movq (reg rax) (stack ,b)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



   ;; >>                 When a vector is on the stack                        <<
   [`(movq ,a (offset (stack ,loc) ,i))
    `((movq (stack ,loc) (reg rax))
      (movq ,a (offset (reg rax) ,i)))]

   [`(movq (offset (stack ,loc) ,i) ,b)
    `((movq (stack ,loc) (reg rax))
      (movq (offset (reg rax) ,i) ,b))]
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

   [else `(,instr)]))
