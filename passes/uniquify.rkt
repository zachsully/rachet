#lang racket
(require "../utilities.rkt")

(provide uniquify)

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
