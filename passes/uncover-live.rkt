#lang racket
(provide uncover-live)

(define (uncover-live e)
  (match e
   [`(program (,vs ...) ,insts ...)
    `(program (,vs ,(recieves insts)) ,@insts)]))

(define read2-write `(subq addq))
(define (read2-write? op)
  (member op read2-write))

(define read2-write `(subq addq))
(define (read2-write? op)
  (member op read2-write))


;; a variable is live from when it was assigned to when it was used
;; The accummulator is structured like this
;; `(,used ,live-after)
;; (define (recieves es)
;;   ((lambda (f)
;;      (cdr (foldr f '(()) es)))
;;    ;; helper
;;    (lambda (e live-after-set)
;;      (cons
;;       (remove-duplicates
;;        (append (remove (writes e) (car live-after-set))
;;                (reads e)))
;;       live-after-set))))

;; (define reads
;;  (lambda (instr)
;;    (match instr
;;     [`(subq (int ,a) (,_ ,b)) (list b)]
;;     [`(subq (,_ ,a) (,_ ,b)) (list b a)]
;;     [`(addq (int ,a) (,_ ,b)) (list b)]
;;     [`(addq (,_ ,a) (,_ ,b)) (list b a)]
;;     [`(cmpq (int ,_) (,_ ,b)) (list b)]
;;     [`(movzbq (,_ ,a) (,_ ,b)) (list a)]
;;     [`(movq (int ,a) (,_ ,b)) (list b)]
;;     [`(movq (,_ ,a) (,_ ,b)) (list b a)]
;;     [`(if (eq? (int 1) (int ,_)) ,thn ,els)
;;      (recieves thn)]
;;     [`(,_ ,_ ,_) '()]
;;     [`(,_ ,_) '()])))

;; (define vars
;;   (lambda (instr)
;;     (match instr
;;     [`(subq (int ,_) (,_ ,b)) (list b)]
;;     [`(subq (,_ ,a) (,_ ,b)) (list a b)]
;;     [`(addq (int ,_) (,_ ,b)) (list b)]
;;     [`(addq (,_ ,a) (,_ ,b)) (list a b)]
;;     [`(cmpq (int ,_) (,_ ,b)) (list b)]
;;     [`(cmpq (,_ ,a) (,_ ,b)) (list a b)]
;;     [`(movzbq (byte-reg al) (,_ ,b)) (list b)]
;;     [`(movq (int ,a) (,_ ,b)) (list b)]
;;     [`(movq (,_ ,a) (,_ ,b)) (list b a)]
;;     [`(,_ ,_ ,_) '()]
;;     [`(,_ ,_) '()])))

;; (define writes
;;   (lambda (instr)
;;     (match instr
;;      [`(sete (,_ ,a)) (list a)]
;;      [`(movzbq (,_ ,_) (,_ ,b)) (list b)]
;;      [`(movq (int ,a) (,_ ,b)) (list b)]
;;      [`(movq (,_ ,a) (,_ ,b)) (list b a)]
;;      [`(,_ ,_ ,_) '()]
;;      [`(,_ ,_) '()])))

;; ((lambda (p)
;;    (uncover-live p))
;;  `(program (t1 t2 if1)
;;     (callq read_int)
;;     (movq (reg rax) (var t1))
;;     (cmpq (int 1) (var t1))
;;     (sete (byte-reg al))
;;     (movzbq (byte-reg al) (var t2))
;;     (if (eq? (int 1) (var t2))
;;         ((movq (int 42) (var if1)))
;;         ((movq (int 0) (var if1))))
;;     (movq (var if1) (reg rax))))
