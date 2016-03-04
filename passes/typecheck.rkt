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
  [`(define (,name (,var : ,vtype) ...) : ,ftype ,body)
   e]

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
     (error 'typecheck^ "'+' expects a Integer")]
    [(not (equal? 'Integer t2))
     (error 'typecheck^ "'+' expects a Integer")]
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

  [`(vector ,args ...)
   (if (empty? args)
       (error 'typecheck^
              "'vector' expects at least one argument")
       (let ([ts (map (lambda (a) (typecheck^ env a)) args)])
         `(Vector ,@ts)))]

  [`(vector-ref ,arg ,i)
   (cond
    [(not (integer? i))
     (error 'typecheck^
            "'vector-ref' expects an integer for the second arg")]
    [else (let ([t (typecheck^ env arg)])
            (match t
             [`(Vector ,args ...)
              (if (< (length args) i)
                  (error 'typecheck^
                         "'vector-ref' index does not exist in vector")
                  (car (drop args i)))]
             [`,_
              (error 'typecheck^
                     "'vector-ref' expects a vector for the first arg")]))])]
  [`(vector-set! ,arg ,i ,narg)
   (cond
    [(not (integer? i))
     (error 'typecheck^
            "'vector-set!' expects an integer for the second arg")]
    [else (let ([t (typecheck^ env arg)]
                [nt (typecheck^ env narg)])
            (match t
             [`(Vector ,args ...)
              (cond
               [(< (length args) i)
                (error 'typecheck^
                       "'vector-set!' index does not exist in vector")]
               [(not (equal? (car (drop args i)) nt))
                (error 'typecheck^
                       "'vector-set!' attempting to change type of vector-field")]
               [else 'Void])]
             [`,_
              (error 'typecheck^
                     "'vector-set!' expects a vector for the first arg")]))])]
  ))

(define (typecheck e)
  (match e
   [`(program ,defs ... ,e)
    `(program (type ,(typecheck^ '() e)) ,e)]))
