#lang racket
(require "../utilities.rkt")

(provide flatten)

(define flatten
  (lambda (e)
    (match e
      [(? symbol?) (values e '())]
      [(? integer?) (values e '())]
      [`(let ([,x ,rhs]) ,body)
       (let-values ([(rhs_ex rhs_stmts) (flatten rhs)]
                    [(body_ex body_stmts) (flatten body)])
         (values body_ex (append rhs_stmts `((assign ,x ,rhs_ex)) body_stmts)))]
      [`(program ,e) (let-values ([(ex rhs) (flatten e)])
                       (let ([vars (unique-vars rhs)])
                         `(program ,vars ,@(append rhs `((return ,ex))))))]
      [`(read) (let ([tmp (gensym)])
                 (values tmp `((assign ,tmp (read)))))]
      [`(- ,es) (let ([tmp (gensym)])
                  (let-values ([(ex stmts) (flatten es)])
                    (values tmp (append stmts `((assign ,tmp (- ,ex)))))))]
      [`(+ ,e1 ,e2) (let ([tmp (gensym)])
                      (let-values ([(ex1 stmts1) (flatten e1)]
                                   [(ex2 stmts2) (flatten e2)])
                         (values tmp (append stmts1 stmts2 `((assign ,tmp (+ ,ex1 ,ex2)))))))]
           )))

(define unique-vars
  (lambda (e)
    (cond
      [(null? e) '()]
      [else (match (car e)
              [`(assign ,e1 ,e2) (cons e1 (unique-vars (cdr e)))])])))


(define (flatten^ need-arg)
  (lambda (e)
    (match e
      [(? integer?) (values e '())]
      [(? symbol?)  (values e '())]
      [`(let ([,x ,e]) ,body)
        (cond
          [need-arg
            (let-values ([(expr ass) ((flatten^ #t) e)])
              (let-values ([(expr^ ass^) ((flatten^ #f) body)])
                (values expr^
                        (append ass ass^ `((assign ,x ,expr))))))]
          [else
           (let-values ([(expr ass) ((flatten^ need-arg) e)])
              (values expr ass))])]
      [`(program ,e)
        (let-values ([(expr ass) ((flatten^ need-arg) e)])
          `(program ,expr ,@(append ass `((return ,expr)))))]
      [`(,op ,es ...)
        (cond
          [need-arg
           (let ([temp (gensym)])
             (let-values ([(exprs asses) (map2 (flatten^ need-arg) es)])
               (values temp
                       (append asses
                               `((assign ,temp (,op ,@exprs)))))))]
          [else
            (let-values ([(exprs asses) (map2 (flatten^ need-arg) es)])
              (values `(,op ,@exprs)
                      asses))])]
      )))
