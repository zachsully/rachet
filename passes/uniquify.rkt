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

    [`(define (,name (,vars : ,ts) ...) : ,t ,e)
     (let ([var-env (map (lambda (v)
			   (cons v (gensym (string-append
					    (symbol->string v) "."))))
			 vars)])
       `(define (,(lookup name env) ,@(map (lambda (v t)
					     `(,(lookup v var-env) : ,t))
					   vars ts))
	  :
	  ,t
	  ,(uniquify^ (append var-env env) e)))]

    [`(,op ,es ...)
     `(,(lookup op env op) ,@(map (lambda (e) (uniquify^ env e)) es))]

    ))

;; takes a definition and creates and assoc for the func name and its new name
(define (define-unique d)
  (match d
   [`(define (,name (,vars : ,ts) ...) : ,t ,_)
    (cons name (gensym (string-append (symbol->string name) ".")))]))

(define (uniquify p)
  (match p
   [`(program ,t ,defs ... ,e)
    (let ([defs-env (map define-unique defs)])
      `(program ,t
		,@(map (lambda (d) (uniquify^ defs-env d)) defs)
		,(uniquify^ defs-env e)))]))
