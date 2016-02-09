#lang racket
(require "../utilities.rkt")
(provide uniquify)

(define uniquify^
 (lambda (alist)
  (lambda (e)
   (match e
    [(? symbol?) (lookup e alist)]
    [(? integer?) e]
    [(? boolean?) e]
    [`(let([,x ,e]) ,body)
     (let ([newsym (gensym "tmp")])
      `(let([,newsym ,((uniquify^ alist) e)])
                     ,((uniquify^ (cons (cons x newsym) alist)) body)))]
    [`(program ,e)
     `(program ,((uniquify^ alist) e))]
    [`(,op ,es ...)
     `(,op ,@(map(uniquify^ alist) es))]
    ))))

(define uniquify
  (lambda (e)
    ((uniquify^ '()) e)))

#|

((uniquify^ '()) '(program
                    (let ([x 32])
                    (+ (let ([x 10]) x) x))))

((uniquify^ '()) '(program
                     (let ([x (let ([x 4])
                            (+ x 1))])
                    (+ x 2))))

((uniquify^ '()) '(program
   (let ([x 32])
     (+ (let ([y 10]) x) (let ([y 25]) y)))))

((uniquify^ '()) '(program
   (let ([x 32])
     (+ (let ([x 5])
          (+ (let ([x 4])
               (+ x x)) x) x) x))))
|#
