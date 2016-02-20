#lang racket
(require "../utilities.rkt")
(require "typecheck.rkt")
(require racket/pretty)
(provide flatten)

;;
;; Flatten
;;
;; flatten : R2 -> C2
;;
;; Takes a racket program in an AST and flattens it into a sequential one
;;


(define flatten^
 (lambda (e need-var)
  (match e
   [(? symbol?) (values e '())]

   [(? integer?) (values e '())]

   [(? boolean?) (values e '())]

   [`(let ([,x ,rhs]) ,body)
    (let-values ([(rhs_ex rhs_stmts) (flatten^ rhs #f)]
                 [(body_ex body_stmts) (flatten^ body need-var)])
      (values body_ex (append rhs_stmts `((assign ,x ,rhs_ex)) body_stmts)))]

   [`(read) (if need-var
              (let ([tmp (gensym "read.")])
                (values tmp `((assign ,tmp (read)))))
              (values '(read) `()))]

   [`(- ,es) (if need-var
                 (let ([tmp (gensym "neg.")])
                   (let-values ([(ex stmts) (flatten^ es need-var)])
                     (values tmp (append stmts `((assign ,tmp (- ,ex)))))))
                 (let-values ([(ex stmts) (flatten^ es need-var)])
                   (values `(- ,ex) stmts)))]

   [`(+ ,e1 ,e2)
    (if need-var
        (let ([tmp (gensym "plus.")])
          (let-values ([(ex1 stmts1) (flatten^ e1 need-var)]
                       [(ex2 stmts2) (flatten^ e2 need-var)])
            (values tmp (append stmts1 stmts2 `((assign ,tmp (+ ,ex1 ,ex2)))))))
        (let-values ([(ex1 stmts1) (flatten^ e1 #t)]
                     [(ex2 stmts2) (flatten^ e2 #t)])
          (values `(+ ,ex1 ,ex2) (append stmts1 stmts2))))]

   [`(if ,cnd ,thn ,els)
    (let-values ([(cnd_ex cnd_stmts) (flatten^ cnd need-var)]
                 [(thn_ex thn_stmts) (flatten^ thn need-var)]
                 [(els_ex els_stmts) (flatten^ els need-var)])
      (let ([tmp (gensym "if.")])
        (values tmp
                (append cnd_stmts
                        `((if (eq? #t ,cnd_ex)
                              ,(append thn_stmts `((assign ,tmp ,thn_ex)))
                              ,(append els_stmts `((assign ,tmp ,els_ex))))
                          )))))]

   [`(or ,e1 ,e2) (flatten^ `(if ,e1 #t e2) need-var)]

   [`(and ,e1 ,e2) (flatten^ `(if ,e1 ,e2 #f) need-var)]

   [`(eq? ,e1 ,e2)
    (if need-var
        (let ([tmp (gensym "eq.")])
          (let-values ([(e1_ex e1_stmts) (flatten^ e1 need-var)]
                       [(e2_ex e2_stmts) (flatten^ e2 need-var)])
            (values tmp (append e1_stmts
                                e2_stmts
                                `((assign ,tmp (eq? ,e1_ex ,e2_ex)))))))
        (let-values ([(e1_ex e1_stmts) (flatten^ e1 need-var)]
                     [(e2_ex e2_stmts) (flatten^ e2 need-var)])
          (values `(eq? ,e1_ex ,e2_ex) (append e1_stmts e2_stmts))))]

   [`(not ,es) (if need-var
                   (let ([tmp (gensym "not.")])
                     (let-values ([(es_ex es_stmts) (flatten^ es need-var)])
                       (values tmp (append es_stmts
                                           `((assign ,tmp (not ,es_ex)))))))
                   (let-values ([(es_ex es_stmts) (flatten^ es need-var)])
                     (values `(not ,es_ex) es_stmts)))]

   [`(vector ,args ...)
    (if need-var
        (let ([args^
               (foldr (lambda (x acc)
                    (let-values ([(ex st)
                                  (flatten^ x need-var)])
                        (cons
                         (cons ex (car acc))
                         (cons st (cadr acc)))))
                  (list '() '())
                  args)]
              [tmp (gensym "vec.")])
          (values tmp (append (cadr args^)
                              `((assign ,tmp (vector ,@(car args^)))))))
        (let ([args^
               (foldr (lambda (x acc)
                        (let-values ([(ex st)
                                      (flatten^ x need-var)])
                          (cons
                           (cons ex (car acc))
                           (cons st (cadr acc)))))
                      (list '() '())
                      args)])
          (values `(vector ,@(car args^)) (cadr args^))))]

   [`(vector-ref ,arg ,i)
    (if need-var
        (let ([tmp (gensym "vref.")])
          (let-values ([(ex stmts) (flatten^ arg need-var)])
            (values tmp (append stmts `((assign ,tmp (vector-ref ,ex ,i)))))))
        (let-values ([(ex stmts) (flatten^ arg need-var)])
          (values `(vector-ref ,ex ,i) stmts)))]

   [`(vector-set! ,arg ,i ,narg)
    (if need-var
        (let ([tmp (gensym "vset.")])
          (let-values ([(exA stmtsA) (flatten^ arg need-var)]
                       [(exN stmtsN) (flatten^ narg need-var)])
            (values tmp (append `((assign ,tmp `(vector-set! ,exA ,i ,exN)))
                                stmtsA
                                stmtsN)))
)
        (let-values ([(exA stmtsA) (flatten^ arg need-var)]
                     [(exN stmtsN) (flatten^ narg need-var)])
          (values `(vector-set! ,exA ,i ,exN) (append stmtsA stmtsN))))]

   )))

(define (flatten p)
  (match p
   [`(program ,expr)
    (let-values ([(ex rhs) (flatten^ expr #t)])
      (let ([vars (remove-duplicates (unique-vars rhs '()))])
        `(program ,vars
                  (type ,(typecheck p))
                  ,@(append rhs `((return ,ex))))))]))

(define unique-vars-helper
  (lambda (instr)
    (match instr
     [`(assign ,e1 ,e2) `(,e1)]
     [`(if ,cnd ,thn ,els) (append (unique-vars thn '())
                                   (unique-vars els '()))]
     [else '()])))

(define unique-vars
  (lambda (instrs ans)
    (if (null? instrs)
        ans
        (unique-vars (cdr instrs)
                     (append ans
                             (unique-vars-helper (car instrs)))))))
