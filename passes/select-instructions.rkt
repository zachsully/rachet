#lang racket
(require "../utilities.rkt")
(require racket/pretty)
(provide select-instructions)

;;
;; Select instruction
;;
;; select-instruction : C2 -> x86'
;;
;; Takes c-ish language to an x86-ish one
;;

(define (select-instructions^ e rs)
  (match e
   ;; >>>>>>>>>>>>>>        FOR FUNCTIONS APPLICATION      <<<<<<<<<<<<<<<<<<<<<
   [`(assign ,v (has-type (function-ref ,f) _))
    `((leaq (function-ref ,f) ,(prim v)))]

   [`(assign ,v (has-type (app ,funk ,args ...) ,_))
    (let ([x (append (map get-sym args) `(,rs))])
      `(,@(pass-args x)
	(indirect-callq ,(prim (get-sym funk)))
	(movq (reg rax) ,(prim v))))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   [`(assign ,v (has-type (read) Integer))
    `((callq read_int)
      (movq (reg rax) ,(prim v)))]

   [`(assign ,v (has-type (- (has-type ,e1 Integer)) Integer))
    `((movq ,(prim e1) ,(prim v))
      (negq ,(prim v)))]

   [`(assign ,v (has-type (+ (has-type ,e1 Integer)
			     (has-type ,e2 Integer)) Integer))
    `((movq ,(prim e2) ,(prim v))
      (addq ,(prim e1) ,(prim v)))]

   [`(assign ,v (has-type (eq? (has-type ,arg1 ,_)
			       (has-type ,arg2 ,_)) Boolean))
    `((cmpq ,(prim arg1) ,(prim arg2))
      (sete (byte-reg al))
      (movzbq (byte-reg al) ,(prim v)))]

   [`(assign ,v (has-type (not (has-type ,a Boolean)) Boolean))
    `((movq ,(prim a) ,(prim v))
      (xorq (int 1) ,(prim v)))]

   [`(assign ,v (has-type (allocate ,len (Vector ,ts ...)) ,_))
    (let ([tag (bitwise-ior
		(arithmetic-shift (pointer-mask ts) 7)
		(arithmetic-shift len 1)
		1)])
      `((movq (global-value free_ptr) ,(prim v))
	(addq (int ,(* 8 (+ 1 len))) (global-value free_ptr))
	(movq (int ,tag) (offset ,(prim v) 0))))]

   [`(assign ,_ (has-type (vector-set! (has-type ,vec ,_)
				       ,n
				       (has-type ,arg ,_)) ,_))
    `((movq ,(prim arg) (offset ,(prim vec) ,(* 8 (+ 1 n)))))]

   [`(assign ,v (has-type (vector-ref (has-type ,vec ,_) ,n) ,_))
    `((movq (offset ,(prim vec) ,(* 8 (+ 1 n)))
	    ,(prim v)))]

   [`(if (eq? (has-type ,a ,_) (has-type ,b ,_)) ,thn ,els)
    `((if (eq? ,(prim a) ,(prim b))
	  ,(append-map (lambda (s) (select-instructions^ s rs)) thn)
	  ,(append-map (lambda (s) (select-instructions^ s rs)) els)))]

   ;; Generic assign statement
   [`(assign ,v (has-type ,x ,_))
    `((movq ,(prim x) ,(prim v)))]

   [`(return (has-type ,v ,_))
    `((movq ,(prim v) (reg rax)))]

   [`(has-type (initialize ,rootlen ,heaplen) _)
    `((movq (int ,rootlen) (reg rdi))
      (movq (int ,heaplen) (reg rsi))
      (callq initialize)
      (movq (global-value rootstack_begin) ,(prim rs)))]

   ;; Checks if there is enough space in the from space
   [`(if (has-type (collection-needed? ,bytes) ,_) ,thn ,els)
    (let ([end-data (gensym "end-data.")]
	  [lt       (gensym "lt.")])
      `((movq (global-value free_ptr) (var ,end-data))
	(addq (int ,bytes) (var ,end-data))
	(cmpq (global-value fromspace_end) (var ,end-data))
	(setl (byte-reg al))
	(movzbq (byte-reg al) (var ,lt))
	(if (eq? (int 0) (var ,lt))
	    ,(append-map (lambda (s) (select-instructions^ s rs)) thn)
	    ,(append-map (lambda (s) (select-instructions^ s rs)) els))))]

   [`(has-type (call-live-roots ,vs (collect ,bytes)) _)
    (let ([newrs (gensym "rootstack.")])
      `(,@(push-live-roots vs rs)
	(movq (var ,rs) (var ,newrs))
	(addq (int ,(length vs)) (var ,newrs))
	(movq (var ,newrs) (reg rdi))
	(movq (int ,bytes) (reg rsi))
	(callq collect)
	,@(pop-live-roots vs rs)))]

   [`(define (,f ,args ...) : ,rt ,gen-vars ,stmts ...)
    (let* ([num-args   (length args)]
	   [args^      (map car args)]
	   [num-locals (+ num-args 1)] ;; plus 1 for the rootstack?
	   [stmts^     (append-map (lambda (s) (select-instructions^ s rs))
				   stmts)]
	   [stmts^^ (append (move-locals (append args^ `(,rs)))  stmts^)]
	   [gen-vars^  (remove-duplicates (append gen-vars
						  (get-vars stmts^)))]
	   [max-stack  (calc-max-stack stmts^^)])
      `(define (,f)
	 ,num-locals
	 (,(append `(,rs) args^ gen-vars^) ,max-stack)
	 ,@stmts^^))]
   ))

(define (prim e)
  (cond
   [(integer? e) `(int ,e)]
   [(symbol? e)  `(var ,e)]
   [(boolean? e) (if e `(int 1) `(int 0))]))

(define (get-sym e)
  (match e [`(has-type ,e ,_) e]))



;; MAIN selection instructions
(define (select-instructions e)
 (match e
  [`(program ,vs (defines ,defs ...) ,stmts ...)
   (let* ([rs     (gensym "rootstack.")]
	  [stmts^ (append-map (lambda (s) (select-instructions^ s rs)) stmts)]
	  [defs^  (map (lambda (s) (select-instructions^ s rs)) defs)])
     `(program ,(remove-duplicates (append vs (get-vars stmts^)))
	       (defines ,@defs^)
	       ,@stmts^))]))



(define (push-live-roots vars rootstack)
  (car
   (foldr (lambda (v acc)
	    (cons (append
		   `((movq (var ,v)
			   (offset (var ,rootstack) ,(* 8 (- (cdr acc) 1)))))
		   (car acc))
		  (+ 1 (cdr acc))))
	  '(() . 1)
	  vars)))



(define (pop-live-roots vars rootstack)
  (car
   (foldr (lambda (v acc)
	    (cons (append
		   `((movq
		      (offset (var ,rootstack) ,(* 8 (- (cdr acc) 1)))
		      (var ,v)
		      ))
		   (car acc))
		  (+ 1 (cdr acc))))
	  '(() . 1)
	  vars)))



;; We run these after select-instructions is complete to add our
;; new gensym vars to the front of our prog
(define get-vars-helper
  (lambda (instr)
    (match instr
     [`(,op ,_ (var ,e2)) (list e2)]
     [`(if ,cnd ,thn ,els) (append (get-vars cnd)
			           (get-vars thn)
                                   (get-vars els))]
     [else '()]
     )))


(define (get-vars stmts)
  (append-map get-vars-helper stmts))

;; returns the 50 bit pointer mask given a vectors types
(define (pointer-mask types)
  ((lambda (f)
     (car (foldr f `(0 . 0) types)))
   (lambda (t acc)
     (let ([mask (car acc)]
	   [n    (cdr acc)])
       `(,(bitwise-ior (arithmetic-shift (match t
					  [`(Vector ,_ ...) 1]
					  [else 0])
					 n)
		       mask)
	 . ,(+ 1 n))))))


;; Given a list of defines and a list of instructions, calculates the max
;;  amount of args being passed on the stack
(define (calc-max-stack stmts)
  (foldr (lambda (s a)
	   (match s
            [`(movq ,_ (stack-arg ,i)) (max (+ 1 (/ i 8)) a)]
	    [`(movq (stack-arg ,i) ,_) (max (+ 1 (/ i 8)) a)]
	    [else a])) 0 stmts))



;; This returns the number argument passing registers for the following
;;  helper functions
(define num-arg-passing (vector-length arg-registers))


;; takes a list of args to be passed to a function and returns a list of
;;  instrucions putting them in the arg-passing registers or the stack
(define (pass-args args)
  ((lambda (f)
     (car (foldr f '(() . 0) args)))
   (lambda (arg acc)
     (let ([i      (cdr acc)]
	   [instrs (car acc)])
       (if (< i num-arg-passing)
	   (cons (append instrs
			 `((movq ,(prim arg)
				 (reg ,(vector-ref arg-registers i)))))
		 (add1 i))
	   (cons (append instrs
			 `((movq ,(prim arg)
				 (stack-arg ,(* 8 (- i num-arg-passing))))))
		 (add1 i)))))))




;; Returns list of instrs moving locals passed parameters to local vars in
;;   function
(define (move-locals vars)
  ((lambda (f)
     (car (foldr f '(() . 0) vars)))
   (lambda (v acc)
     (let ([i      (cdr acc)]
	   [instrs (car acc)])
       (if (< i num-arg-passing)
	   (cons (append instrs
			 `((movq (reg ,(vector-ref arg-registers i))
				 (var ,v))))
		 (add1 i))
	   (cons (append instrs
			 `((movq (stack-arg ,(* 8 (- i num-arg-passing)))
				 (var ,v))))
		 (add1 i)))))))
