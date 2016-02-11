#lang racket
(require "uncover-live.rkt") ;; for debug

(require "build-interference.rkt") ;; for debug
(require "allocate-registers.rkt") ;; for debug

(require "../utilities.rkt")
(provide assign-homes)


(define assign-homes
  (lambda (e)
    (match e
     [`(program (,vars ,reg-map) ,instr ...)
      (begin
        (color->reg reg-map)
        `(program (,vars ,reg-map) ,@(assign-helper instr reg-map)))])))

(define assign-helper
  (lambda (instr reg-map)
    (map
     (lambda (x)
      (match x
       [`() '(nothing)]
       [`(if (eq? ,_ (var ,x)) ,thn ,els)
        (let ([cnd^ (hash-ref reg-map x)]
              [thn^ (assign-helper thn reg-map)]
              [els^ (assign-helper els reg-map)])
          `(if (eq? (int 1) ,cnd^) ,thn^ ,els^))]
       [`(if (eq? ,_ ,cnd) ,thn ,els)
        (let ([thn^ (assign-helper thn reg-map)]
              [els^ (assign-helper els reg-map)])
          `(if (eq? (int 1) ,cnd) ,thn^ ,els^))]
       [`(,op (var ,x) (var ,y))
        (let ([x^ (hash-ref reg-map x)]
              [y^ (hash-ref reg-map y)])
          `(,op ,x^ ,y^))]
       [`(,op (int ,x) (var ,y))
        (let ([y^ (hash-ref reg-map y)])
          `(,op (int ,x) ,y^))]
       [`(,op (var ,x) ,y)
        (let ([x^ (hash-ref reg-map x)])
          `(,op ,x^ ,y))]
       [`(negq (var ,x))
        `(negq ,(hash-ref reg-map x))]
       [`(,op (,typex ,x) (,typey ,y))
        (let ([x^ (hash-ref reg-map x #f)]
              [y^ (hash-ref reg-map y #f)])
          (cond
           [(and (equal? x^ #f) (equal? y^ #f))
            `(,op (,typex ,x) (,typey ,y))]
           [(equal? x^ #f) `(,op (,typex ,x) ,y^)]
           [else `(,op ,x^ (,typey ,y))]))]
       [`(callq ,x) `(callq ,x)]
       [`,_ x]))
         instr)))

(define color->reg
  (lambda (color-hash)
    (hash-map
     color-hash
     (lambda (x y)
       (if (> y 12)
           (hash-set! color-hash x
                      `(stack ,(- (* 8 (- y 12)))))
           (hash-set! color-hash x
                      `(reg ,(vector-ref general-registers y))))))))
