#lang racket
(require racket/pretty)
(provide uncover-live)

;;
;; Uncover-live
;;
;; uncover-live : x86' -> x86' x live-after
;;
;; Pass takes an x86' program and returns it with a set of variables that
;; are live after each instruction
;;

(define (uncover-live e)
  (match e
   [`(program ,vs ,type (defines ,defs ...) ,instrs ...)
    `(program (,vs
	       ,(liveness-analysis instrs)
	       ,(map uncover-live defs))
	      ,type
	      (defines ,@defs)
	      ,@instrs)]

   [`(define (,f) ,num-locals (,vars ,max-stack) ,locals ,instrs ...)
    (liveness-analysis instrs)]))



(define live-set
  (lambda (src)
    (match src
           [`(var ,x) (set x)]
           [`(byte-reg ,x) (set 'rax)]
           [`(reg ,x) (set x)]
	   [`(offset ,loc ,_) (live-set loc)]
           [else (set)])))



(define (liveness-analysis instrs)
  ((lambda (f)
     (remove-last (foldr f `((() . ,(set))) instrs)))
   (lambda (instr liveness)
     (let ([live (cdar liveness)])
       (match instr
        [`(,op ,src ,dst)
	 #:when (and (member op '(movq movzbq xorq))
		     (or (equal? (car src) 'offset)
			 (equal? (car dst) 'offset)))
	 (let ([instr-liveness
		`(,instr . ,(set-union live (live-set dst) (live-set src)))])
	   (cons instr-liveness liveness))]

	[`(,op ,src ,dst) #:when (member op '(movq movzbq xorq))
	 (let ([instr-liveness
		`(,instr . ,(set-union (set-subtract live (live-set dst))
				       (live-set src)))])
	   (cons instr-liveness liveness))]

	[`(addq ,src ,dst)
	 (let ([instr-liveness
		`(,instr . ,(set-union live
				       (live-set src)
				       (live-set dst)))])
	   (cons instr-liveness liveness))]

	[`(leaq ,func-ref ,dst)
	 (let ([instr-liveness
		`(,instr . ,(set-subtract live (live-set dst)))])
	   (cons instr-liveness liveness))]

	[`(if (eq? ,a ,b) ,thn ,els)
	 (let* ([thn^   (liveness-analysis thn)]
		[lb-thn (if (null? thn^) (set) (cdar thn^))]
		[els^   (liveness-analysis els)]
		[lb-els (if (null? els^) (set) (cdar els^))]
		[instr-liveness
		 `((if (eq? ,a ,b)
		       ,thn^
		       ,els^)
		   . ,(set-union lb-thn
				 lb-els
				 (live-set a)
				 (live-set b)))])
	   (cons instr-liveness liveness))]

	[`(,op ,arg) #:when (member op '(setl sete))
	 (let ([instr-liveness `(,instr . ,live)])
	   (cons instr-liveness liveness))]

	[`(negq ,arg)
	 (let ([instr-liveness `(,instr . ,(set-union live (live-set arg)))])
	   (cons instr-liveness liveness))]

	[`(,op ,arg) #:when (member op '(callq indirect-callq))
	 (let ([instr-liveness `(,instr . ,(set-subtract live (set 'rax)))])
	   (cons instr-liveness liveness))]

	[`(,op ,a ,b) #:when (member op '(cmpq))
	 (let ([instr-liveness `(,instr . ,(set-union live
						      (live-set a)
						      (live-set b)))])
	   (cons instr-liveness liveness))]
	)))))

(define (remove-last ls)
  (cond
   [(null? ls) ls]
   [else (reverse (cdr (reverse ls)))]))
