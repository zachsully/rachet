#lang racket
(require "../utilities.rkt")
(provide assign-homes)

;;
;; Assign Homes
;;
;; assign-homes : x86' + (var -> reg) -> x86'
;;
;; Pass takes a
;;

(define (assign-homes e)
  (match e
   [`(program (,vars ,reg-map) ,t ,instrs ...)
    (begin
      (color->reg reg-map)
      `(program (,vars ,reg-map) ,t ,@(assign-reg instrs reg-map '())))]))


(define (assign-reg instrs reg-map ans)
  (if (null? instrs)
      ans
      (assign-reg
       (cdr instrs)
       reg-map
       (append ans (assign-helper (car instrs)reg-map)))))

(define (assign-helper instr reg-map)
  (match instr
   [`(,op (,typex ,x) (offset (,typey ,y) ,i))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `((,op (,typex ,x)) (offset (,typey ,y) ,i))]
       [(equal? x^ #f)
	`((,op (,typex ,x) (offset ,y^ ,i)))]
       [(equal? y^ #f) `((,op ,x^ (,typey ,y)))]
       [else `((,op ,x^ (offset ,y^ ,i)))]))]

   [`(,op (offset (,typex ,x) ,i) (,typey ,y))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `((,op (offset (,typex ,x) i) (,typey ,y)))]
       [(equal? x^ #f) `((,op (offset (,typex ,x), i) ,y^))]
       [(equal? y^ #f) `((,op (offset ,x^ ,i) (,typey ,y)))]
       [else `((,op (offset ,x^ ,i) ,y^))]))]

   [`(,op (offset (,typex ,x) ,i) (offset (,typey ,y) ,j))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `((,op (offset (,typex ,x) i) (offset (,typey ,y) ,i)))]
       [(equal? x^ #f) `((,op (offset (,typex ,x), i) (offset ,y^ ,i) ))]
       [(equal? y^ #f) `((,op (offset ,x^ ,i) (offset (,typey ,y) ,i)))]
       [else `((,op (offset ,x^ ,i) (offset ,y^ ,i)))]))]

   [`(,op (,typex ,x) (,typey ,y))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `((,op (,typex ,x) (,typey ,y)))]
       [(equal? x^ #f) `((,op (,typex ,x) ,y^))]
       [(equal? y^ #f) `((,op ,x^ (,typey ,y)))]
       [else `((,op ,x^ ,y^))]))]

   [`(negq (var ,x)) `((negq ,(hash-ref reg-map x)))]

   [`(sete ,x) `((sete ,x))]

   [`(setl ,x) `((setl ,x))]

   [`(if (eq? ,t ,cnd) ,thn ,els)
    (let ([cnd^ (if (eq? (car cnd) 'var) (hash-ref reg-map (cadr cnd)) cnd)]
          [thn^ (assign-reg thn reg-map '())]
          [els^ (assign-reg els reg-map '())])
      `((if (eq? ,t ,cnd^) ,thn^ ,els^)))]

   [`(callq ,x) `((callq ,x))]))



(define (color->reg color-hash)
  (hash-map
   color-hash
   (lambda (x y)
     (if (> y 12)
         (hash-set! color-hash x `(stack ,(- (* 8 (- y 12)))))
         (hash-set! color-hash x `(reg ,(vector-ref general-registers y)))))))
