#lang racket
(require "flatten.rkt")
(provide select-instructions)

(define (select-instructions^ e)
  (cond
   [(null? e) '()]
   [else
    (append
     (match (car e)
      [`(assign ,v (read))
       `((callq read_int)
         (movq (reg rax) (var ,v)))]
      [`(assign ,v (- ,e1))
       (if (symbol? e1)
           `((movq (var ,e1) (var ,v))
             (negq (var ,v)))

           `((movq (int ,e1) (var ,v))
             (negq (var ,v))))]
      [`(assign ,v (+ ,e1 ,e2))
       (cond
        [(and (symbol? e1) (symbol? e2))
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
      [`(assign ,v (eq? ,x ,y))
       (if (integer? x)
           (if (integer? y)
               `((cmpq (int ,x) (int ,y))
                 (sete (byte-reg al))
                 (movzbq (byte-reg al) (var ,v)))
               `((cmpq (int ,x) (var ,y))
                 (sete (byte-reg al))
                 (movzbq (byte-reg al) (var ,v))))
           (if (integer? y)
               `((cmpq (var ,x) (int ,y))
                 (sete (byte-reg al))
                 (movzbq (byte-reg al) (var ,v)))
               `((cmpq (var ,x) (var ,y))
                 (sete (byte-reg al))
                 (movzbq (byte-reg al) (var ,v)))))]
      [`(assign ,v ,x)
       (cond
        [(symbol? x) `((movq (var ,x) (var ,v)))]
        [(boolean? x)
         (let ([b (if x `(int 1) `(int 0))])
           `((movq ,b (var ,v))))]
        [else `((movq (int ,x) (var ,v)))])]
      [`(return ,v)
       (cond
        [(symbol? v) `((movq (var ,v) (reg rax)))]
        [else `((movq (int ,v) (reg rax)))])]
      [`(if (eq? #t ,v) ,thn ,els)
       `((if (eq? (int 1) ,(wrap v))
             ,(select-instructions^ thn)
             ,(select-instructions^ els)))])
     (select-instructions^ (cdr e)))]))

(define (wrap v)
 (cond
  [(integer? v) `(int ,v)]
  [(boolean? v) (if v `(int 1) `(int 0))]
  [else `(var ,v)]))

(define (select-instructions e)
  (match e
    [`(program ,vs ,es ...)
     (let ([intrs (select-instructions^ es)])
       `(program ,vs ,@intrs))]))

;; (display (flatten `(program (if (eq? (read) 1) 42 0))))
;; (display (select-instructions (flatten `(program (if (eq? (read) 1) 42 0)))))
