#lang racket
(require "../utilities.rkt")
(provide typecheck)

;;
;; Typechecker
;;
;; typecheck : R3 -> Type
;;
;; Returns the type of the program or fails
;;

(define (typecheck^ env e)
 (match e
  [(? fixnum?) 'Integer]
  [(? boolean?) 'Boolean]
  [(? symbol?) (lookup e env)]
  [`(let ([,x ,e]) ,body)
   (let* ([t (typecheck^ env e)]
          [env^ (cons (cons x t) env)])
     (typecheck^ env^ body))]
  [`(- ,e)
   (let ([t (typecheck^ env e)])
     (match t
      ['Integer 'Integer]
      [else (error 'typecheck^ "'-' expects a Integer" e)]))]
  [`(+ ,e1 ,e2)
   (let ([t1 (typecheck^ env e1)]
         [t2 (typecheck^ env e2)])
    (cond
    [(not (equal? 'Integer t1))
     (error 'typecheck^ "'+' expects a Integer" e1)]
    [(not (equal? 'Integer t2))
     (error 'typecheck^ "'+' expects a Integer" e2)]
    [else 'Integer]))]
  [`(read) 'Integer]
  [`(not ,e)
   (match (typecheck^ env e)
          ['Boolean 'Boolean]
          [else (error 'typecheck^ "'not' expects a Boolean" e)])]
  [`(and ,e1 ,e2)
   (cond
    [(not (equal? 'Boolean (typecheck^ env e1)))
     (error 'typecheck^ "'and' expects a Boolean" e1)]
    [(not (equal? 'Boolean (typecheck^ env e2)))
     (error 'typecheck^ "'and' expects a Boolean" e2)]
    [else 'Boolean])]
  [`(or ,e1 ,e2)
   (cond
    [(not (equal? 'Boolean (typecheck^ env e1)))
     (error 'typecheck^ "'or' expects a Boolean" e1)]
    [(not (equal? 'Boolean (typecheck^ env e2)))
     (error 'typecheck^ "'or' expects a Boolean" e2)]
    [else 'Boolean])]
  [`(eq? ,e1 ,e2)
   (let ([e1^ (typecheck^ env e1)]
         [e2^ (typecheck^ env e2)])
     (cond
      [(eq? e1^ e2^) 'Boolean]
      [else (error 'typecheck^
                   (string-append "'eq?' expects a " (symbol->string e1^))
                   e2)]))]
  [`(if ,cnd ,thn ,els)
   (let ([cnd^ (typecheck^ env cnd)])
     (cond
      [(equal? cnd^ 'Boolean)
       (define thn^ (typecheck^ env thn))
       (define els^ (typecheck^ env els))
       (if (equal? thn^ els^)
           thn^
           (error 'typecheck^
                  (string-append "'if' expects a "(symbol->string thn^))))]
      [else (error 'typecheck^ "'if' expects a Boolean" cnd)]))]
  ))

(define (typecheck e)
  (match e
   [`(program ,e) (typecheck^ '() e)]))
