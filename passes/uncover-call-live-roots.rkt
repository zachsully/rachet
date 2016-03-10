#lang racket
(provide uncover-call-live-roots)

(define (uncover-call-live-roots p)
  (match p
   [`(program ,vars ,t (defines ,defs ...) ,stmts ...)
    (let ([root-afters (live-after-roots stmts)]
	  [defs^       (map uncover-call-live-roots defs)])
      `(program ,vars
                ,t
		(defines ,@defs)
                ,@(apply-live-roots root-afters)))]
   [`(define (,f ,vars ...) : ,rt ,gen-vars ,stmts ...)
    (let ([root-afters (live-after-roots stmts)])
      `(define (,f ,vars ...)
	 : ,rt
	 ,gen-vars
	 ,@(apply-live-roots root-afters)))]))

(define (apply-live-roots stmts)
 ((lambda (f)
    (cdr (map f stmts)))
  (lambda (s)
    (match s
     [`(,live . (if (collection-needed? ,b) (,thn) ,els))
      `(if (collection-needed? ,b)
           ((call-live-roots ,live ,thn))
           ,els)]
     [`,_ (cdr s)]))))

(define (live-after-roots stmts)
 ((lambda (f)
    (reverse (foldl f `((() . ())) stmts)))
  (lambda (stmt acc)
    (match stmt
     [`(assign ,var (allocate ,_ ,_))
      (cons (cons (append `(,var)
                           (caar acc)) stmt) acc)]
     [`,_ (cons (cons (caar acc) stmt) acc)]))))
