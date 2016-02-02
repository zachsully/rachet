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
     (cons (remove-duplicates
            (append (remove (writes e) (car live-after-set))
                    (reads e)))
           live-after-set))))

(define reads
 (lambda (instr)
   (match instr
    [`(subq (int ,a) (,_ ,b)) (list b)]
    [`(subq (,_ ,a) (,_ ,b)) (list b a)]
    [`(addq (int ,a) (,_ ,b)) (list b)]
    [`(addq (,_ ,a) (,_ ,b)) (list b a)]
    [`(,_ (int ,a) ,_) '()]
    [`(,_ (,_ ,a) ,_) `(,a)]
    [`(,_ (,_ ,a)) `(,a)]
    [`(,_ ,_) '()])))

(define writes
  (lambda (instr)
    (match instr
     [`(,_ ,_ (,_ ,b)) b]
     [`(,_ (,_ ,a)) `(,a)]
     [`(,_ ,_) '()])))

;; ((lambda (p)
;;    (uncover-live p))
;;  `(program (y)
;;     (negq (var y))
;;     (subq (var y) (reg rax))))


;; ((lambda (p)
;;    (uncover-live p))
;;  `(program (v w x y z)
;;     (movq (int 1) (var v))       ;; v
;;     (movq (int 46) (var w))      ;; v,w
;;     (movq (var v) (var x))       ;; w,x
;;     (addq (int 7) (var x))       ;; w,x
;;     (movq (var x) (var y))       ;; w,x,y
;;     (addq (int 4) (var y))       ;; w,x,y
;;     (movq (var x) (var z))       ;; w,y,z
;;     (addq (var w) (var z))       ;; y,z
;;     (movq (var z) (reg rax))     ;; y,rax
;;     (subq (var y) (reg rax))))   ;;
