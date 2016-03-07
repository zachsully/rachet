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

    [`(read) e]

    [`(+ ,left ,right)
     `(+ ,(uniquify^ env left)
	 ,(uniquify^ env right))]

    [`(- ,expr)
     `(- ,(uniquify^ env expr))]

    [`(not ,expr)
     `(not ,(uniquify^ env expr))]

    [`(and ,left ,right)
     `(and ,(uniquify^ env left)
	   ,(uniquify^ env right))]

    [`(or ,left ,right)
     `(or ,(uniquify^ env left)
	  ,(uniquify^ env right))]

    [`(let ([,x ,e]) ,body)
     (let ([newsym (gensym "tmp.")])
      `(let([,newsym ,(uniquify^ env e)])
	 ,(uniquify^ (cons (cons x newsym) env) body)))]

    [`(eq? ,left ,right)
     `(eq? ,(uniquify^ env left)
	   ,(uniquify^ env right))]

    [`(if ,cnd ,thn ,els)
     `(if ,(uniquify^ env cnd)
	  ,(uniquify^ env thn)
	  ,(uniquify^ env els))]

    [`(vector ,args ...)
     `(vector ,@(map (lambda (a) (uniquify^ env a)) args))]

    [`(vector-ref ,arg ,i)
     `(vector-ref ,(uniquify^ env arg)
		  ,i)]

    [`(vector-set! ,arg ,i ,narg)
     `(vector-set! ,(uniquify^ env arg)
		   ,i
		   ,(uniquify^ env narg))]

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
     (let ([op^ (uniquify^ env op)])
       `(,(lookup op^ env op^)
	 ,@(map (lambda (e) (uniquify^ env e)) es)))]

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
