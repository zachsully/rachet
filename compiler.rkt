#lang racket
(require "utilities.rkt")
(require "interp.rkt")

(provide r1-passes)

(define (uniquify^ alist)
  (lambda (e)
    (match e
      [(? symbol?) (lookup e alist)]
      [(? integer?) e]
      [`(let ([,x ,e^]) ,body)
        (let ([e^^ ((uniquify^ alist) e^)])
          (let ([newsym (gensym)])
            `(let ([,newsym ,e^^]) ,((uniquify^ `((,x . ,newsym) . ,alist)) body))))]
      [`(,op ,es ...)
       `(,op ,@(map (uniquify^ alist) es))]
      [`(program ,e)
       `(program ,((uniquify^ alist) e))]
      )))

(define uniquify (uniquify^ '()))

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


(define flatten
  (lambda (e)
    (match e
      [(? symbol?) (values e '())]
      [(? integer?) (values e '())]
      [`(let ([,x ,rhs]) ,body)
       (let-values ([(rhs_ex rhs_stmts) (flatten rhs)]
                    [(body_ex body_stmts) (flatten body)])
         (values body_ex (append rhs_stmts body_stmts `((assign ,x ,rhs_ex)))))]    
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
                   [`(assign ,e1 ,e2) (cons e1 (unique-vars (cdr e)))]
                   )])))


;; (display "Flatten Tests -----------------------------------")
;; (newline)
;; (flatten `(program 42))
;; (newline)
;; (flatten `(program (+ 1 2)))
;; (newline)
;; (flatten `(program
;;             (let ([x (+ (- 10) 11)])
;;               (+ x 41))))
;; (newline)
;; (flatten `(program (+ (- 1) (- 2))))
;; (newline)
;; (flatten `(program (let ([x 56])
;;                      (let ([y x])
;;                        y))))

(define (selection-instruction e) e)
(define (assign-homes e) e)
(define (patch-instructions e) e)
(define (print-x86 e) e)

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ;; ("select instructions",selection-instruction,interp-x86)
                    ;; ("assign homes",assign-homes,interp-x86)
                    ;; ("patch instructions",patch-instructions,interp-x86)
                    ;; ("print-x86",print-x86, #f)
                    ))

(interp-tests "r1p-passes" r1-passes interp-scheme "r1" (range 1 6))
(display "tests passed!") (newline)

;; (println `(Uniquify Tests -----------------------------------))
;; (uniquify `(program (let ([x 45]) (+ 3 x))))
;; (uniquify `(program (let ([x 45])
;;                             (let ([y 20]) (+ y x)))))
;; (uniquify `(program (let ([x (let ([y 30]) y)]) x)))
;; (uniquify `(program 1))
;; (uniquify `(program (let ([q (let ([z (let ([h 2]) 1)]) z)]) q)))
