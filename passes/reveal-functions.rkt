#lang racket
(require "../utilities.rkt")
(provide reveal-functions)


(define (rev-funk v-env f-env e)
  (print v-env)
  (newline)
  (match e
   [`(let([,x ,e]) ,body)
    (let ([foo (rev-funk v-env f-env e)])
      `(let([,x ,foo])
	 ,(rev-funk (cons (cons x foo) v-env) f-env body)))]

   [`(define (,name (,vars : ,ts) ...) : ,t ,e)
    `(define (,name ,@(map (lambda (v t)
			     `(,v : ,t)) vars ts))
       : ,t
       ,(rev-funk v-env (foldr (lambda (v t a)
				 (if (is-function? t)
				     (cons `(,v . (function-ref ,v)) a)
				     a)) f-env vars ts)
		  e))]

   [`(,op ,args ...)
    (cond
     [(not (eq? (lookup op f-env #f) #f))
      `(app ,(lookup op f-env) ,@(map (lambda (a)
					(rev-funk v-env f-env a)) args))]
     [(not (eq? (lookup (lookup op v-env op) f-env #f) #f))
      `(app ,(lookup (lookup op v-env) f-env)
	    ,@(map (lambda (a)
		     (rev-funk v-env f-env a)) args))]
     [else `(,op ,@(map (lambda (a) (rev-funk v-env f-env a)) args))])]

   [else e]
   ))

;; returns true if the type is that of a funciton
(define (is-function? t)
  (cond
   [(not (list? t)) #f]
   [else (match (reverse t)
		[`(,_ -> ,_ ...) #t]
		[else #f])]))

;; takes a definition and creates and assoc for the func name and its new name
(define (define-env d)
  (match d
   [`(define (,name (,vars : ,ts) ...) : ,t ,_)
    (cons name `(function-ref ,name))]))


(define (reveal-functions p)
  (match p
   [`(program ,t ,defs ... ,e)
    (let ([funk-env (map define-env defs)])
      `(program ,t
		,@(map (lambda (d)
			 (rev-funk '() funk-env d))
		       defs)
		,(rev-funk '() funk-env e)))]))
