#lang racket
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
   [`(program ,extra (type ,t) ,stmts ...)
    `(program ,extra
              ,@(foldr
                 (lambda (stmt acc)
                   (match stmt
                    [`(assign ,var (vector ,es ...))
                     (let* ([vsets (vector-setting var es)]
                            [bytes (+ 8 (* 8 (cdr vsets)))])
                       (append `((if (collection-needed? ,bytes)
                                     ((collect ,bytes))
                                     ())
                                 (assign ,var (allocate ,(length es) 'foo))
                                 ,@(car vsets))
                               acc))]

                    [`,_ (append `(,stmt) acc)]))
                 '()
                 stmts))]))

(define (vector-setting var es)
 ((lambda (f)
    (foldr f `(() . 0) es))
  (lambda (e acc)
    (cons (append (car acc)
                  `((vector-set! ,var ,(cdr acc) ,e)))
          (+ 1 (cdr acc))))))

;; (vector-setting 'foo (range 1 10))
;; (range 1 10)
;; (expose-allocation
;;  `(program (t.1 t.2 t.3 t.4)
;;    (assign t.1 (vector 42))
;;    (assign t.2 (vector t.1))
;;    (assign t.3 (vector-ref t.2 0))
;;    (assign t.4 (vector-reg t.3 0))
;;    (return t.4)))
