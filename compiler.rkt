#lang racket
(require "utilities.rkt")
(require "interp.rkt")
(require "passes/uniquify.rkt")
(require "passes/flatten.rkt")
(require "passes/select-instructions.rkt")
(require "passes/assign-homes.rkt")
(require "passes/patch-instructions.rkt")
(require "passes/print-x86.rkt")

(provide r1-passes)

;; (define (structure e)
;;   (cond
;;    [(symbol? e) `(var ,e)]
;;    [else `(int ,e)]))

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("patch instructions",patch-instructions,interp-x86)
                    ("print-x86",print-x86, #f)
                    ))

(interp-tests "r1p-passes" r1-passes interp-scheme "r1" (range 1 20))
(compiler-tests "r1p-passes" r1-passes "r1" (range 1 20))
(display "tests passed!") (newline)
