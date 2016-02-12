#lang racket
(require "../utilities.rkt")
(provide allocate-registers)

;;
;; Allocate Registers
;;
;; allocate-registers : x86' + interference-graph -> x86' + (var -> reg)
;;
;; Pass takes x86' instructions and an interference graph and returns the
;; instructions with a mapping from variables to registers
;;

;; caller-save registers with rax
(define caller-save^ (set 'rax 'rdx 'rcx 'rsi 'rdi 'r8 'r9 'r10 'r11 ))

(define (allocate-registers e)
  (match e
    [`(program (,vs ,inter-graph) ,instrs ...)
     (let ([sat-graph (make-sat-graph vs)]
           [c-graph (make-color-graph vs)])
       `(program (,vs
                  ,(color-graph vs inter-graph sat-graph c-graph))
                 ,@instrs))]))

;; Initialize the color-graph
(define (make-color-graph vertices)
  (make-hash (map (lambda (v) (cons v #f)) vertices)))

;; Initialize the sat. graph
(define (make-sat-graph vertices)
  (make-hash (map (lambda (v) (cons v 0)) vertices)))

;; Creates the color graph
(define (color-graph vs inter-graph sat-graph c-graph)
 (cond
  [(null? vs) c-graph]
  [else
   (let* ([msat-key (max-sat vs sat-graph (car vs))]
          [color (lowest-color
                  (not-colors
                   (remove 'rax
                           (set->list
                            (hash-ref inter-graph msat-key)))
                   c-graph '())
                  0)])
        (hash-set! c-graph msat-key color)
        (inc-sat msat-key inter-graph sat-graph)
        (color-graph
         (remove msat-key vs) inter-graph sat-graph c-graph))]))

;; Determines what colors can't be used
(define (not-colors inter-ls c-graph ans)
  (cond
      [(null? inter-ls) ans]
      [else (let ([color (if (not (set-member? caller-save (car inter-ls)))
                             (hash-ref c-graph (car inter-ls))
                             (register->color (car inter-ls)))])
              (if (equal? #f color)
                  (not-colors (cdr inter-ls) c-graph ans)
                  (not-colors (cdr inter-ls) c-graph (cons color ans))))]))

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
