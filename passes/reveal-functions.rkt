#lang racket
(provide reveal-functions)
(require racket/pretty)

(define function-name
  (lambda (defs)
    (match defs
           ['() '()]
           [`((define (,f ,vars ...) : ,rt ,expr) ,cdr_defs ...)
             (cons f (function-name cdr_defs))])))


(define (reveal-functions^ exp fname)
  (match exp
   [`(define (,f ,vars ...) : ,rt ,expr)
      (let ([expr^ (reveal-functions^ expr fname)])
	`(define (,f ,@vars) : ,rt ,expr^))]
   [`(has-type ,e ,t)
    `(has-type
      ,(match e
        [`,x #:when (member x fname) `(function-ref ,x)]

	[(? symbol?) e]

	[(? integer?) e]

	[(? boolean?) e]

	[`(lambda: (,args ...) : ,tt ,expr)
	 `(lambda: (,@args) : ,tt ,(reveal-functions^ expr fname))]

	[`(let ([,lhs ,rhs]) ,body)
	 (let ([rhs^ (reveal-functions^ rhs fname)]
	       [body^ (reveal-functions^ body fname)])
	   `(let ([,lhs ,rhs^]) ,body^))]

	[`(if ,cnd ,thn ,els)
	 (let ([cnd^ (reveal-functions^ cnd fname)]
	       [thn^ (reveal-functions^ thn fname)]
	       [els^ (reveal-functions^ els fname)])
	   `(if ,cnd^ ,thn^ ,els^))]

	[`(vector ,args ...)
	 (let ([args^ (map (lambda (a) (reveal-functions^ a fname)) args)])
	   `(vector ,@args^))]

	[`(vector-set! ,vec ,index ,val)
	 (let ([val^ (reveal-functions^ val fname)])
	   `(vector-set! ,vec ,index ,val^))]

	[`(vector-ref ,vec ,index) `(vector-ref ,(reveal-functions^ vec fname)
						,index)]

	[`(,op ,args ...) #:when (member op '(+ - eq? read or and not))
	 (let ([args^ (map (lambda (a) (reveal-functions^ a fname)) args)])
	   `(,op ,@args^))]

	[`(,op ,args ...)
	 (let ([op^ (reveal-functions^ op fname)]
	       [args^ (map (lambda (a) (reveal-functions^ a fname)) args)])
	   `(app ,op^ ,@args^))]
	)
      ,t)]))


(define reveal-functions
  (lambda (e)
    (match e
     [`(program ,defs ... ,exprs)
      (let* ([func-name (function-name defs)]
	     [defs^ (map (lambda (d) (reveal-functions^ d func-name)) defs)]
	     [exprs^ (reveal-functions^ exprs func-name)])
	`(program ,@defs^ ,exprs^))])))
