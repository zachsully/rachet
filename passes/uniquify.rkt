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


(define (uniquify^ env e)
  (match e
    [(? symbol?) (lookup e env)]
    [(? integer?) e]
    [(? boolean?) e]
    [`(let([,x ,e]) ,body)
     (let ([newsym (gensym "tmp.")])
      `(let([,newsym ,(uniquify^ env e)])
                     ,(uniquify^ (cons (cons x newsym) env) body)))]
    [`(,op ,es ...)
     `(,op ,@(map (lambda (e) (uniquify^ env e)) es))]
    ))

(define (uniquify p)
  (match p
   [`(program ,e)
    `(program ,(uniquify^ '() e))]))
