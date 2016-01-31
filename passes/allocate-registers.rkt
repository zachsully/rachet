#lang racket
(require "uncover-live.rkt") ;; for debug
(require "build-interference.rkt") ;; for debug
(require "../utilities.rkt")
(provide allocate-registers)

;; (define (allocate-registers e)
;;   (match e
;;    [`(program (,vs ,graph) ,instrs ...)
;;     `(program ,vs ,@(let ([mapping (color-graph graph)])
;;                       (map (lambda (i) (lookup i mapping)) instrs)))]))

;; (define (color-graph g)
;;   (let ([w (vertices g)])
;;     (define (loop sats w)
;;       (cond
;;        [(null? w) ]))
;;     (loop w)))


;; ;; TEST
;; ((lambda (p)
;;    (allocate-registers (build-interference (uncover-live p))))
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
