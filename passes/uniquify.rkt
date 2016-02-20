#lang racket
(require "../utilities.rkt")
(provide uniquify)

;;
;; Uniquify
;;
;; uniquify : R2 -> R2'
;;
;; Pass makes sure all of the vars in the racket program are unique
;;


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
    [`(program ,e ,t)
     `(program ,((uniquify^ alist) e) ,t)]
    [`(,op ,es ...)
     `(,op ,@(map(uniquify^ alist) es))]
    ))))

(define (uniquify p)
  (match p
   [`(program (type ,t) ,e)
    `(program (type ,t) ,((uniquify^ '()) e))]))
