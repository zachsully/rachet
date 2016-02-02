#lang racket
(provide select-instructions)

(define (select-instructions^ e)
  (cond
   [(null? e) '()]
   [else
    (append
     (match (car e)
            [`(assign ,v (read)) `((callq read_int)
                                   (movq (reg rax) (var ,v)))]
            [`(assign ,v (- ,e1))
             (if (symbol? e1)
                 `((movq (var ,e1) (var ,v))
		   (negq (var ,v)))

                 `((movq (int ,e1) (var ,v))
                   (negq (var ,v))))]
            [`(assign ,v (+ ,e1 ,e2))
             (cond
              [(and (symbol? e1)
                    (symbol? e2))
               `((movq (var ,e2) (var ,v))
	         (addq (var ,e1) (var ,v)))]
              [(symbol? e1)
               `((movq (var ,e1) (var ,v))
                 (addq (int ,e2) (var ,v)))]
              [(symbol? e2)
               `((movq (var ,e2) (var ,v))
                 (addq (int ,e1) (var ,v)))]
              [else
               `((movq (int ,e1) (var ,v))
                 (addq (int ,e2) (var ,v)))])]
            [`(assign ,v ,x)
	     (cond
	      [(symbol? x) `((movq (var ,x) (var ,v)))]
	      [else `((movq (int ,x) (var ,v)))])]
            [`(return ,v)
	     (cond
	      [(symbol? v) `((movq (var ,v) (reg rax)))]
	      [else `((movq (int ,v) (reg rax)))])])
     (select-instructions^ (cdr e)))]))

(define (select-instructions e)
  (match e
    [`(program ,vs ,es ...)
     (let ([intrs (select-instructions^ es)])
       `(program ,vs ,@intrs))]))
