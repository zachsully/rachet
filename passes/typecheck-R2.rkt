#lang racket
(require "../utilities.rkt")
;; (require "macros.rkt") ;; for debug
(provide typecheck-R2)

;; if returning two types?
;; read returning just int?

(define (typecheck-R2 p)
  (match p
   [`(program ,e) (typecheck-R2^ '() e)]))

(define (typecheck-R2^ env e)
  (match e
   [(? fixnum?) 'Integer]
   [(? boolean?) 'Boolean]
   [(? symbol?) (lookup e env)]
   [`(if ,cnd ,thn ,els)
    (let ([ct (match (typecheck-R2^ env cnd)
               ['Boolean 'Boolean]
               [else (error 'typecheck-R2^
                            "'if' expects a Boolean in first arg"
                            e)])]
          [tht (typecheck-R2^ env thn)]
          [et (typecheck-R2^ env els)])
      (if (eq? tht et)
          tht
          (error 'typecheck-R2^
                 "'if' expects 2nd and 3rd arg to be the same type"
                 e)))]
   [`(let ([,x ,e^]) ,body)
    ((lambda (t)
       (typecheck-R2^ (cons (cons x t) env) body))
     (typecheck-R2^ env e^))]
   [`(not ,e)
    (match (typecheck-R2^ env e)
     ['Boolean 'Boolean]
     [else (error 'typecheck-R2^ "'not' expects a Boolean" e)])]))

(typecheck-R2 `(program #f))
(typecheck-R2 `(program (not #f)))
(typecheck-R2 `(program 42))
(typecheck-R2 `(program (not #t)))
(typecheck-R2 `(program (if #f #t #f)))
(typecheck-R2 `(program (if (let ([x 42]) #t) #t #f)))
