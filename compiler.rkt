#lang racket
(require "utilities.rkt")
(require "interp.rkt")
(require "passes/uniquify.rkt")
(require "passes/flatten.rkt")
(require "passes/select-instructions.rkt")
(require "passes/assign-homes.rkt")
(require "passes/uncover-live.rkt")
(require "passes/build-interference.rkt")
(require "passes/allocate-registers.rkt")
(require "passes/patch-instructions.rkt")
(require "passes/lower-conditionals.rkt")
(require "passes/print-x86.rkt")
(require "passes/typecheck-R2.rkt")
(require "passes/macros.rkt")

(provide r1-passes)

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ("macros", macros, interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ("uncover-live",uncover-live,interp-x86)
                    ("build-interference",build-interference,interp-x86)
                    ("allocate-registers",allocate-registers,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("patch instructions",patch-instructions,interp-x86)
                    ("lower-conditionals",lower-conditionals,interp-x86)
                    ;; ("print-x86",print-x86, #f)
                    ))

(define (compile-prog p)
  (assign-homes
   (allocate-registers
      (build-interference
       (uncover-live
        (select-instructions
         (flatten
          (uniquify p))))))))

;; (display (compile-prog `(program (eq? 1 2))))
(interp-tests "r1" typecheck-R2 r1-passes interp-scheme "r1" (range 1 20))
(interp-tests "r1a" typecheck-R2 r1-passes interp-scheme "r1a" (range 1 9))
(interp-tests "r2" typecheck-R2 r1-passes interp-scheme "r2" (range 1 10))
;; (compiler-tests "r1p" typecheck-R2 r1-passes "r1" (range 1 20))
;; (compiler-tests "r1a-passes" typecheck-R2 r1-passes "r1a" (range 1 9))
;; (compiler-tests "r2" typecheck-R2 r1-passes "r2" (range 1 10))
;; (compiler-tests "r1-passes" typecheck-R2 r1-passes "r1" (range 1 20))
;; (display "tests passed!") (newline)
