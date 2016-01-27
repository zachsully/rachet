#lang racket
(provide allocate-registers)

(define (allocate-registers e)
  (match e
   [`(program (,vs ,graph) ,instrs ...)
    `(program ,vs ,@instrs)]))
