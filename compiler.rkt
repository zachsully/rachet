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
      [`(program ,e)
       `(program ,((uniquify^ alist) e))]
      [`(,op ,es ...)
       `(,op ,@(map (uniquify^ alist) es))])))

(define uniquify (uniquify^ '()))


(define (flatten^ alist)
  (lambda (e)
    (match e
     [(? symbol?) (values alist (lookup e alist))]
      [(? integer?) (values alist `(return e))]
      [`(let ([,x ,e^]) ,body) (values alist x)]
      [`(program ,e)
        (values alist `(program ,((flatten^ alist) e)))]
      [`(,op ,es ...)
        (values alist `(,op ,@(map (flatten^ alist) es)))]
      )))

(define flatten (flatten^ '()))



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

;; (println `(Flatten Tests -----------------------------------))
;; ((flatten '()) `(program (+ 52 (- 10))))
;; ((flatten '()) `(program
;;                   (let ([x (+ (- 10 11))])
;;                     (+ x 41))))
;; ((flatten '()) `(program
;;                   (let ([a 24])
;;                     (let ([b a])
;;                       b))))

;; (println `(Uniquify Tests -----------------------------------))
;; (uniquify `(program (let ([x 45]) (+ 3 x))))
;; (uniquify `(program (let ([x 45])
;;                             (let ([y 20]) (+ y x)))))
;; (uniquify `(program (let ([x (let ([y 30]) y)]) x)))
;; (uniquify `(program 1))
;; (uniquify `(program (let ([q (let ([z (let ([h 2]) 1)]) z)]) q)))
