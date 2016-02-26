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

   ;; [`(,op (offset (stack ,loc-a) ,i) (offset (stack ,loc-b) ,j))
   ;;  `((movq (stack ,loc-a) (reg rax))
   ;;    (,op ,a (offset (reg rax) ,i)))]

   [`(,op ,a (offset (stack ,loc) ,i))
    `((movq (stack ,loc) (reg rax))
      (,op ,a (offset (reg rax) ,i)))]

   [`(,op (offset (stack ,loc) ,i) ,b)
    `((movq (stack ,loc) (reg rax))
      (,op (offset (reg rax) ,i) ,b))]

   [`(,op (global-value rootstack_begin) (stack ,i))
    `((movq (global-value rootstack_begin) (reg rax))
      (movq (reg rax) (stack ,i)))]

   ;; [`(,op (stack ,a) (offset (stack ,stack-loc-b) ,j))
   ;;  `((pushq (stack ,a))
   ;;    (movq (stack ,stack-loc-b) (reg rax))
   ;;    (popq (offset (reg rax) ,j)))]
   ;; [`(,op (offset (stack ,stack-loc-a) ,i) (offset (stack ,stack-loc-b) ,j))
   ;;  `((pushq ))]
   [else `(,e)]))
