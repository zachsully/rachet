#lang racket
(require "../utilities.rkt")
(provide convert-to-closures)

(define (convert-to-closures p)
  (match p
   [`(program ,defs ... ,expr)
    (let-values ([(defs^ expr^) (map2 c-c (append defs `(,expr)))])
      `(program ,@(append* defs^) ,@expr^))]))

(define (c-c ast)
  (match ast
   [`(define (,f ,vars ...) : ,rt ,expr^)
      (let-values ([(d e^) (c-c expr^)])
	(values d `(define (,f [clos : _] ,@vars) : ,rt ,e^)))]

   [`(has-type ,expr ,t) #:when (or (symbol? expr)
				    (integer? expr)
				    (boolean? expr))
    (values '() ast)]

   [`(has-type (function-ref ,f) ,t)
    (values '() `(has-type (vector (has-type (function-ref ,f) _))
			   (Vector ,(cons 'Clos t))))]

   [`(has-type (lambda: ([,vs : ,ts] ...) : ,tt ,expr) ,t)
    (let-values ([(defs expr^) (c-c expr)])
      (let ([name (gensym "clos.")]
	    [fv   (free-vars vs expr)]
	    [args (map (lambda (v t) `(,v : ,t)) vs ts)])
	(values (append (list `(define (,name [clos : _] ,@args) : ,tt
				 ,(define-closure fv (length fv) expr^)))
			defs)
		`(has-type (vector (has-type (function-ref ,name) _) ,@fv) _))))]

   [`(has-type (let ([,lhs ,rhs]) ,body) ,t)
    (let-values ([(rdef re) (c-c rhs)]
		 [(bdef be) (c-c body)])
      (values (append rdef bdef) `(has-type (let ([,lhs ,re]) ,be) ,t)))]

   [`(has-type (vector-ref ,exp ,i) ,t)
    (let-values ([(def e) (c-c exp)])
      (values def `(has-type (vector-ref ,e ,i) ,t)))]

   [`(has-type (vector-set! ,exp ,i ,nexp) ,t)
    (let-values ([(def e)   (c-c exp)]
		 [(ndef ne) (c-c nexp)])
      (values (append def ndef) `(has-type (vector-set! ,e ,i ,ne) ,t)))]

   [`(has-type (,op ,args ...) ,t)
    #:when (member op '(+ - eq? read and or not if vector))
    (let-values ([(defs es) (map2 c-c args)])
      (values (append* defs) `(has-type (,op ,@es) ,t)))]

   [`(has-type (app ,a ,as ...) ,t)
    (let-values ([(defs es) (map2 c-c as)]
		 [(d    e)  (c-c a)])
      (let* ([var (gensym "c.")]
	     [vt `(has-type ,var ,(type-of e))])
	(values (append d (append* defs))
	      `(has-type
		(let ([,var ,e])
		  (has-type (app (has-type (vector-ref ,vt 0)
					   _) ,vt ,@es) ,t))
		,t))))]))

;; builds a closure from free-vars and expr
(define (define-closure fv n expr)
  (cond
   [(zero? n) expr]
   [else `(has-type
	   (let ([,(value-of (car fv)) (has-type (vector-ref
						  (has-type clos _),n)
						,(type-of (car fv)))])
	     ,(define-closure (cdr fv) (sub1 n) expr))
	   ,(type-of expr))]))

(define (type-of ast)
  (match ast
   [`(has-type ,_ ,t) t]))

(define (value-of ast)
  (match ast
   [`(has-type ,v ,_) v]
   [else ast]))

;; takes and expression and returns the free variables in it
(define (free-vars env ast)
  (match ast
   [`(has-type ,expr ,t)
    (match expr
     [(? symbol?)
      (if (member expr env) '() (list `(has-type ,expr ,t)))]

     [(? integer?) '()]

     [(? boolean?) '()]

     [`(lambda: ([,vs : ,ts] ...) : ,tt ,expr^)
      (free-vars (append vs env) expr^)]

     [`(define (,f [,vs : ,ts] ...) : ,rt ,expr^)
      (free-vars vs expr^)]

     [`(let ([,lhs ,rhs]) ,body)
      (append (free-vars env rhs)
	      (free-vars (cons lhs env) body))]

     [`(vector-set! ,vec ,index ,val)
      (append (free-vars env vec)
	      (free-vars env val))]

     [`(vector-ref ,vec ,index) (free-vars env vec)]

     [`(,op ,args ...)
      #:when (member op '(+ - read vector and or not if app eq?))
      (append-map (lambda (a) (free-vars env a)) args)]
     )]))
