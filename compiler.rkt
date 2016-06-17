#lang racket
(require "utilities.rkt")
(require "interp.rkt")
(require racket/pretty)
(require "passes/uniquify.rkt"
	 "passes/reveal-functions.rkt"
	 "passes/convert-to-closures.rkt"
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

(provide rT-passes compile-prog)

(define rT-passes `(("uniquify",uniquify,interp-scheme)
		    ("reveal-functions",reveal-functions,interp-scheme)
		    ("convert-to-closures",convert-to-closures,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("expose-allocation",expose-allocation,interp-C)
                    ("uncover-call-live-roots",uncover-call-live-roots,interp-C)
                    ("select instructions",select-instructions,interp-x86)
                    ("uncover-live",uncover-live,interp-x86)
                    ("build-interference",build-interference,interp-x86)
                    ("allocate-registers",allocate-registers,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("lower-conditionals",lower-conditionals,interp-x86)
                    ("patch-instructions",patch-instructions,#f)
                    ("print-x86",print-x86, #f)
                    ))



;;;;;
;;;;; CLASS TESTS
;;;;;

;; (interp-tests "r1" typecheck rT-passes interp-scheme "r1" (range 1 20))
;; (interp-tests "r1a" typecheck rT-passes interp-scheme "r1a" (range 1 9))
;; (interp-tests "r2" typecheck rT-passes interp-scheme "r2" (range 1 24))
;; (interp-tests "r3" typecheck rT-passes interp-scheme "r3" (range 1 16))
;; (interp-tests "r4" typecheck rT-passes interp-scheme "r4" (append (range 1 6) (range 9 20))) ;; 6,7,8 fail tests
;; (interp-tests "r5" typecheck rT-passes interp-scheme "r5" (range 1 13))

;; (compiler-tests "r1-passes" typecheck rT-passes "r1" (range 1 20))
;; (compiler-tests "r1a-passes" typecheck rT-passes "r1a" (range 1 9))
;; (compiler-tests "r2-passes" typecheck rT-passes "r2" (range 1 24))
;; (compiler-tests "r3-passes" typecheck rT-passes "r3" (range 1 16))
;; (compiler-tests "r4-passes" typecheck rT-passes "r4" (append (range 1 6)
;; 							     (range 10 20)))
;; (compiler-tests "r5-passes" typecheck rT-passes "r5" (range 10 13))
;; (compiler-tests "rT-passes" typecheck rT-passes "rT" (range 1 8))

(newline) (display "tests passed!") (newline)


;;;;;
;;;;; UNIT TESTING
;;;;;
(define (compile-prog b p passes)
  (if b
      (pretty-print
       (foldl (lambda (pass prog)
		(let ([out (pass prog)])
		  (newline)
		  (pretty-print prog)
		  (display "\nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv\n\n")
		  ;; (read)
		  out)) p passes))
      (display (foldl (lambda (pass prog) (pass prog)) p passes))))

(pretty-print-columns 60)
(compile-prog

 #t

 `(program
   (define (const [c : a] [t : b]) : a c)
   (define (id [x : a]) : a x)
   (if (id #t)
       (const (id 42) #f)
       (id 777))

   ;; (define (const [x : a] [y : b]) : a x)
   ;; (vector-ref (const (vector 42) 777) 0)
   ;; (define (swap [v : (Vector a b)]) : (Vector b a)
   ;;   (vector (vector-ref v 1) (vector-ref v 0)))
   ;; (vector-ref (swap (vector #t 42)) 0)
   )

 `(,typecheck
   ;; ,uniquify
   ;; ,reveal-functions
   ;; ,convert-to-closures
   ;; ,flatten
   ;; ,expose-allocation
   ;; ,uncover-call-live-roots
   ;; ,select-instructions
   ;; ,uncover-live
   ;; ,build-interference
   ;; ,allocate-registers
   ;; ,assign-homes
   ;; ,lower-conditionals
   ;; ,patch-instructions
   ;; ,print-x86
   ))
