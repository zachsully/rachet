#lang racket
(provide reveal-functions)

(define (reveal-functions p)
  (match p
   [`(program ,t ,defs ... ,e)
    `(program ,t ,@defs ,e)]))
