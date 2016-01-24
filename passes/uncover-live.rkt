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
     (foldl f `() es))
   ;; helper
   (lambda (e live-after-set)
     (cons (cons (writes e)
                 (safe-remove (reads e) live-after-set))
           live-after-set))))

(define (safe-remove e ls)
  (cond
   [(null? ls) (if e `(,e) '())]
   [(not e) (car ls)]
   [else (remove e (car ls))]))

(define reads
 (lambda (instr)
   (match instr
    [`(,_ (int ,a) ,_) #f]
    [`(,_ (,_ ,a) ,_) a])))

(define writes
  (lambda (instr)
    (match instr
     [`(,_ ,_ (,_ ,b)) b])))

((lambda (p)
   (uncover-live p))
 `(program (v w x y z)
    (movq (int 1) (var v))
    (movq (int 46) (var w))
    (movq (var v) (var x))
    (addq (int 7) (var x))
    (movq (var x) (var y))
    (addq (int 4) (var y))
    (movq (var x) (var z))
    (addq (var w) (var z))
    (movq (var z) (reg rax))
    (subq (var y) (reg rax))))
