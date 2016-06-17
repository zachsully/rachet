#lang racket
(require "../utilities.rkt")
(require "typecheck.rkt")
(require racket/pretty)
(provide flatten)

;;
;; Flatten
;;
;; flatten : R2 -> C2
;;
;; Takes a racket program in an AST and flattens it into a sequential one
;;


(define (flatten^ expr need-var)
  (match expr
   [`(has-type ,e ,t)
    #:when (or (symbol? e)
	       (integer? e)
	       (boolean? e))
    (values expr '())]

   [`(has-type (eq? ,e1 ,e2) ,t)
    (if
     need-var
     (let ([tmp (gensym "eq.")])
       (let-values ([(e1_ex e1_stmts) (flatten^ e1 need-var)]
		    [(e2_ex e2_stmts) (flatten^ e2 need-var)])
	 (values `(has-type ,tmp ,t)
		 (append e1_stmts
			 e2_stmts
			 `((assign ,tmp (has-type (eq? ,e1_ex ,e2_ex)
						  Boolean)))))))
     (let-values ([(e1_ex e1_stmts) (flatten^ e1 need-var)]
		  [(e2_ex e2_stmts) (flatten^ e2 need-var)])
       (values `(has-type (eq? ,e1_ex ,e2_ex) ,t)
	       (append e1_stmts e2_stmts))))]

   [`(has-type (let ([,x ,rhs]) ,body) ,t)
    (let-values ([(rhs_ex rhs_stmts) (flatten^ rhs #f)]
		 [(body_ex body_stmts) (flatten^ body need-var)])
      (values body_ex
	      (append rhs_stmts `((assign ,x ,rhs_ex)) body_stmts)))]

   [`(has-type (read) ,t)
    (let ([tmp (gensym "read.")])
      (values `(has-type ,tmp ,t) `((assign ,tmp (has-type (read) ,t)))))]

   [`(has-type (- ,es) ,t)
    (if need-var
	(let ([tmp (gensym "neg.")])
	  (let-values ([(ex stmts) (flatten^ es need-var)])
	    (values `(has-type ,tmp ,t)
		    (append stmts `((assign ,tmp (has-type (- ,ex) ,t)))))))
	(let-values ([(ex stmts) (flatten^ es need-var)])
	  (values `(has-type (- ,ex) ,t) stmts)))]

   [`(has-type (+ ,e1 ,e2) ,t)
    (if need-var
	(let ([tmp (gensym "plus.")])
	  (let-values ([(ex1 stmts1) (flatten^ e1 need-var)]
		       [(ex2 stmts2) (flatten^ e2 need-var)])
	    (values `(has-type ,tmp ,t)
		    (append stmts1 stmts2
			    `((assign ,tmp (has-type (+ ,ex1 ,ex2)
						     Integer)))))))
	(let-values ([(ex1 stmts1) (flatten^ e1 #t)]
		     [(ex2 stmts2) (flatten^ e2 #t)])
	  (values `(has-type (+ ,ex1 ,ex2) ,t) (append stmts1 stmts2))))]

   [`(has-type (if ,cnd ,thn ,els) ,t)
    (let-values ([(cnd_ex cnd_stmts) (flatten^ cnd #t)]
		 [(thn_ex thn_stmts) (flatten^ thn #t)]
		 [(els_ex els_stmts) (flatten^ els #t)])
      (let ([tmp (gensym "if.")])
	(values `(has-type ,tmp ,t)
		(append cnd_stmts
			`((if (eq? (has-type #t Boolean) ,cnd_ex)
			      ,(append thn_stmts `((assign ,tmp ,thn_ex)))
			      ,(append els_stmts `((assign ,tmp ,els_ex))))
			  )))))]

   [`(has-type (or ,e1 ,e2) ,t)
    (flatten^ `(has-type (if ,e1 (has-type #t Boolean) e2) ,t)
	      need-var)]

   [`(has-type (and ,e1 ,e2) ,t)
    (flatten^ `(has-type (if ,e1 ,e2 (has-type #f Boolean)) ,t)
	      need-var)]

   [`(has-type (not ,es) ,t)
    (if need-var
	(let ([tmp (gensym "not.")])
	  (let-values ([(es_ex es_stmts) (flatten^ es need-var)])
	    (values `(has-type ,tmp ,t)
		    (append es_stmts
			    `((assign ,tmp (has-type (not ,es_ex)
						     Boolean)))))))
	(let-values ([(es_ex es_stmts) (flatten^ es need-var)])
	  (values `(has-type (not ,es_ex) ,t) es_stmts)))]

   [`(has-type (vector ,args ...) ,t)
    (let ([args^
	   (foldl (lambda (x acc)
		    (let-values ([(ex st) (flatten^ x need-var)])
		      (cons
		       (append (car acc) `(,ex))
		       (append st (cdr acc)))))
		  (cons '() '())
		  args)]
	  [tmp (gensym "vec.")])
      (values `(has-type ,tmp ,t)
	      (append (cdr args^)
		      `((assign ,tmp (has-type (vector ,@(car args^)) ,t))))))]


   [`(has-type (vector-ref ,arg ,i) ,t)
    (let ([tmp (gensym "vref.")])
      (let-values ([(ex stmts) (flatten^ arg need-var)])
	(values `(has-type ,tmp ,t)
		(append stmts
			`((assign ,tmp
				  (has-type (vector-ref ,ex ,i) ,t)))))))]

   [`(has-type (vector-set! ,arg ,i ,narg) ,t)
    (if need-var
	(let ([tmp (gensym "vset.")])
	  (let-values ([(exA stmtsA) (flatten^ arg #t)]
		       [(exN stmtsN) (flatten^ narg need-var)])
	    (values `(has-type ,tmp ,t)
		    (append stmtsA
			    stmtsN
			    `((assign ,tmp (has-type (vector-set! ,exA ,i ,exN)
						     _)))))))
	(let-values ([(exA stmtsA) (flatten^ arg need-var)]
		     [(exN stmtsN) (flatten^ narg need-var)])
	  (values `(has-type (vector-set! ,exA ,i ,exN) ,t)
		  (append stmtsA stmtsN))))]

   [`(has-type (function-ref ,f) ,t)
    (let ([tmp (gensym "funk-ref.")])
      (values `(has-type ,tmp ,t)
	      `((assign ,tmp (has-type (function-ref ,f) ,t)))))]

   [`(has-type (app ,f ,args ...) ,t)
    (let ([args^
	   (foldl (lambda (x acc)
		    (let-values ([(ex st) (flatten^ x need-var)])
		      (cons
		       (append (car acc) `(,ex))
		       (append st (cdr acc)))))
		  (cons '() '())
		  args)]
	  [tmp (gensym "app-funk.")])
      (let-values ([(exF stmtsF) (flatten^ f need-var)])
	(values `(has-type ,tmp ,t)
		(append stmtsF
			(cdr args^)
			`((assign ,tmp (has-type (app ,exF ,@(car args^))
						 ,t)))))))]
   ))

(define (flatten-define d)
  (match d
    [`(define (,name (clos : _) (,vars : ,ts) ...) : ,t ,e)
     (let-values ([(ex stmts) (flatten^ e #t)])
       `(define (,name [clos : _] ,@(map (lambda (v t)
					   `[,v : ,t]) vars ts))
          : ,t
          ,(remove-duplicates (unique-vars stmts '()))
          ,@(append stmts `((return ,ex)))))]))

;; MAIN FLATTEN funk
(define (flatten p)
  (match p
    [`(program ,defs ... ,expr)
     (let-values ([(ex rhs) (flatten^ expr #t)])
       (let ([vars (remove-duplicates (unique-vars rhs '()))]
             [defs^ (map flatten-define defs)])
         `(program ,vars
                   (defines ,@defs^)
                   ,@(append rhs `((return ,ex))))))]))

(define unique-vars-helper
  (lambda (instr)
    (match instr
      [`(assign ,e1 ,e2) `(,e1)]
      [`(if ,cnd ,thn ,els) (append (unique-vars thn '())
                                    (unique-vars els '()))]
      [else '()])))

(define unique-vars
  (lambda (instrs ans)
    (if (null? instrs)
        ans
        (unique-vars (cdr instrs)
                     (append ans
                             (unique-vars-helper (car instrs)))))
    ))
