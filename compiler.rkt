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

(define (flatten e)
  (match e
    [(? integer?) (values e '())]
    [(? symbol?)  (values e '())]
    [`(let ([,x ,e]) ,body)
     (let-values ([(val ass) (flatten e)])
       (let-values ([(val^ ass^) (flatten body)])
         (values val^ (append ass (append ass^ `((assign ,x ,e)))))))]
    [`(program ,e)
     (let-values ([(val ass) (flatten e)])
       `(program ,@(append ass `((return ,val)))))]))

(println `(Flatten Tests -----------------------------------))
(flatten `(program 42))
(flatten `(program (let ([x 56]) x)))
(flatten `(program (let ([x 56])
                     (let ([y 42])
                       y))))
;; (flatten `(program `(let ([x 2]) x)))
;; (flatten `(program 22))
;; ((flatten '()) `(program (+ 52 (- 10))))
;; ((flatten '()) `(program
;;                   (let ([x (+ (- 10 11))])
;;                     (+ x 41))))
;; ((flatten '()) `(program
;;                   (let ([a 24])
;;                     (let ([b a])
;;                       b))))


(define (selection-instruction e) e)
(define (assign-homes e) e)
(define (patch-instructions e) e)
(define (print-x86 e) e)

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ;; ("flatten",flatten,interp-C)
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
