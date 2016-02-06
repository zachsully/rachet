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
         ,(if (null? es) #t (expand-macros `(and ,@es)))
         #f)]
   [`(or ,e ,es ...)
    `(if ,(expand-macros e)
         #t
         ,(if (null? es) #f (expand-macros `(or ,@es))))]
   [`(eq? ,x ,y) `(eq ,(expand-macros x) ,(expand-macros y))]))

(expand-macros `(eq? (or #t #t) (and #f #t)))
