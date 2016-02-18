#lang racket
(require "utilities.rkt")
(require "interp.rkt")
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
         "passes/typecheck-R2.rkt")

(provide r1-passes r2-passes compile-prog)

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ("uncover-live",uncover-live,interp-x86)
                    ("build-interference",build-interference,interp-x86)
                    ("allocate-registers",allocate-registers,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("patch instructions",patch-instructions,interp-x86)
                    ("print-x86",print-x86, #f)
                    ))

(define r2-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ("uncover-live",uncover-live,interp-x86)
                    ("build-interference",build-interference,interp-x86)
                    ("allocate-registers",allocate-registers,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("lower-conditionals",lower-conditionals,interp-x86)
                    ("patch instructions",patch-instructions,interp-x86)
                    ("print-x86",print-x86, #f)
                    ))

(define (compile-prog p)
  (assign-homes
   (allocate-registers
      (build-interference
       (uncover-live
        (select-instructions
         (flatten
          (uniquify p))))))))

(display
 (flatten
  `(program
    (vector-ref (vector-ref (vector (vector 42)) 0) 0))))
(newline)
(display
 (flatten
  `(program
    (+ 41 1))))
(newline)
(display
 (flatten
  `(program
    (let ([myv (vector 0)])
      (let ([_ (vector-set! myv 0 42)])
        myv)))))
(newline)
(display
 (flatten
  `(program
    (vector 42 51))))


;; (interp-tests "r1" typecheck-R2 r1-passes interp-scheme "r1" (range 1 20))
;; (interp-tests "r1a" typecheck-R2 r1-passes interp-scheme "r1a" (range 1 9))
;; (interp-tests "r2" typecheck-R2 r1-passes interp-scheme "r2" (range 1 10))
;; (compiler-tests "r1p" typecheck-R2 r1-passes "r1" (range 1 20))
;; (compiler-tests "r1-passes" typecheck-R2 r1-passes "r1" (range 1 20))
;; (compiler-tests "r1a-passes" typecheck-R2 r1-passes "r1a" (range 1 9))
;; (compiler-tests "r2-passes" typecheck-R2 r2-passes "r2" (range 1 20))
;; (display "tests passed!") (newline)
