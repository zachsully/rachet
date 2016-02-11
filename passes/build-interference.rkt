#lang racket
(require "../utilities.rkt")
(require "uncover-live.rkt") ;; for test
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
      [`(cmpq ,_ (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(sete (byte-reg ,al))
       (map (lambda (v) (add-edge graph 'rax v)) '())]

      [`(if (eq? (int ,a) (int ,d)) ,thn ,els)
       (begin
         (build graph (find-live-afters thn) thn)
         (build graph (find-live-afters els) els))]

      [`(if (eq? (,_ ,a) (int ,d)) ,thn ,els)
       (begin
         (map (lambda (v) (add-edge graph a v))
              (filter (lambda (v)
                        (not (eq? a v))) live-after))
         (build graph (find-live-afters thn) thn)
         (build graph (find-live-afters els) els))]

      [`(if (eq? (,_ ,a) (,_ ,d)) ,thn ,els)
       (begin
         (map (lambda (v) (add-edge graph a v))
              (filter (lambda (v)
                        (and (not (eq? a v))
                             (not (eq? d v)))) live-after))
         (build graph live-afters thn)
         (build graph live-afters els))]
      [`(movq (,_ ,a) (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (and (not (eq? a v))
                           (not (eq? d v)))) live-after))]
      [`(movq (int ,_) (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(movzbq (,_ ,a) (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (and (not (eq? a v))
                           (not (eq? d v)))) live-after))]
      [`(movzbq (int ,_) (,_ ,d))
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
      [`(negq (,_ ,d))
       (map (lambda (v) (add-edge graph d v))
            (filter (lambda (v)
                      (not (eq? d v))) live-after))]
      [`(callq ,_)
       (map (lambda (v)
              (map (lambda (r)
                     (add-edge graph r v))
                   (set->list caller-save)))
            live-after)])))
  graph)

(define (find-live-afters if-stmt)
  (match (uncover-live `(program (()) ,@if-stmt))
   [`(program (,vs ,live-afters) ,instrs ...) live-afters]))

;; (pretty-print
;;  ((lambda (ps)
;;     (map (lambda (p)
;;            (build-interference (uncover-live p))) ps))
;;   `((program (v w x y z)
;;      (movq (int 1) (var v))       ;; v
;;      (movq (int 46) (var w))      ;; v,w
;;      (movq (var v) (var x))       ;; w,x
;;      (addq (int 7) (var x))       ;; w,x
;;      (movq (var x) (var y))       ;; w,x,y
;;      (addq (int 4) (var y))       ;; w,x,y
;;      (movq (var x) (var z))       ;; w,y,z
;;      (addq (var w) (var z))       ;; y,z
;;      (movq (var z) (reg rax))     ;; y,rax
;;      (subq (var y) (reg rax)))    ;;
;;    (program (things)
;;      (callq read_int)                  ;; rax
;;      (movq (reg rax) (var t.1))        ;; t.1
;;      (cmpq (int 1) (var t.1))          ;; al?
;;      (sete (byte-reg al))              ;; al?
;;      (movzbq (byte-reg al) (var t.2))  ;; t.2
;;      (if (eq? (int 1) (var t.2))            ;;
;;          ((movq (int 42) (var if.1))
;; 	  (movq (int 42) (var t.2))
;; 	  (movq (int 42) (var t.1)))
;;          ((movq (int 0) (var if.1))))  ;; if.1
;;      (movq (var if.1) (reg rax)))      ;;
;;    )))
