#lang racket
(require "../utilities.rkt")
(provide reveal-functions)


(define (rev-funk env e)
  (match e
   [`(let([,x ,e]) ,body)
    `(let([,x ,(rev-funk env e)])
       ,(rev-funk env body))]

   [`(define (,name (,vars : ,ts) ...) : ,t ,e)
    `(define (,name (,vars : ,ts) ...) : ,t ,(rev-funk env e))]

   [`(,op ,args ...)
    (if (not (eq? (lookup op env #f) #f))
	`(app ,(lookup op env #f) ,@(map (lambda (a) (rev-funk env a)) args))
	e)]

   [else e]
   ))

;; takes a definition and creates and assoc for the func name and its new name
(define (define-env d)
  (match d
   [`(define (,name (,vars : ,ts) ...) : ,t ,_)
    (cons name `(function-ref ,name))]))


(define (reveal-functions p)
  (match p
   [`(program ,t ,defs ... ,e)
    (let ([funk-env (map define-env defs)])
      (print funk-env)
      `(program ,t
		,@(map (lambda (d)
			 (rev-funk funk-env d))
		       defs)
		,(rev-funk funk-env e)))]))
