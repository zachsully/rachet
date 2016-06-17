#lang racket
(require "../utilities.rkt")
(require "../runtime-config.rkt")
(provide expose-allocation)

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
   [`(program ,vars (defines ,defs ...) ,stmts ...)
    (let* ([stmts^ (append-map stmts->allocation stmts)]
           [defines^ (map (lambda (def)
			    (match def
  			     [`(define (,f ,vars ...) : ,rt ,tmpVar ,stmts ...)
			      `(define (,f ,@vars)
				 :,rt ,tmpVar
				 ,@(append-map stmts->allocation stmts))
			      ]))
			  defs)])
      `(program ,(map get-var vars)
		(defines ,@defines^)
		,@(cons `(has-type (initialize ,(rootstack-size) ,(heap-size))
				   _) stmts^))
      )]))

(define (vector-setting var es)
 ((lambda (f)
    (foldl f `(() . 0) es))
  (lambda (e acc)
    (let ([tmp (gensym "void.")])
      (cons (append
	     (car acc)
	     `((assign ,tmp (has-type
			     (vector-set! (has-type ,(get-var var)
						    t)
					  ,(cdr acc)
					  (has-type ,(get-var e) t))
			     _))))
	    (+ 1 (cdr acc)))))))

(define (stmts->allocation stmt)
  (match stmt
   [`(assign ,var (has-type (vector ,vs ...) ,t))
    (let* ([vsets (vector-setting var vs)]
	   [bytes (+ 8 (* 8 (cdr vsets)))])
      `((if (has-type (collection-needed? ,bytes) Boolean)
	    ((collect ,bytes))
	    ())
	(assign ,var
		(has-type (allocate ,(length vs)
				    (Vector ,@(map get-type vs)))
			  ,t))
	,@(car vsets)))]
   [`(if ,cnd ,thn ,els)
    `((if ,cnd
	 ,(append-map stmts->allocation thn)
	 ,(append-map stmts->allocation els)))]
   [else `(,stmt)]))

(define (get-type var)
  (match var [`(has-type ,_ ,t) t]))

(define (get-var var)
  (match var
    [`(has-type ,v ,_) (get-var v)]
    [else var]))


;; THIS IS A BANDAID
;; take program and turns vector-sets! into assign... as well as adds them to
;; the variables
(define (void-vec-sets p)
  (match p
   [`(program ,vars ,def ,stmts ...)
    (let ([voids (foldr
                  (lambda (s acc)
                    (match s
                     [`(assign ,v (vector-set! ,_ ,_ ,_))
                      (cons (cons v 'Void) acc)]
                     [`,_ acc]))
                  '()
                  stmts)])
      `(program ,(append vars voids)
                ,def
                ,@(cons `(has-type (initialize ,(rootstack-size) ,(heap-size))
				   _) stmts)))]))
