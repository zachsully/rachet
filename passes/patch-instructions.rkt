#lang racket
(provide patch-instructions)

(define patch-instructions
  (lambda (e)
    (match e
     [`(program ,v ,es ...)
      `(program ,v ,@(foldr (lambda (e^ acc) (append (patch e^) acc))
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
