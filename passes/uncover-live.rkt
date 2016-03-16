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
  (remove-last (foldr liveness-analysis^ `((() . ,(set))) instrs)))

(define (liveness-analysis^ instr liveness)
  (let ([live (cdar liveness)])
    (match instr
     [`(,op ,src ,dst) #:when (member op '(movq movzbq xorq))
      (cond
       ;; special case for vector-set!
       [(equal? src `(int -1)) (cons `(,instr . ,live) liveness)]
       ;; special case for vector-2-vector
       [(or (equal? 'offset (car src))
	    (equal? 'offset (car dst)))
	(cons `(,instr . ,(set-union live (live-set dst) (live-set src)))
	      liveness)]
       [else
	(cons `(,instr . ,(set-union (set-subtract live (live-set dst))
				     (live-set src)))
	      liveness)])]

     [`(addq ,src ,dst)
      (cons `(,instr . ,(set-union live (live-set src) (live-set dst)))
	    liveness)]

     [`(leaq ,func-ref ,dst)
      (let ([instr-liveness
	     `(,instr . ,(set-subtract live (live-set dst)))])
	(cons instr-liveness liveness))]

     [`(if (eq? ,a ,b) ,thn ,els)
      (let* ([thn^   (remove-last
		      (foldr liveness-analysis^ `((() . ,live)) thn))]
	     [lb-thn (if (null? thn^) (set) (cdar thn^))]
	     [els^   (remove-last
		      (foldr liveness-analysis^ `((() . ,live)) els))]
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

     [`(,op ,arg) #:when (member op '(setl sete negq indirect-callq))
      (let ([instr-liveness `(,instr . ,(set-union (set-subtract live
								 (live-set arg))
						   (live-set arg)))])
	(cons instr-liveness liveness))]

     [`(callq ,arg)
      (let ([instr-liveness `(,instr . ,(set-subtract live (set 'rax)))])
	(cons instr-liveness liveness))]

     [`(,op ,a ,b) #:when (member op '(cmpq))
      (let ([instr-liveness `(,instr . ,(set-union live
						   (live-set a)
						   (live-set b)))])
	(cons instr-liveness liveness))]
     )))

(define (remove-last ls)
  (cond
   [(null? ls) ls]
   [else (reverse (cdr (reverse ls)))]))
