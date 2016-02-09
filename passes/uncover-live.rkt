#lang racket
(provide uncover-live)

(define (uncover-live e)
  (match e
   [`(program (,vs ...) ,inst ...)
    `(program (,vs ,(recieves inst)) ,@inst)]))

;; a variable is live from when it was assigned to when it was used
;; The accummulator is structured like this
;; `(,used ,live-after)
(define (recieves es)
  ((lambda (f)
     (cdr (foldr f '(()) es)))
   ;; helper
   (lambda (e live-after-set)
     (cons (match e
            [`(if (eq? (,_ ,_) (,_ ,a)) ,thn ,els)
             (append (remove (list a) (car live-after-set))
                     (flatten (recieves thn))
                     (flatten (recieves els)))]
            [else (remove-duplicates
                   (append (remove (writes e) (car live-after-set))
                           (reads e)))])
           live-after-set))))

(define reads
 (lambda (instr)
   (match instr
    [`(subq (int ,a) (,_ ,b)) (list b)]
    [`(subq (,_ ,a) (,_ ,b)) (list b a)]
    [`(addq (int ,a) (,_ ,b)) (list b)]
    [`(addq (,_ ,a) (,_ ,b)) (list b a)]
    [`(cmpq (int ,_) (,_ ,b)) (list b)]
    [`(movzbq (,_ ,a) (,_ ,b)) (list a)]
    [`(,_ (int ,a) ,_) '()]
    [`(,_ (,_ ,a) ,_) `(,a)]
    [`(,_ (,_ ,a)) `(,a)]
    [`(,_ ,_) '()]
    )))

(define writes
  (lambda (instr)
    (match instr
     [`(movzbq (,_ ,a) (,_ ,b)) (list b)]
     [`(sete (,_ ,a)) (list a)]
     [`(,_ ,_ (,_ ,b)) b]
     [`(,_ (,_ ,a)) `(,a)]
     [`(,_ ,_) '()])))

((lambda (p)
   (uncover-live p))
 `(program (t1 t2 if1)
    (callq read_int)
    (movq (reg rax) (var t1))
    (cmpq (int 1) (var t1))
    (sete (byte-reg al))
    (movzbq (byte-reg al) (var t2))
    (if (eq? (int 1) (var t2))
        ((movq (int 42) (var if1)))
        ((movq (int 0) (var if1))))
    (movq (var if1) (reg rax))))
