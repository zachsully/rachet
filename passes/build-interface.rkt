#lang racket
(require "../utilities.rkt")
(require "uncover-live.rkt") ;; for debug
(provide build-interface)

(define (build-interface e)
  (match e
   [`(program (,vs ,lives) ,instr ...)
    `(program (,vs ,(make-conflict-graph lives instr (make-graph vs))) ,@instr)])
  )

(define (make-conflict-graph lives instr graph)
  (match instr
   [(? null?) graph]
   [`((movq ,a ,b) . ,rest)
    let ([graph^ (map (lambda (v)
                        (add-edge v blah)))]) graph]
   [`((addq ,a ,b) . ,rest) graph]
   [`((callq ,label) . ,rest) graph]
   [`((,_ ,_ ,_) . ,rest) graph]))




;; TEST
((lambda (p)
   (build-interface (uncover-live p)))
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
    (subq (var y) (reg rax))))   ;;
