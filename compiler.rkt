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

;; (interp-tests "r1p-passes" r1-passes interp-scheme "r1" (range 1 6))
(compiler-tests "r1p-passes" r1-passes "r1" (range 1 20))
(compiler-tests "r1p-passes" r1-passes "r1a" (range 1 9))
(display "tests passed!") (newline)


;; (let ([p `(program (let ([a 1])
;;   (let ([b 1])
;;     (let ([c 1])
;;       (let ([d 1])
;;         (let ([e 1])
;;           (let ([f 1])
;;             (let ([g 1])
;;               (let ([h 1])
;;                 (let ([i 1])
;;                   (let ([j 1])
;;                     (let ([k 1])
;;                       (let ([l 1])
;;                         (let ([m 1])
;;                           (let ([n 1])
;;                             (let ([o 1])
;;                               (let ([p 1])
;;                                 (let ([q 1])
;;                                   (let ([r 1])
;;                                     (let ([s 1])
;;                                       (let ([t 1])
;;                                         (let ([u 1])
;;                                           (+ a 
;;                                           (+ b 
;;                                           (+ c 
;;                                           (+ d 
;;                                           (+ e 
;;                                           (+ f 
;;                                           (+ g 
;;                                           (+ h 
;;                                           (+ i 
;;                                           (+ j 
;;                                           (+ k 
;;                                           (+ l 
;;                                           (+ m 
;;                                           (+ n 
;;                                           (+ o
;;                                           (+ p 
;;                                           (+ q 
;;                                           (+ r 
;;                                           (+ s 
;;                                           (+ t 
;;                                           (+ u 21)))))))))))))))))))))))))))))))))))))))))) 
      
;; )])
;;   (interp-x86 (patch-instructions
;;     (assign-homes
;;      (allocate-registers
;;       (build-interference
;;        (uncover-live
;; 	(select-instructions
;; 	 (flatten (uniquify p))))))))))
