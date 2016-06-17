#lang racket
(require racket/pretty)
(provide uncover-call-live-roots)

(define (uncover-call-live-roots p)
  (match p
   [`(program ,vars (defines ,defs ...) ,stmts ...)
    (let ([defs^ (map uncover-call-live-roots defs)])
      `(program ,vars
		(defines ,@defs^)
                ,@(apply-live-roots (live-after-roots stmts))))]
   [`(define (,f ,vars ...) : ,rt ,gen-vars ,stmts ...)
    `(define (,f ,@vars) : ,rt
       ,gen-vars
       ,@(apply-live-roots (live-after-roots stmts)))]))

(define (apply-live-roots stmts)
  ;; (pretty-print stmts) (newline)
 ((lambda (f)
    (cdr (map f stmts)))
  (lambda (s)
    (match s
     [`(,live . (if (has-type (collection-needed? ,b) Boolean) ,thn ,els))
      `(if (has-type (collection-needed? ,b) Boolean)
           ((has-type (call-live-roots ,live ,@thn) _))
           ,els)]
     [`(,live . (if ,cnd ,thn ,els))
      `(if ,cnd
	   ,(apply-live-roots (live-after-roots thn))
	   ,(apply-live-roots (live-after-roots els)))]
     [else (cdr s)]))))

(define (live-after-roots stmts)
 (reverse (foldl live-after-roots-helper `((() . ())) stmts)))

(define (live-after-roots-helper stmt acc)
 (match stmt
  [`(assign ,var (has-type (allocate ,_ ,_) ,_))
   (cons (cons (append `(,var) (caar acc)) stmt) acc)]
  [`,_ (cons (cons (caar acc) stmt) acc)]))
