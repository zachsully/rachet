#lang racket
(provide uncover-live)
(require racket/pretty)
(require "flatten.rkt")
(require "select-instructions.rkt")

(define (uncover-live e)
  (match e
   [`(program (,vs ...) ,instrs ...)
    `(program (,vs ,(recieves (reverse instrs) (set ) (set ) '())) ,@instrs)]))
   ;; `(program (,vs 
                
   ;;             ,(map (lambda (x) 
   ;;                    (set->list (caddr x))) 
   ;;                 (recieves (reverse instrs) (set ) (set ) '()))) ,@instrs)]))
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
  '(negq sete))

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
                            (append `((,instr ,before-set ,after-set)) uncover))))))



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
             (let ([thn^ (recieves thn (set ) after-set '())]
                   [els^ (recieves thn (set ) after-set '())])
               (values `(if (eq? (int 1) ,cnd) 
                          ,thn^
                          ,els^)
                       (set-union (cadar thn^) (cadar els^) (binary-live cnd)) 
                       (set-union (caddar thn^) (caddar els^) after-set)))]

           )))
                               



#|
(uncover-live '(program
  (if7773 if7773)
  (if (eq? (int 1) (int 1))
    ((movq (int 42) (var if7773)))
    ((movq (int 0) (var if7773))))
  (movq (var if7773) (reg rax)))
) 
|#
;; ((lambda (p)
;;    (uncover-live p))
;;  `(program (y)
;;     (movq (int 1) (var y))
;;     (subq (var y) (reg rax))))

(pretty-print
 ((lambda (p)
    (uncover-live p))

  
'(program (things)
          (callq read_int)
          (movq (reg rax) (var t.1))
          (cmpq (int 1) (var t.1))
          (sete (byte-reg al))
          (movzbq (byte-reg al) (var t.2))
          (if (eq? (int 1) (var t.2))
            ((movq (int 42) (var if.1)))
            ((movq (int 0) (var if.1))))
          (movq (var if.1) (reg rax)))
 
;;'(program (() (()) (movq (int 42) (reg rax))))
  
#|  
  
  `(program (v w x y z)
     (movq (int 1) (var v))       ;; v
     (movq (int 46) (var w))      ;; v,w
     (movq (var v) (var x))       ;; w,x
     (addq (int 7) (var x))       ;; w,x
     (movq (var x) (var y))       ;; w,x,y
     (addq (int 4) (var y))       ;; w,x,y
     (movq (var x) (var z))       ;; w,y,z
     (addq (var w) (var z))       ;; y,z
     (movq (var z) (reg rax))     ;; y,rax
     (subq (var y) (reg rax)))
|#  
  ))   ;;
