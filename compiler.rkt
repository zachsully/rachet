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
(require "passes/print-x86.rkt")

(provide r1-passes)

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

(interp-tests "r1p-passes" r1-passes interp-scheme "r1" (range 1 6))
(compiler-tests "r1p-passes" r1-passes "r1" (range 1 20))
(compiler-tests "r1p-passes" r1-passes "r1a" (range 1 9))
;; (display "tests passed!") (newline)


;; (let ([p `(program (let ([a (read)])
;;   (let ([b (read)])
;;     (let ([c (read)])
;;       (let ([d (read)])
;;         (let ([e (read)])
;;           (let ([f (read)])
;;             (let ([g (read)])
;;               (let ([h (read)])
;;                 (let ([i (read)])
;;                   (let ([j (read)])
;;                     (let ([k (read)])
;;                       (+ a 
;;                          (+ b 
;;                             (+ c 
;;                                (+ d 
;;                                   (+ e 
;;                                      (+ f 
;;                                         (+ g 
;;                                            (+ h 
;;                                               (+ i 
;;                                                  (+ j
;;                                                     (+ k 31)))))))))))))))))))))) 

  
;; )])
;;   (display (print-x86 (patch-instructions
;;     (assign-homes
;;      (allocate-registers
;;       (build-interference
;;        (uncover-live
;; 	(select-instructions
;; 	 (flatten (uniquify p)))))))))))
