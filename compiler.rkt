#lang racket
(require "utilities.rkt")
(require "interp.rkt")
(require racket/pretty)
(require "passes/uniquify.rkt"
         "passes/flatten.rkt"
         "passes/select-instructions.rkt"
         "passes/assign-homes.rkt"
         "passes/uncover-live.rkt"
         "passes/build-interference.rkt"
         "passes/allocate-registers.rkt"
         "passes/patch-instructions.rkt"
         "passes/lower-conditionals.rkt"
         "passes/expose-allocation.rkt"
         "passes/uncover-call-live-roots.rkt"
         "passes/print-x86.rkt"
         "passes/typecheck.rkt")

(provide r3-passes compile-prog)

(define r3-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("expose-allocation",expose-allocation,interp-C)
                    ("uncover-call-live-roots",uncover-call-live-roots,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ;; ("uncover-live",uncover-live,interp-x86)
                    ;; ("build-interference",build-interference,interp-x86)
                    ;; ("allocate-registers",allocate-registers,interp-x86)
                    ;; ("assign homes",assign-homes,interp-x86)
                    ;; ("lower-conditionals",lower-conditionals,interp-x86)
                    ;; ("patch instructions",patch-instructions,interp-x86)
                    ;; ("print-x86",print-x86, #f)
                    ))

;;;;;
;;;;; CLASS TESTS
;;;;;

;; (interp-tests "r1" typecheck r3-passes interp-scheme "r1" (range 1 20))
;; (interp-tests "r1a" typecheck r3-passes interp-scheme "r1a" (range 1 9))
;; (interp-tests "r2" typecheck r3-passes interp-scheme "r2" (range 1 24))
(interp-tests "r3" typecheck r3-passes interp-scheme "r3" (range 1 16))
;; (compiler-tests "r1-passes" typecheck r3-passes "r1" (range 1 20))
;; (compiler-tests "r1a-passes" typecheck r3-passes "r1a" (range 1 9))
;; (compiler-tests "r2-passes" typecheck r3-passes "r2" (range 1 24))
(display "tests passed!") (newline)


;;;;;
;;;;; UNIT TESTING
;;;;;
(define (compile-prog p passes)
  (pretty-print (foldl (lambda (pass prog)
			 (let ([out (pass prog)])
			   (pretty-print out)
			   (display "  =>") (newline)
			   out)) p passes)))
(define (compile-progs ps passes)
  (map (lambda (p) (compile-prog p passes)(newline)(newline)) ps))

(define test1 `(program (vector-ref (vector-ref (vector (vector 42)) 0) 0)))
(define test2 `(program (vector-ref (vector #t #f 0 42 9) 3)))
(define test3 `(program 42))
(define test4 `(program (if (eq? 42 42) (+ 2 40) 567)))
(define test5 `(program (let ([x (vector #t)])
                          (let ([y (vector #f)])
                            (let ([z (vector 42)]) z)))))

;; (compile-progs
;;  `(
;;    (program (vector #t (vector #f (vector 42)) 69))
;;    )
;;  `(
;;    ,uniquify
;;    ,flatten
;;    ;; ,expose-allocation
;;    ;; ,uncover-call-live-roots
;;    ;; ,select-instructions
;;    ;; ,uncover-live
;;    ;; ,build-interference
;;    ;; ,allocate-registers
;;    ;; ,assign-homes
;;    ;; ,lower-conditionals
;;    ;; ,patch-instructions
;;    ;; ,print-x86
;;    ))
