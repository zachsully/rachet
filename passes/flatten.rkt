#lang racket
(require "../utilities.rkt")
(provide flatten)

(define flatten^
  (lambda (e need-var)
    (match e
     [(? symbol?) (values e '())]
     [(? integer?) (values e '())]
     [`(let ([,x ,rhs]) ,body)
      (let-values ([(rhs_ex rhs_stmts) (flatten^ rhs #f)]
                   [(body_ex body_stmts) (flatten^ body need-var)])
        (values body_ex (append rhs_stmts `((assign ,x ,rhs_ex)) body_stmts)))]
     [`(program ,e)
      (let-values ([(ex rhs) (flatten^ e need-var)])
        (let ([vars (unique-vars rhs)])
          `(program ,vars ,@(append rhs `((return ,ex))))))]
     [`(read)
      (if need-var
        (let ([tmp (gensym)])
          (values tmp `((assign ,tmp (read)))))
        (values '(read) `()))]
     [`(- ,es)
      (if need-var
        (let ([tmp (gensym)])
          (let-values ([(ex stmts) (flatten^ es need-var)])
            (values tmp (append stmts `((assign ,tmp (- ,ex)))))))
        (let-values ([(ex stmts) (flatten^ es need-var)])
          (values `(- ,ex) stmts)))]
     [`(+ ,e1 ,e2)
      (if need-var
        (let ([tmp (gensym)])
          (let-values ([(ex1 stmts1) (flatten^ e1 need-var)]
                       [(ex2 stmts2) (flatten^ e2 need-var)])
            (values tmp (append stmts1 stmts2 `((assign ,tmp (+ ,ex1 ,ex2)))))))
        (let-values ([(ex1 stmts1) (flatten^ e1 #t)]
                     [(ex2 stmts2) (flatten^ e2 #t)])
          (values `(+ ,ex1 ,ex2) (append stmts1 stmts2))))]
     )))


(define flatten
  (lambda (e)
    (flatten^ e #t)))

(define unique-vars
  (lambda (e)
    (cond
      [(null? e) '()]
      [else (match (car e)
                   [`(assign ,e1 ,e2) (cons e1 (unique-vars (cdr e)))]
                   )])))

#|
(flatten `(let ([x 20])
  (+ (let ([x 22]) x) x)))

(flatten `(let ([x (read)])
  (let ([y (read)])
    (+ x (- y)))))

(let ([expr ((uniquify '())'(program
            (+ 52 (- 10))))])
            (flatten expr))

(flatten '(program
            (let ([x (+ (- 10) 11)])
                (+ x 41))))

(flatten '(program
            (let ([a 42])
              (let ([b a])
                b))))

|#
