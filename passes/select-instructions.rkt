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
   [`(if (eq? #t ,cnd) ,thn ,els)
    `((if (eq? (int 1) ,(select-instructions^ cnd))
          ,(select-instructions^ thn)
          ,(select-instructions^ els)))]
   [`(assign ,v ,x)
    (let ([v^ (select-instructions^ v)]
          [x^ (select-instructions^ x)])
      `((movq ,x^ ,v^)))]
   [`(return ,v) `((movq ,(select-instructions^ v) (reg rax)))]
   [`(initialize ,_ ,_) `(,e)]
   [`(,x ...) (select-instructions^ (car x))]))

(define select-instructions
  (lambda (e)
    (match e
     [`(program ,vs (type ,t) ,es ...) `(program ,vs ,@(select-instructions es))]
     ['() '()]
     [else (append (select-instructions^ (car e))
                   (select-instructions (cdr e)))])))
