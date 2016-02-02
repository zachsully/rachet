#lang racket
(require "../utilities.rkt")
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
