#lang racket

;;(require "flatten.rkt")
;;(require "select-instructions.rkt")
;;(require "uncover-live.rkt") ;; for debug
;;(require "build-interference.rkt") ;; for debug
(require "../utilities.rkt")
(provide allocate-registers)

;; caller-save registers with rax
(define caller-save^ (set 'rax 'rdx 'rcx 'rsi 'rdi 'r8 'r9 'r10 'r11 )) 

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
             [color (lowest-color (not-colors (remove 'rax
                                                      (set->list (hash-ref inter-graph msat-key))) c-graph '()) 0)])
        (hash-set! c-graph msat-key color)
        (inc-sat msat-key inter-graph sat-graph)
        (color-graph (remove msat-key vs) inter-graph sat-graph c-graph))])))

;; Determines what colors can't be used
(define not-colors
  (lambda (inter-ls c-graph ans)
    (cond
      [(null? inter-ls) ans]
      [else (let ([color (if (not (set-member? caller-save (car inter-ls))) (hash-ref c-graph (car inter-ls)) (register->color (car inter-ls)))])
              (if (equal? #f color)
                  (not-colors (cdr inter-ls) c-graph ans)
                  (not-colors (cdr inter-ls) c-graph (cons color ans))))])))

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
            #:when (not (set-member? caller-save^ i)))
        (hash-set! sat-graph i (+ 1 (hash-ref sat-graph i)))))))

#|

(define q '(program (let ([x 20]) (let ([y 22]) (+ x y)))))

(define x '(program (let ([v 1])
                      (let ([w 46])
                        (let ([x (+ v 7)])
                          (let ([y (+ 4 x)])
                            (let ([z (+ x w)])
                              (+ z (- y)))))))))

(define y '(program (let ((a 1))
                      (let ((b 1))
                        (let ((c 1))
                          (let ((d 1))
                            (let ((e 1))
                              (let ((f 1))
                                (let ((g 1))
                                  (let ((h 1))
                                    (let ((i 1))
                                      (let ((j 1))
                                        (let ((k 1))
                                          (let ((l 1))
                                            (let ((m 1))
                                              (let ((n 1))
                                                (let ((o 1))
                                                  (let ((p 1))
                                                    (let ((q (read)))
                                                      (let ((r 1))
                                                        (let ((s 1))
                                                          (let ((t 1))
                                                            (let ((u 1))
                                                              (+ a (+ b (+ c (+ d (+ e (+ f (+ g (+ h (+ i (+ j (+ k (+ l (+ m (+ n (+ o (+ p (+ q (+ r (+ s (+ t (+ u 21))))))))))))))))))))))))))))))))))))))))))))



(define p
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
            (subq (var y) (reg rax))))

(let* ([flatten-pass (flatten y)]
       [select-pass (select-instructions flatten-pass)]
       [uncover-pass (uncover-live select-pass)]
       [inter-pass (build-interference uncover-pass)]
       [allocate-pass (allocate-registers inter-pass)]
       ;;[assign-pass (assign-homes allocate-pass)]
       )
  ;;(display flatten-pass)(newline)(newline)
  ;;(display select-pass) (newline)(newline)
  (display allocate-pass) (newline) (newline)
  ;;(display assign-pass)
  )
  ;;(match inter-pass
    ;;[`(program (,vs ,inter-graph) ,instru ...) (print-dot inter-graph "graph.
  ;;(allocate-registers inter-graph))



(let ([inter-graph (build-interference (uncover-live (select-instructions (flatten x))))])
  (display inter-graph)
  (allocate-registers inter-graph))

;; ;; Test case
;; (define s
;;   `(program (x y g108566)
;;             (movq (int 20) (var x))
;;             (movq (int 22) (var y))
;;             (addq (var x) (var y))
;;             (movq (var y) (var g108566))
;;             (movq (var g108566) (reg rax))))



;; (let ([inter-graph (build-interference (uncover-live p))])
;;   (allocate-registers inter-graph))
;; |#
