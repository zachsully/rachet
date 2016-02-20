#lang racket
(require "../utilities.rkt")
(require "../uncover-types.rkt")
(provide expose-allocation)

;;
;; Expose-Allocation
;;
;; expose-allocation : C3 -> C3
;;
;; Pass:
;; > inserts intialize statement at the top (setting up garbage collector)
;; > changes the form
;;  (assign <lhs> (vector <f> .. <e>))
;;           -to-
;;  (if (collection-needed? <bytes>)
;;      ((collect <bytes>))
;;      ())
;;  (assign <lhs> (allocate <len> <type>))
;;  (vector-set! <lhs> 0 <f>)
;;   ..
;;  (vector-set! <lhs> (len -1) <e>)
;;

(define (expose-allocation p)
  (match p
   [`(program ,extra ,t ,stmts ...)
    (let* ([types (uncover-types p)]
           [stmts^ (foldr
                    (lambda (stmt acc)
                     (match stmt
                      [`(assign ,var (vector ,es ...))
                       (let* ([vsets (vector-setting var es)]
                              [bytes (+ 8 (* 8 (cdr vsets)))])
                         (append `((if (collection-needed? ,bytes)
                                       ((collect ,bytes))
                                       ())
                                   (assign ,var
                                           (allocate ,(length es)
                                                     ,(lookup var types)))
                                   ,@(car vsets))
                                 acc))]

                      [`,_ (append `(,stmt) acc)])) '() stmts)])
      (void-vec-sets `(program ,(uncover-types p)
                               ,t
                               ,@stmts^)))]))

(define (vector-setting var es)
 ((lambda (f)
    (foldl f `(() . 0) es))
  (lambda (e acc)
    (let ([tmp (gensym "void.")])
      (cons (append (car acc)
                    `((assign ,tmp (vector-set! ,var ,(cdr acc) ,e))))
          (+ 1 (cdr acc)))))))

;; take program and turns vector-sets! into assign... as well as adds them to
;; the variables
(define (void-vec-sets p)
  (match p
   [`(program ,vars ,t ,stmts ...)
    (let ([voids (foldr
                  (lambda (s acc)
                    (match s
                     [`(assign ,v (vector-set! ,_ ,_ ,_))
                      (cons (cons v 'Void) acc)]
                     [`,_ acc]))
                  '()
                  stmts)])
      `(program ,(append vars voids)
                ,t
                ,@(cons `(initialize 10000 10000) stmts)))]))
