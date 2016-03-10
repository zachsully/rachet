#lang racket
(require "../utilities.rkt")
(require "../uncover-types.rkt")
(require "../runtime-config.rkt")
(provide expose-allocation)
(require racket/pretty)

;;
;; Expose-Allocation
;;
;; expose-allocation : C3 -> C3
;;
;; Pass:
;; > inserts intialize statement at the top (setting up garbage collector)
;; > changes the form
;;  (assign <lhs> (vector <f> .. <e>))
;;           -to-
;;  (if (collection-needed? <bytes>)
;;      ((collect <bytes>))
;;      ())
;;  (assign <lhs> (allocate <len> <type>))
;;  (vector-set! <lhs> 0 <f>)
;;   ..
;;  (vector-set! <lhs> (len -1) <e>)
;;
;; > a special case: that removes the assignment statment for if's that return
;; void

(define (expose-allocation p)
  (match p
   [`(program ,vars ,t (defines ,defs ...) ,stmts ...)
    (let* ([all-types (uncover-types p)]
	   [define-types (cadr all-types)]
           [stmts^ (stmts->allocation stmts (last all-types))]
           [defines^ (map (lambda (def types)
			    (match def
  			     [`(define (,f ,vars ...) : ,rt ,tmpVar ,exprs ...)
			      `(define (,f ,@vars)
				 :,rt ,tmpVar
				 ,@(stmts->allocation exprs types))
			      ]))
			  defs define-types)])
      (void-vec-sets
        `(program ,vars
                  ,t
                  (defines ,@defines^)
                  ,@stmts^))
      )]))

(define (vector-setting var es)
 ((lambda (f)
    (foldl f `(() . 0) es))
  (lambda (e acc)
    (let ([tmp (gensym "void.")])
      (cons (append (car acc)
                    `((assign ,tmp (vector-set! ,var ,(cdr acc) ,e))))
	    (+ 1 (cdr acc)))))))

(define (stmts->allocation stmts types)
  ((lambda (f)
     (foldr f '() stmts))
   (lambda (stmt acc)
     (match stmt
      [`(assign ,var (vector ,es ...))
       (let* ([vsets (vector-setting var es)]
	      [bytes (+ 8 (* 8 (cdr vsets)))])
	 (append `((if (collection-needed? ,bytes)
		       ((collect ,bytes))
		       ())
		   (assign ,var
			   (allocate ,(length es)
				     ,(lookup var types)))
		   ,@(car vsets))
		 acc))]
      [`,_ (append `(,stmt) acc)]))))

;; THIS IS A BANDAID
;; take program and turns vector-sets! into assign... as well as adds them to
;; the variables
(define (void-vec-sets p)
  (match p
   [`(program ,vars ,t ,def ,stmts ...)
    (let ([voids (foldr
                  (lambda (s acc)
                    (match s
                     [`(assign ,v (vector-set! ,_ ,_ ,_))
                      (cons (cons v 'Void) acc)]
                     [`,_ acc]))
                  '()
                  stmts)])
      `(program ,(append vars voids)
                ,t
                ,def
                ,@(cons `(initialize ,(rootstack-size) ,(heap-size)) stmts)))]))
