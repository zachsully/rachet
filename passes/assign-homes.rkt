#lang racket
;; (require "flatten.rkt")
;; (require "select-instructions.rkt")
;; (require "uncover-live.rkt") ;; for debug
;; (require "build-interference.rkt") ;; for debug
;; (require "allocate-registers.rkt") ;; for debug
;; (require "print-x86.rkt")
(require "../utilities.rkt")
(provide assign-homes)



(define assign-homes
  (lambda (e)
    (match e
           [`(program (,vars ,reg-map) ,instrs ...)
            (begin
              (color->reg reg-map)
             `(program (,vars ,reg-map) ,@(assign-reg instrs reg-map '())))])))


(define assign-reg
  (lambda (instrs reg-map ans)
    (if (null? instrs)
      ans
      (assign-reg (cdr instrs) reg-map (append ans (assign-helper (car instrs) reg-map))))))

(define assign-helper
  (lambda (instr reg-map)
    (match instr
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
           [`(if (eq? ,t ,cnd) ,thn ,els)
             (let ([cnd^ (if (eq? (car cnd) 'var) (hash-ref reg-map (cadr cnd)) cnd)]
                   [thn^ (assign-reg thn reg-map '())]
                   [els^ (assign-reg els reg-map '())])
               `((if (eq? ,t ,cnd^) ,thn^ ,els^)))]
           [`(callq ,x) `((callq ,x))])))



(define color->reg
  (lambda (color-hash)
    (hash-map color-hash (lambda (x y)
                            (if (> y 12)
                              (hash-set! color-hash x `(stack ,(- (* 8 (- y 12)))))
                (hash-set! color-hash x `(reg ,(vector-ref general-registers y))))))))
