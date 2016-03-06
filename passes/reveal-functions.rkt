#lang racket
(provide reveal-functions)

(define (reveal-functions p)
  (match p
   [`(program (defines ,defs ...) ,t ,e)
    `(program ,t ,e)]))
