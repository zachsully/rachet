#lang racket
(provide patch-instructions)

(define patch-instructions
  (lambda (e)
    (match e
     [`(program ,v ,es ...)
      `(program ,v ,@(foldr (lambda (e^ acc)
                             (match e^
				    [`(,op (stack ,var1) (stack ,var2))
				     (append `((movq (stack ,var1) (reg rax))
					       (,op (reg rax) (stack ,var2)))
					     acc)]
				    [`(,ex ...) (cons e^ acc)]))
			    '()
			    es))])))
