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
                    ("uncover-live",uncover-live,interp-x86)
                    ("build-interference",build-interference,interp-x86)
                    ("allocate-registers",allocate-registers,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ("lower-conditionals",lower-conditionals,interp-x86)
                    ("patch instructions",patch-instructions,#f)
                    ("print-x86",print-x86, #f)
                    ))



;;;;;
;;;;; CLASS TESTS
;;;;;

;; (interp-tests "r1" typecheck r3-passes interp-scheme "r1" (range 1 20))
;; (interp-tests "r1a" typecheck r3-passes interp-scheme "r1a" (range 1 9))
;; (interp-tests "r2" typecheck r3-passes interp-scheme "r2" (range 1 24))
;; (interp-tests "r3" typecheck r3-passes interp-scheme "r3" '(2))
;; (compiler-tests "r1-passes" typecheck r3-passes "r1" (range 1 20))
;; (compiler-tests "r1a-passes" typecheck r3-passes "r1a" (range 1 9))
;; (compiler-tests "r2-passes" typecheck r3-passes "r2" (range 1 24))
(compiler-tests "r3-passes" typecheck r3-passes "r3" (range 1 16))
(display "tests passed!") (newline)

;;;;;
;;;;; UNIT TESTING
;;;;;
(define (compile-prog p passes)
  (pretty-print (foldl (lambda (pass prog)
			 (let ([out (pass prog)])
			   ;; (pretty-print out)
			   ;; (display "  =>") (newline)
			   out)) p passes)))

(compile-prog
 ;; `(program (let ([a (vector 1)])
 ;; 	     (let ([b (vector 1)])
 ;; 	       (let ([c (vector 1)])
 ;; 		 (let ([d (vector 1)])
 ;; 		   (+ (vector-ref a 0)
 ;; 		      (+ (vector-ref b 0)
 ;; 			 (+ (vector-ref c 0)
 ;; 			    (vector-ref d 0)))))))))
 ;; `(program (let ([a (vector 1)])
 ;; 	     (let ([b (vector 1)])
 ;; 	       (let ([c (vector 1)])
 ;; 		 (+ (vector-ref a 0)
 ;; 		      (+ (vector-ref b 0)
 ;; 			 (vector-ref c 0)))))))
 `(program (let ([v (vector 20 22)])
	     (+ (vector-ref v 1) (vector-ref v 1)))
	   )
 `(,typecheck
   ,uniquify
   ,flatten
   ,expose-allocation
   ,uncover-call-live-roots
   ,select-instructions
   ,uncover-live
   ,build-interference
   ,allocate-registers
   ,assign-homes
   ,lower-conditionals
   ,patch-instructions
   ,print-x86
   ,display
   )
 )
