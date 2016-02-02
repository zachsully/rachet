#lang racket
(require "uncover-live.rkt") ;; for debug

(require "build-interference.rkt") ;; for debug
(require "allocate-registers.rkt") ;; for debug

(require "../utilities.rkt")
(provide assign-homes)


(define (assign-homes e)
  (match e
   (`(program (,vars ,allocation) ,es ...)
    (let ([alist (foldl (lambda (x acc)
                          (match x
                                 [`(,v . ,c) (cons `(,v . ,(color-regs c)) acc)]))
                        '()
                        (hash->list allocation))])
      `(program
        ,vars
        ,@(map
          (lambda (e)
            (match e
             (`(,op ,var ...)
              `(,op ,@(map (lambda (v)
                             (match v
                              [`(var ,r) (lookup r alist)]
                              [`,_ v]))
                           var)))))
          es))))))

(define (color-regs i)
  (if (> i 12)
        `(stack ,(- (* 8 (- i 12))))
        `(reg ,(vector-ref general-registers i))))

;; (define p
;;   `(program (v w x y z)
;;             (movq (int 1) (var v))       ;; v
;;             (movq (int 46) (var w))      ;; v,w
;;             (movq (var v) (var x))       ;; w,x
;;             (addq (int 7) (var x))       ;; w,x
;;             (movq (var x) (var y))       ;; w,x,y
;;             (addq (int 4) (var y))       ;; w,x,y
;;             (movq (var x) (var z))       ;; w,y,z
;;             (addq (var w) (var z))       ;; y,z
;;             (movq (var z) (reg rax))     ;; y,rax
;;             (subq (var y) (reg rax))))

;; (let ([inter-graph (build-interference (uncover-live p))])
;;   (assign-homes (allocate-registers inter-graph)))
