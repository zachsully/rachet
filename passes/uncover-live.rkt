#lang racket
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
   [`(program (,vs ...) ,t ,instrs ...)
    `(program (,vs ,(recieves (reverse instrs) (set ) (set ) '()))
	      ,t
	      ,@instrs)]))

;; a variable is live from when it was assigned to when it was used
;; The accummulator is structured like this
;; `(,instru ,live-before ,live-after)

(define only-reads-list
  `(cmpq))

(define only-reads?
  (lambda (op)
    (member op only-reads-list)))

(define read2-write-list
  '(subq addq xorq))

(define read2-write?
  (lambda (op)
    (member op read2-write-list)))

(define read-write-list
    `(movq movzbq))

(define read-write?
  (lambda (op)
  (member op read-write-list)))

(define unary-list
  '(negq sete setl))

(define unary?
  (lambda (op)
    (member op unary-list)))

(define conflict-all-list
  `(callq))

(define conflict-all?
  (lambda (op)
    (member op conflict-all-list)))

(define binary-live
  (lambda (src)
    (match src
           [`(var ,x) (set x)]
           [`(byte-reg ,x) (set 'rax)]
           [`(reg ,x) (set x)]
           [else (set )])))

;; live-before = (union (set-subract live-after  writes) reads)
(define recieves
  (lambda (instrs live-after live-before uncover)
    (if (null? instrs)
      uncover
      (let-values ([(instr before-set after-set)
                    (recieves-helper (car instrs) live-before)])
                  (recieves (cdr instrs) after-set before-set
                            (append `((,instr ,before-set ,after-set))
				    uncover))))))



(define recieves-helper
  (lambda (instr after-set)
    (match instr
     [`(,op ,src ,des) #:when (read2-write? op)
      (let ([src^ (binary-live src)]
            [des^ (binary-live des)])
        (values instr
                (set-union (set-subtract after-set des^) src^ des^)
                after-set))]

     [`(,op ,src ,des) #:when (read-write? op)
      (let ([src^ (binary-live src)]
            [des^ (binary-live des)])
        (values instr
                (set-union (set-subtract after-set des^) src^)
                after-set))]

     [`(,op ,src) #:when (unary? op)
      (let ([src^ (binary-live src)])
        (values instr
                (set-union (set-subtract after-set src^) src^)
                after-set))]

     [`(,op ,src ,dst) #:when (only-reads? op)
      (let ([src^ (binary-live src)]
            [dst^ (binary-live dst)])
        (values instr
                (set-union after-set src^ dst^)
                after-set))]


     [`(,op ,src) #:when (conflict-all? op)
      (values instr
              (set-union
               (set-subtract after-set (set 'rax))
               (set 'rax))
              after-set)]

     [`(if (eq? (int 1) ,cnd) ,thn ,els)
      (let ([thn^ (recieves (reverse thn) (set ) after-set '())]
            [els^ (recieves (reverse els) (set ) after-set '())])
        (values `(if (eq? (int 1) ,cnd)
		     ,thn^
		     ,els^)
                (set-union (cadar thn^) (cadar els^) (binary-live cnd))
                (set-union (caddar thn^) (caddar els^) after-set)))]

     [`(if (eq? (int 0) ,cnd) ,thn ,els)
      (let ([thn^ (recieves (reverse thn) (set ) after-set '())]
	    [els^ (recieves (reverse els) (set ) after-set '())])
        (values `(if (eq? (int 0) ,cnd)
		     ,thn^
		     ,els^)
                (set-union (set ) (cadar els^) (binary-live cnd))
                (set-union (set ) (caddar els^) after-set)))]
     )))
