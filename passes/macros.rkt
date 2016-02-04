#lang racket
(require "../interp.rkt")
(provide macros)

;; This pass expands macros
;; Macros:
;; * and
;; * or
(define (macros p)
  (match p
   [`(program ,e) `(program ,(expand-macros e))]))

(define (expand-macros e)
  (match e
   [(? symbol?) e]
   [(? integer?) e]
   [(? boolean?) e]
   [`(let ([,x ,rhs]) ,body)
    `(let ([,x ,(expand-macros rhs)])
       ,(expand-macros body))]
   [`(read) e]
   [`(- ,e) `(- ,(expand-macros e))]
   [`(+ ,x ,y) `(+ ,(expand-macros x) ,(expand-macros y))]
   [`(if ,cnd ,thn ,els)
    `(if ,(expand-macros cnd)
         ,(expand-macros thn)
         ,(expand-macros els))]
   [`(and ,e ,es ...)
    `(if ,(expand-macros e)
         ,(map expand-macros es)
         #f)]
   [`(or ,e ,es ...)
    `(if ,(expand-macros e)
         #t
         ,(map expand-macros es))]))

((lambda (ps)
   (map (lambda (p)
          (display p)
          (interp-S1 p)
          (newline)
          (display (macros p))
          (interp-S1 (macros p))
          (newline)) ps))
 `((program 42)
   (program (+ 1 2))
   (program (or #t #f #t))
   (program (and #t #f #t))))
