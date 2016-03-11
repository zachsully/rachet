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
   ['() '()]

   [`(define (,f ,args ...) : ,rt ,gen-vars ,stmts ...)
    (let* ([num-args   (length args)]
	   [args^      (map car args)]
	   [num-locals (+ num-args 1)] ;; plus 1 for the rootstack?
	   [stmts^     (append-map (lambda (s)
				     (select-instructions^ s rs)) stmts)]
	   [gen-vars^  (remove-duplicates (append gen-vars
						  (get-vars stmts^ '())))]
	   [max-stack  (let ([ms (- num-args
				    (vector-length arg-registers))])
			 (if (< ms 0) 0 ms))])
      `(define (,f)
	 ,num-locals
	 (,(append `(,rs) args^ gen-vars^) ,max-stack)
	 ,@(append (move-locals (append args^ `(,rs)))  stmts^)))]

   [(? boolean?) (if e `(int 1) `(int 0))]

   [(? integer?) `(int ,e)]

   [(? symbol?) `(var ,e)]

   ;; >>>>>>>>>>>>>>        FOR FUNCTIONS APPLICATION      <<<<<<<<<<<<<<<<<<<<<
   [`(assign ,v (function-ref ,f))
    `((leaq (function-ref ,f) ,(select-instructions^ v rs)))]

   [`(assign ,v (app ,funk ,args ...))
    `(,@(pass-args (map (lambda (a) (select-instructions^ a rs))
			(append args `(,rs))))
      (indirect-callq ,(select-instructions^ funk rs))
      (movq (reg rax) ,(select-instructions^ v rs)))]
   ;; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

   [`(assign ,v (read))
    `((callq read_int)
      (movq (reg rax) ,(select-instructions^ v rs)))]

   [`(assign ,v (- ,e1))
    (let ([v^ (select-instructions^ v rs)]
	  [e1^ (select-instructions^ e1 rs)])
      `((movq ,e1^ ,v^)
	(negq ,v^)))]

   [`(assign ,v (+ ,e1 ,e2))
    (let ([v^  (select-instructions^ v rs)]
	  [e1^ (select-instructions^ e1 rs)]
	  [e2^ (select-instructions^ e2 rs)])
      `((movq ,e2^ ,v^)
	(addq ,e1^ ,v^)))]

   [`(assign ,e1 (eq? ,arg1 ,arg2))
    `((cmpq ,(select-instructions^ arg1 rs)
	    ,(select-instructions^ arg2 rs))
      (sete (byte-reg al))
      (movzbq (byte-reg al) ,(select-instructions^ e1 rs)))]

   [`(assign ,v (not ,es))
    `((movq ,(select-instructions^ es rs)
	    ,(select-instructions^ v  rs))
      (xorq (int 1) ,(select-instructions^ v rs)))]

   [`(assign ,v (allocate ,len (Vector ,ts ...)))
    (let ([v^ (select-instructions^ v rs)]
	  [tag (bitwise-ior
		(arithmetic-shift (pointer-mask ts) 7)
		(arithmetic-shift len 1)
		1)])
      `((movq (global-value free_ptr) ,v^)
	(addq (int ,(* 8 (+ 1 len))) (global-value free_ptr))
	(movq (int ,tag) (offset ,v^ 0))))]

   ;; there is a special case here for if 'vec' is a vector-ref
   [`(assign ,v (vector-set! ,vec ,n ,arg))
    `((movq ,(select-instructions^ arg rs)
	    (offset ,(select-instructions^ vec rs)
		    ,(* 8 (+ 1 n))))
      (movq (int -1) (var ,v)))]

   [`(assign ,v (vector-ref ,vec ,n))
    `((movq (offset ,(select-instructions^ vec rs)
		    ,(* 8 (+ 1 n)))
	    (var ,v)))]

   [`(if (eq? ,bool ,cnd) ,thn ,els)
    `((if (eq? ,(select-instructions^ bool rs)
	       ,(select-instructions^ cnd rs))
	  ,(select-instructions^ thn rs)
	  ,(select-instructions^ els rs)))]

   ;; Generic assign statement
   [`(assign ,v ,x)
    (let ([v^ (select-instructions^ v rs)]
	  [x^ (select-instructions^ x rs)])
      `((movq ,x^ ,v^)))]

   [`(return ,v)
    `((movq ,(select-instructions^ v rs) (reg rax)))]

   ;; Checks if there is enough space in the from space
   [`(if (collection-needed? ,bytes) ,thn ,els)
    (let ([end-data (gensym "end-data.")]
	  [lt       (gensym "lt.")])
      `((movq (global-value free_ptr) (var ,end-data))
	(addq (int ,bytes) (var ,end-data))
	(cmpq (var ,end-data) (global-value fromspace_end))
	(setl (byte-reg al))
	(movzbq (byte-reg al) (var ,lt))
	(if (eq? (int 0) (var ,lt))
	    ,(select-instructions^ els rs)
	    ,(select-instructions^ thn rs))))]

   [`(call-live-roots ,vs (collect ,bytes))
    (append
     (push-live-roots vs rs)
     (let ([newrs (gensym "rootstack.")])
       `((movq (var ,rs) (var ,newrs))
	 (addq (int ,(length vs)) (var ,newrs))
	 (movq (var ,newrs) (reg rdi))
	 (movq (int ,bytes) (reg rsi))
	 (callq collect)))
     (pop-live-roots vs rs))]

   [`(initialize ,rootlen ,heaplen)
    `((movq (int ,rootlen) (reg rdi))
      (movq (int ,heaplen) (reg rsi))
      (callq initialize)
      (movq (global-value rootstack_begin) (var ,rs)))]

   ;; For recuring on body of the list
   [`(,x ...) (let ([ex_stmts (select-instructions^ (car x) rs)]
                    [ex1_stmts (select-instructions^ (cdr x) rs)])
        (append ex_stmts ex1_stmts))]

   ))



;; MAIN selection instructions
(define (select-instructions e)
 (match e
  [`(program ,vs ,type (defines ,defs ...) ,stmts ...)
   (let* ([rs     (gensym "rootstack.")]
	  [stmts^ (append-map (lambda (s)
				(select-instructions^ s rs)) stmts)]
	  [defs^  (map (lambda (s)
			 (select-instructions^ s rs)) defs)])
     `(program ,(remove-duplicates (append vs (get-vars stmts^ '())))
	       ,type
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
     [`(if ,cnd ,thn ,els) (append (get-vars cnd '())
			           (get-vars thn '())
                                   (get-vars els '()))]
     [else '()]
     )))



(define get-vars
  (lambda (instrs ans)
    (if (null? instrs)
        ans
        (get-vars (cdr instrs)
		  (append ans
			  (get-vars-helper (car instrs)))))))



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
			 `((movq ,arg (reg ,(vector-ref arg-registers i)))))
		 (add1 i))
	   (cons (append instrs
			 `((movq ,arg (stack-arg ,(- i num-arg-passing)))))
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
			 `((movq (stack-arg ,(- i num-arg-passing))
				 (var ,v))))
		 (add1 i)))))))

;; (pretty-print (move-locals 15))
