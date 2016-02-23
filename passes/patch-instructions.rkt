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
   [else `(,e)]))
