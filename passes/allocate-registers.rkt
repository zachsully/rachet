#lang racket
(require "uncover-live.rkt") ;; for debug
(require "build-interference.rkt") ;; for debug
(require "../utilities.rkt")
(provide allocate-registers)

(define (allocate-registers e)
  (match e
    [`(program (,vs ,inter-graph) ,instrs ...)
     (let ([sat-graph (make-sat-graph vs)]
           [c-graph (make-color-graph vs)])
       `(program (,vs ,(color-graph vs inter-graph sat-graph c-graph)) ,@instrs))]))

;; Initialize the color-graph
(define (make-color-graph vertices)
  (make-hash (map (lambda (v) (cons v #f)) vertices)))

;; Initialize the sat. graph
(define (make-sat-graph vertices)
  (make-hash (map (lambda (v) (cons v 0)) vertices)))

;; Creates the color graph
(define color-graph
  (lambda (vs inter-graph sat-graph c-graph)
   (cond
     [(null? vs) c-graph]
     [else
      (let* ([msat-key (max-sat vs sat-graph (car vs))]
             [color (lowest-color (not-colors (remove 'rax (set->list (hash-ref inter-graph msat-key))) c-graph '()) 0)])
        (hash-set! c-graph msat-key color)
        (inc-sat msat-key inter-graph sat-graph)
        (color-graph (cdr vs) inter-graph sat-graph c-graph))])))

;; Determines what colors can't be used
(define not-colors
  (lambda (inter-ls c-graph ans)
    (cond
      [(null? inter-ls) ans]
      [else (let ([color (hash-ref c-graph (car inter-ls))])
              (if (equal? #f color)
                  (not-colors (cdr inter-ls) c-graph ans)
                  (not-colors (cdr inter-ls) c-graph (cons (hash-ref c-graph (car inter-ls)) ans))))])))

;; Determines the lowest color to use
(define lowest-color
  (lambda (ls count)
    (cond
      [(member count ls) (lowest-color ls (add1 count))]
      [else count])))

;; Max sat find the key with largest saturation number
(define max-sat
  (lambda (vs sat-graph ans)
    (cond
      [(null? vs) ans]
      [(< (hash-ref sat-graph ans) (hash-ref sat-graph (car vs)))
       (max-sat (cdr vs) sat-graph (car vs))]
      [else (max-sat (cdr vs) sat-graph ans)])))

;; Increase sat. for all adjacent nodes
(define inc-sat
  (lambda (var inter-graph sat-graph)
    (let ([update-ls (set->list (hash-ref inter-graph var))])
      (for ([i update-ls]
            #:when (not (equal? 'rax i)))
        (hash-set! sat-graph i (+ 1 (hash-ref sat-graph i)))))))

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
;;   (allocate-registers inter-graph))
