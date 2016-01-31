#lang racket
(require "uncover-live.rkt") ;; for debug
(require "build-interference.rkt") ;; for debug
(require "../utilities.rkt")
(provide allocate-registers)

(define (allocate-registers e)
  (match e
   [`(program (,vs ,graph) ,instrs ...)
    `(program (,vs ,(color-graph graph)) ,@instrs)]))

(define (color-graph g)
  (let ([verts (vertices g)])
    (define (loop satscols w)
      (cond
       [(null? w) (map (lambda (v) (car (lookup v satscols))) verts)]
       [else '()]))
    (loop (map (lambda (v) `(v . (0 . '()))) verts) verts)))

(define (max-sat vs)
  (foldr (lambda (x y)
           (if (> (length (cddr x)) (length (cddr y))) x y))
         (car vs)
         vs))


;; TEST
(max-sat `((ra . (0 . (0 1 2))) (j . (0 . (9 2 4 5))) (k . (5 . (2 8 3 4 5)))))

((lambda (p)
   (allocate-registers (build-interference (uncover-live p))))
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
