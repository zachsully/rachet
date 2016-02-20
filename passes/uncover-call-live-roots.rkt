#lang racket
(provide uncover-call-live-roots)

(define (uncover-call-live-roots p)
  (match p
   [`(program ,vars ,t ,stmts ...)
    (let ([root-afters (live-after-roots stmts)])
      `(program ,(map (lambda (vs) (car vs)) vars)
                ,t
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
