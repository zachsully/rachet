#lang racket
(provide select-instructions)

;;
;; Select instruction
;;
;; select-instruction : C2 -> x86'
;;
;; Takes c-ish language to an x86-ish one
;;

(define (select-instructions^ e)
  (match e
   ['() '()]

   [(? boolean?) (if e `(int 1) `(int 0))]

   [(? integer?) `(int ,e)]

   [(? symbol?) `(var ,e)]

   [`(assign ,v (read))
    `((callq read_int)
      (movq (reg rax) ,(select-instructions^ v)))]

   [`(assign ,v (- ,e1))
    (let ([v^ (select-instructions^ v)]
          [e1^ (select-instructions^ e1)])
      `((movq ,e1^ ,v^)
        (negq ,v^)))]

   [`(assign ,v (+ ,e1 ,e2))
    (let ([v^ (select-instructions^ v)]
          [e1^ (select-instructions^ e1)]
          [e2^ (select-instructions^ e2)])
      `((movq ,e2^ ,v^)
        (addq ,e1^ ,v^)))]

   [`(assign ,e1 (eq? ,arg1 ,arg2))
    `((cmpq ,(select-instructions^ arg1) ,(select-instructions^ arg2))
      (sete (byte-reg al))
      (movzbq (byte-reg al) ,(select-instructions^ e1)))]

   [`(assign ,v (not ,es))
    `((movq ,(select-instructions^ es) ,(select-instructions^ v))
      (xorq (int 1) ,(select-instructions^ v)))]

   [`(if (eq? ,bool ,cnd) ,thn ,els)
    `((if (eq? ,(select-instructions^ bool) ,(select-instructions^ cnd))
          ,(select-instructions^ thn)
          ,(select-instructions^ els)))]

   [`(assign ,v ,x)
    (let ([v^ (select-instructions^ v)]
          [x^ (select-instructions^ x)])
      `((movq ,x^ ,v^)))]

   [`(return ,v) `((movq ,(select-instructions^ v) (reg rax)))]

   [`(if (collection-needed? ,bytes) ,thn ,els)
    `((movq (global-value free_ptr) (var end-data.1))
      (addq (int ,bytes) (var end-data.1))
      (cmpq (var end-data.1) (global-value fromspace_end))
      (setl (byte-reg al))
      (movzbq (byte-reg al) (var lt.1))
      (if (eq? (int 0) (var lt.1))
          ,(select-instructions^ els)
          ,(select-instructions^ thn)))]

   [`(call-live-roots ,vs (collect ,bytes))
    (append (car (foldr (lambda (v acc)
                     (cons (append `((movq (var ,v)
                                     (offset (var rootstack.prev)
                                             ,(* 8 (- 1 (cdr acc))))))
                                   (car acc))
                           (+ 1 (cdr acc))))
                   '(() . 0)
                   vs))
            `((movq rootstack.prev rootstack.new)
              (addq (int ,(length vs)) rootstack.new)
              (movq (var rootstack.new) (reg rdi))
              (movq (int ,bytes) (reg rsi))
              (callq collect))
            (car (foldr (lambda (v acc)
                     (cons (append `((movq
                                      (offset (var rootstack.prev)
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

   [`(allocate ,_ ,_) e]

   [`(vector-set! ,_ ,_ ,_) e]

   [`(vector-ref ,_ ,_) e]

   [`(,x ...) (select-instructions^ (car x))]
   ))

(define select-instructions
  (lambda (e)
    (match e
     [`(program ,vs (type ,t) ,es ...)
      `(program ,vs ,@(select-instructions es))]
     ['() '()]
     [else (append (select-instructions^ (car e))
                   (select-instructions (cdr e)))]
     )))
