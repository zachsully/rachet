#lang racket
(require "../utilities.rkt")
;; (require "uncover-live.rkt") ;; for debug
(provide build-interference)

(define (build-interference e)
  (match e
   [`(program (,vs ,live-afters) ,instrs ...)
    `(program (,vs ,(build (make-graph vs) live-afters instrs))
              ,@instrs)])
  )

(define (build graph live-afters instrs)
  ((lambda (f) (map f live-afters instrs))
   (lambda (live-after instr)
     (match instr
      [`(movq (,_ ,a) (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (and (not (eq? a v))
                           (not (eq? d v)))) live-after))]
      [`(movq (int ,_) (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(addq ,a (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(subq ,a (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(callq (,_ ,d))
       (map (lambda (v)
              (map (lambda (r)
                     (add-edge graph r v))
                   caller-save))
            live-after)])))
  graph)




;; TEST
;; ((lambda (p)
;;    (build-interference (uncover-live p)))
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
