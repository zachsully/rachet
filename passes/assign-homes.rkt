#lang racket
(require "../utilities.rkt")
(require "../runtime-config.rkt")
(provide assign-homes)

;;
;; Assign Homes
;;
;; assign-homes : x86' + (var -> reg) -> x86'
;;
;; Pass takes a
;;

(define (assign-homes p)
  (match p
   [`(program (,vars ,reg-map) ,t (defines ,defs ...) ,instrs ...)
    (begin
      (color->reg reg-map)
      `(program (,vars)
		,t
		(defines ,@(map (lambda (d)
				  (match d
    				   [`(define (,f)
				       ,num-locals (,vars ,max-stack)
				       ,instrs ...)
				    `(define (,f)
				       ,num-locals (,vars ,max-stack)
				       ,@(assign-reg instrs reg-map))])) defs))
		,@(assign-reg instrs reg-map)))]))


(define (assign-reg instrs reg-map)
  (map (lambda (i) (assign-helper i reg-map)) instrs))


(define (assign-helper instr reg-map)
  (match instr
   [`(,op (,typex ,x) (offset (,typey ,y) ,i))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       ;;
       [(and (equal? x^ #f) (equal? y^ #f))
        `((,op (,typex ,x)) (offset (,typey ,y) ,i))]
       ;;
       [(equal? x^ #f)
       	`(,op (,typex ,x) (offset ,y^ ,i))]
       [(equal? y^ #f) `(,op ,x^ (,typey ,y))]
       [else `(,op ,x^ (offset ,y^ ,i))]))]

   [`(,op (offset (,typex ,x) ,i) (,typey ,y))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `(,op (offset (,typex ,x) i) (,typey ,y))]
       [(equal? x^ #f) `(,op (offset (,typex ,x), i) ,y^)]
       [(equal? y^ #f) `(,op (offset ,x^ ,i) (,typey ,y))]
       [else `(,op (offset ,x^ ,i) ,y^)]))]

   [`(,op (offset (,typex ,x) ,i) (offset (,typey ,y) ,j))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `(,op (offset (,typex ,x) i) (offset (,typey ,y) ,i))]
       [(equal? x^ #f) `(,op (offset (,typex ,x), i) (offset ,y^ ,i) )]
       [(equal? y^ #f) `(,op (offset ,x^ ,i) (offset (,typey ,y) ,i))]
       [else `(,op (offset ,x^ ,i) (offset ,y^ ,i))]))]

   [`(,op (,typex ,x) (,typey ,y))
    (let ([x^ (hash-ref reg-map x #f)]
          [y^ (hash-ref reg-map y #f)])
      (cond
       [(and (equal? x^ #f) (equal? y^ #f))
        `(,op (,typex ,x) (,typey ,y))]
       [(equal? x^ #f) `(,op (,typex ,x) ,y^)]
       [(equal? y^ #f) `(,op ,x^ (,typey ,y))]
       [else `(,op ,x^ ,y^)]))]

   [`(negq (var ,x)) `(negq ,(hash-ref reg-map x))]

   [`(sete ,x) `(sete ,x)]

   [`(setl ,x) `(setl ,x)]

   [`(if (eq? ,t ,cnd) ,thn ,els)
    (let ([cnd^ (if (eq? (car cnd) 'var) (hash-ref reg-map (cadr cnd)) cnd)]
          [thn^ (assign-reg thn reg-map)]
          [els^ (assign-reg els reg-map)])
      `(if (eq? ,t ,cnd^) ,thn^ ,els^))]

   [`(callq ,x) `(callq ,x)]

   [`(indirect-callq (var ,x))
    `(indirect-callq ,(hash-ref reg-map x))]

   [`(leaq ,_ ,_) instr]
   ))



(define (color->reg color-hash)
  (hash-map
   color-hash
   (lambda (x y)
     (if (> y (register-num)) ;; this is where we choose number of registers
         (hash-set! color-hash x `(stack ,(- (* 8 (- y (register-num))))))
         (hash-set! color-hash x `(reg ,(vector-ref general-registers y)))))))
