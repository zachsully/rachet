#lang racket
(provide assign-homes)

(define (assign-homes e)
  (match e
   (`(program ,vars ,es ...)
    (let ([alist (cdr (foldl
                       (lambda (x ac)
                         (cons (+ 1 (car ac))
                        (cons (list x `(stack ,(- (* 8 (car ac)))))
                                      (cdr ac))))
                       `(1)
                       vars))])
      `(program
        ,vars
        ,@(map
          (lambda (e)
            (match e
             (`(,op ,var ...)
              `(,op ,@(map (lambda (v)
                             (match v
                              [`(var ,r) (let ([maybeV (assoc r alist)])
                                           (if maybeV
                                               (cadr maybeV)
                                              `(var ,r)))]
                              [`,_ v]))
                           var)))))
          es))))))
