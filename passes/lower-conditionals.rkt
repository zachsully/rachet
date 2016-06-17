#lang racket
(provide lower-conditionals)

;; This pass takes the if-statements remaining in our x86* lang and lowers
;; them branching and jumping
(define lower-conditionals
  (lambda (e)
    (match e
     [`(program ,extra (defines ,defs ...) ,es ...)
      `(program ,extra
		(defines ,@(map lower-conditionals defs))
		,@(append-map get-low es))]

     [`(define (,f) ,num-locals (,vars ,max-stack) ,locals ,instrs ...)
      `(define (,f)
	 ,num-locals
	 (,vars ,max-stack)
	 ,locals
	 ,@(append-map get-low instrs))])))

(define (get-low e)
  (match e
   [`(if (eq? ,e1 ,e2) ,thn ,els)
    (let ([then-label (gensym "then")]
          [else-label (gensym "else")]
          [end-label (gensym "end")])
      `((cmpq ,e1 ,e2)
        (je ,then-label)
        ,@(append-map get-low els)
        (jmp ,end-label)
        (label ,then-label)
        ,@(append-map get-low thn)
        (label ,end-label)))]
   [else `(,e)]))
