#lang racket
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

   [(? boolean?) (if e `(int 1) `(int 0))]

   [(? integer?) `(int ,e)]

   [(? symbol?) `(var ,e)]

   [`(assign ,v (read))
    `((callq read_int)
      (movq (reg rax) ,(select-instructions^ v rs)))]

   [`(assign ,v (- ,e1))
    (let ([v^ (select-instructions^ v rs)]
          [e1^ (select-instructions^ e1 rs)])
      `((movq ,e1^ ,v^)
        (negq ,v^)))]

   [`(assign ,v (+ ,e1 ,e2))
    (let ([v^ (select-instructions^ v rs)]
          [e1^ (select-instructions^ e1 rs)]
          [e2^ (select-instructions^ e2 rs)])
      `((movq ,e2^ ,v^)
        (addq ,e1^ ,v^)))]

   [`(assign ,e1 (eq? ,arg1 ,arg2))
    `((cmpq ,(select-instructions^ arg1 rs) ,(select-instructions^ arg2 rs))
      (sete (byte-reg al))
      (movzbq (byte-reg al) ,(select-instructions^ e1 rs)))]

   [`(assign ,v (not ,es))
    `((movq ,(select-instructions^ es rs) ,(select-instructions^ v rs))
      (xorq (int 1) ,(select-instructions^ v rs)))]

   [`(assign ,v (allocate ,len (Vector ,ts ...)))
    (let ([v^ (select-instructions^ v rs)])
      `((movq (global-value free_ptr) ,v^)
        (addq (int ,(* 8 (+ 1 len))) (global-value free_ptr))
        (movq (int TAG) (offset ,v^ 0))))]

   [`(assign ,v (vector-set! ,vec ,n ,arg))
    `((movq ,(select-instructions^ arg)
            (offset ,(select-instructions^ vec rs) ,(* 8 (+ 1 n)))))]

   [`(assign ,v (vector-ref ,vec ,n))
    `((movq (offset ,(select-instructions^ vec rs) ,(* 8 (+ 1 n)))
            ,v))]

   [`(if (eq? ,bool ,cnd) ,thn ,els)
    `((if (eq? ,(select-instructions^ bool rs) ,(select-instructions^ cnd rs))
          ,(select-instructions^ thn rs)
          ,(select-instructions^ els rs)))]

   ;; Generic assign statement
   [`(assign ,v ,x)
    (let ([v^ (select-instructions^ v rs)]
          [x^ (select-instructions^ x rs)])
      `((movq ,x^ ,v^)))]

   [`(return ,v) `((movq ,(select-instructions^ v rs) (reg rax)))]

   [`(if (collection-needed? ,bytes) ,thn ,els)
    `((movq (global-value free_ptr) (var end-data.1))
      (addq (int ,bytes) (var end-data.1))
      (cmpq (var end-data.1) (global-value fromspace_end))
      (setl (byte-reg al))
      (movzbq (byte-reg al) (var lt.1))
      (if (eq? (int 0) (var lt.1))
          ,(select-instructions^ els rs)
          ,(select-instructions^ thn rs)))]

   [`(call-live-roots ,vs (collect ,bytes))
    (append (car (foldr (lambda (v acc)
                     (cons (append `((movq (var ,v)
                                     (offset (var ROOTSTACK.prev)
                                             ,(* 8 (- 1 (cdr acc))))))
                                   (car acc))
                           (+ 1 (cdr acc))))
                   '(() . 0)
                   vs))
            `((movq ROOTSTACK.prev ROOTSTACK.new)
              (addq (int ,(length vs)) ROOTSTACK.new)
              (movq (var ROOTSTACK.new) (reg rdi))
              (movq (int ,bytes) (reg rsi))
              (callq collect))
            (car (foldr (lambda (v acc)
                     (cons (append `((movq
                                      (offset (var ROOTSTACK.prev)
                                             ,(* 8 (- 1 (cdr acc))))
                                      (var ,v)
                                     ))
                                   (car acc))
                           (+ 1 (cdr acc))))
                   '(() . 0)
                   vs)))]

   [`(initialize ,rootlen ,heaplen)
    `((movq (int ,rootlen) (reg rdi))
      (movq (int ,heaplen) (reg rsi))
      (callq initialize)
      (movq (global-value rootstack_begin) (var rootstack)))]

   [`(,x ...) (select-instructions^ (car x) rs)]
   ))

(define select-instructions
  (lambda (e)
    (match e
     [`(program ,vs (type ,t) ,es ...)
      `(program ,vs ,@(select-instructions^ es 'rootstack_begin))]
     ;; ['() '()]
     ;; [else (append (select-instructions^ (car e))
     ;;               (select-instructions (cdr e)))]
     )))
