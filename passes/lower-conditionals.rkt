#lang racket
(provide lower-conditionals)

;; This pass takes the if-statements remaining in our x86* lang and lowers
;; them branching and jumping
(define lower-conditionals
  (lambda (e)
    (match e
     [`(program ,v ,es ...)
      `(program ,v ,@(foldr (lambda (e^ acc) (append (get-low e^) acc))
                            '()
                            es))])))

(define (get-low e)
  (match e
   [`(if (eq? ,e1 ,e2) ,thn ,els)
    (let ([then-label (gensym "then")]
          [else-label (gensym "else")]
          [end-label (gensym "end")])
      `((cmpq ,e1 ,e2)
        (je ,then-label)
        ,@els
        (jmp ,end-label)
        (label ,then-label)
        ,@thn
        (label ,end-label)))]
   [else `(,e)]))


;; (lower-conditionals
;;  `(program (stuff)
;;    (if (eq? (int 1) (int 1))
;;        ((movq (int 42) (reg rbx)))
;;        ((movq (int 0) (reg rbx))))))
