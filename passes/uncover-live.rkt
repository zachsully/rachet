#lang racket
(provide uncover-live)

(define (uncover-live e)
  (match e
   [`(program (,vs ,e) ,inst ...)
    `(program (,vs ,(foldl () inst)) ,@inst)]))

(define (recieves e)
  (match e
   [`(,op (,t ,v) (,t2 ,v2))
    `()]))
