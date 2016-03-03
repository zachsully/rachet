#lang racket

(require "utilities.rkt")
(require "interp.rkt")
(require "compiler.rkt")

;; (debug-level 4)

(interp-tests "integers and arithmetic" #f r3-passes interp-scheme "r0" (range 1 5))
(display "tests passed!") (newline)
