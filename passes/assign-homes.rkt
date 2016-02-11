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

#|
(define p '(program
(let ([a 1])
  (let ([b 1])
    (let ([c 1])
      (let ([d 1])
        (let ([e 1])
          (let ([f 1])
            (let ([g 1])
              (let ([h 1])
                (let ([i 1])
                  (let ([j 1])
                    (let ([k 1])
                      (let ([l 1])
                        (let ([m 1])
                          (let ([n 1])
                            (let ([o 1])
                              (let ([p 1])
                                (let ([q (read)])
                                  (let ([r 1])
                                    (let ([s 1])
                                      (let ([t 1])
                                        (let ([u 1])
                                          (+ a
                                          (+ b
                                          (+ c
                                          (+ d
                                          (+ e
                                          (+ f
                                          (+ g
                                          (+ h
                                          (+ i
                                          (+ j
                                          (+ k
                                          (+ l
                                          (+ m
                                          (+ n
                                          (+ o
                                          (+ p
                                          (+ q
                                          (+ r
                                          (+ s
                                          (+ t
                                          (+ u 21))))))))))))))))))))))))))))))))))))))))))))


(define p `(program
(let ([v 1])
  (let([w 46])
    (let ([x (+ v 7)])
      (let ([y (+ 4 x)])
        (let ([z (+ x w)])
          (+ z (- y)))))))))



`(program (v w x y z)
            (movq (int 1) (var v))       ;; v
            (movq (int 46) (var w))      ;; v,w
            (movq (var v) (var x))       ;; w,x
            (addq (int 7) (var x))       ;; w,x
            (movq (var x) (var y))       ;; w,x,y
            (addq (int 4) (var y))       ;; w,x,y
            (movq (var x) (var z))       ;; w,y,z
            (addq (var w) (var z))       ;; y,z
            (movq (var z) (reg rax))     ;; y,rax
            (subq (var y) (reg rax))))



(let ([inter-graph (build-interference (uncover-live (select-instructions (flatten p))))])
  (let ([allocate (allocate-registers inter-graph)])
    (print-x86 (assign-homes allocate))
    ))


(let ([inter-graph (build-interference (uncover-live (select-instructions (flatten p))))])
  (let ([allocate (allocate-registers inter-graph)])
    (match allocate
           [`(program (,vars ,reg-map) ,instr ...)
             (color->reg reg-map) (display reg-map)])))



(define max-reg
  (lambda (reg-map vars mreg-var)
    (cond
      [(null? vars) mreg-var]
      [(> (hash-ref reg-map (car vars)) (hash-ref reg-map mreg-var))
       (max-reg reg-map (cdr vars) (car vars))]
      [else (max-reg reg-map (cdr vars) mreg-var)])))
|#
