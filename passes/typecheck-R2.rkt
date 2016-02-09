#lang racket
(require "../utilities.rkt")
(provide typecheck-R2)


(define (typecheck-R2^ env e)
 (match e
  [(? fixnum?) 'Integer]
  [(? boolean?) 'Boolean]
  [(? symbol?) (lookup e env)]
  [`(let ([,x ,e]) ,body) (define T (typecheck-R2^ env e))
   (define new-env (cons (cons x T) env))
   (typecheck-R2^ new-env body)]
  [`(- ,e)
   (match (typecheck-R2^ env e)
          ['Integer 'Integer]
          [else (error 'typecheck-R2^ "'-' expects a Integer" e)])]
  [`(+ ,e1 ,e2)
   (cond
    [(not (equal? 'Integer (typecheck-R2^ env e1)))
     (error 'typecheck-R2^ "'+' expects a Integer" e1)]
    [(not (equal? 'Integer (typecheck-R2^ env e2)))
     (error 'typecheck-R2^ "'+' expects a Integer" e2)]
    [else 'Integer])]
  [`(read) 'Integer]
  [`(not ,e)
   (match (typecheck-R2^ env e)
          ['Boolean 'Boolean]
          [else (error 'typecheck-R2^ "'not' expects a Boolean" e)])]
  [`(and ,e1 ,e2)
   (cond
    [(not (equal? 'Boolean (typecheck-R2^ env e1)))
     (error 'typecheck-R2^ "'and' expects a Boolean" e1)]
    [(not (equal? 'Boolean (typecheck-R2^ env e2)))
     (error 'typecheck-R2^ "'and' expects a Boolean" e2)]
    [else 'Boolean])]
  [`(or ,e1 ,e2)
   (cond
    [(not (equal? 'Boolean (typecheck-R2^ env e1)))
     (error 'typecheck-R2^ "'or' expects a Boolean" e1)]
    [(not (equal? 'Boolean (typecheck-R2^ env e2)))
     (error 'typecheck-R2^ "'or' expects a Boolean" e2)]
    [else 'Boolean])]
  [`(eq? ,e1 ,e2)
   (let ([e1^ (typecheck-R2^ env e1)]
         [e2^ (typecheck-R2^ env e2)])
     (cond
      [(eq? e1^ e2^) 'Boolean]
      [else (error 'typecheck-R2^
                   (string-append "'eq?' expects a " (symbol->string e1^))
                   e2)]))]
  [`(if ,cnd ,thn ,els)
   (let ([cnd^ (typecheck-R2^ env cnd)])
     (cond
      [(equal? cnd^ 'Boolean)
       (define thn^ (typecheck-R2^ env thn))
       (define els^ (typecheck-R2^ env els))
       (if (equal? thn^ els^)
           thn^
           (error 'typecheck-R2^
                  (string-append "'if' expects a "(symbol->string thn^))))]
      [else (error 'typecheck-R2^ "'if' expects a Boolean" cnd)]))]
  [`(program ,body) (typecheck-R2^ '() body) ]))

(define (typecheck-R2 e)
  (typecheck-R2^ '() e))
;;(typecheck-R2^ '() `(program (let ((x #t)) 42)))
