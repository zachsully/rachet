#lang racket
(require "utilities.rkt")
(require "interp.rkt")

(provide r1-passes)

(define (uniquify^ alist)
  (lambda (e)
    (match e
      [(? symbol?) (lookup e alist)]
      [(? integer?) e]
      [`(let ([,x ,e^]) ,body)
        (let ([e^^ ((uniquify^ alist) e^)])
          (let ([newsym (gensym)])
            `(let ([,newsym ,e^^]) ,((uniquify^ `((,x . ,newsym) . ,alist)) body))))]
      [`(,op ,es ...)
       `(,op ,@(map (uniquify^ alist) es))]
      [`(program ,e)
       `(program ,((uniquify^ alist) e))]
      )))

(define uniquify (uniquify^ '()))

(define (flatten^ need-arg)
  (lambda (e)
    (match e
      [(? integer?) (values e '())]
      [(? symbol?)  (values e '())]
      [`(let ([,x ,e]) ,body)
        (cond
          [need-arg
            (let-values ([(expr ass) ((flatten^ #t) e)])
              (let-values ([(expr^ ass^) ((flatten^ #f) body)])
                (values expr^
                        (append ass ass^ `((assign ,x ,expr))))))]
          [else
           (let-values ([(expr ass) ((flatten^ need-arg) e)])
              (values expr ass))])]
      [`(program ,e)
        (let-values ([(expr ass) ((flatten^ need-arg) e)])
          `(program ,expr ,@(append ass `((return ,expr)))))]
      [`(,op ,es ...)
        (cond
          [need-arg
           (let ([temp (gensym)])
             (let-values ([(exprs asses) (map2 (flatten^ need-arg) es)])
               (values temp
                       (append asses
                               `((assign ,temp (,op ,@exprs)))))))]
          [else
            (let-values ([(exprs asses) (map2 (flatten^ need-arg) es)])
              (values `(,op ,@exprs)
                      asses))])]
      )))


(define flatten
  (lambda (e)
    (match e
      [(? symbol?) (values e '())]
      [(? integer?) (values e '())]
      [`(let ([,x ,rhs]) ,body)
       (let-values ([(rhs_ex rhs_stmts) (flatten rhs)]
                    [(body_ex body_stmts) (flatten body)])
         (values body_ex (append rhs_stmts `((assign ,x ,rhs_ex)) body_stmts)))]
      [`(program ,e) (let-values ([(ex rhs) (flatten e)])
                       (let ([vars (unique-vars rhs)])
                         `(program ,vars ,@(append rhs `((return ,ex))))))]
      [`(read) (let ([tmp (gensym)])
                 (values tmp `((assign ,tmp (read)))))]
      [`(- ,es) (let ([tmp (gensym)])
                  (let-values ([(ex stmts) (flatten es)])
                    (values tmp (append stmts `((assign ,tmp (- ,ex)))))))]
      [`(+ ,e1 ,e2) (let ([tmp (gensym)])
                      (let-values ([(ex1 stmts1) (flatten e1)]
                                   [(ex2 stmts2) (flatten e2)])
                         (values tmp (append stmts1 stmts2 `((assign ,tmp (+ ,ex1 ,ex2)))))))]
           )))

(define unique-vars
  (lambda (e)
    (cond
      [(null? e) '()]
      [else (match (car e)
              [`(assign ,e1 ,e2) (cons e1 (unique-vars (cdr e)))])])))


(define (selection-instruction^ e)
  (cond
   [(null? e) '()]
   [else
    (append
     (match (car e)
            [`(assign ,v (read)) `((callq read_int)
                                   (movq (reg rax) (var ,v)))]
            [`(assign ,v (- ,e1))
             (if (symbol? e1)
                 `((negq (var ,e1))
                   (movq (var ,e1) (var ,v)))

                 `((movq (int ,e1) (var ,v))
                   (negq (var ,v))))]
            [`(assign ,v (+ ,e1 ,e2))
             (cond
              [(and (symbol? e1)
                    (symbol? e2))
               `((addq (var ,e1) (var ,e2))
                 (movq (var ,e2) (var ,v)))]
              [(symbol? e1)
               `((movq (var ,e1) (var ,v))
                 (addq (int ,e2) (var ,v)))]
              [(symbol? e2)
               `((movq (var ,e2) (var ,v))
                 (addq (int ,e1) (var ,v)))]
              [else
               `((movq (int ,e1) (var ,v))
                 (addq (int ,e2) (var ,v)))])]
            [`(assign ,v ,x)
             `((movq (var ,x) (var ,v)))]
            [`(return ,v) `((movq (var ,v) (reg rax)))])
     (selection-instruction^ (cdr e)))]))

(define (selection-instruction e)
  (match e
    [`(program ,vs ,es ...)
     (let ([intrs (selection-instruction^ es)])
       `(program ,vs ,@intrs))]))

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
                              [`(,a ,b) v]))
                           var)))))
          es))))))

(define (print-x86 e)
  (match e
   [`(program ,v ,es ...)
     (let ([size (number->string (* 8 (length v)))])
       (let ([head (string-append "\t.globl main\nmain:\n")]
             [init (string-append
                    "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n\tsubq\t$"
                    size
                    ",\t%rsp\n")]
             [shutdown (string-append
                        "\taddq\t$"
                        size
                        ",\t%rsp\n\tpopq\t%rbp\n\tretq")]
             [prog (foldr string-append "" (map print-x86^ es))])
         (string-append head init prog shutdown)))]))

(define (print-x86^ e)
  (match e
	 [`(movq ,a ,b)
	  (string-append "\tmovq\t" (print-x86^ a) ",\t" (print-x86^ b) "\n")]
	 [`(addq ,a ,b)
	  (string-append "\taddq\t" (print-x86^ a) ",\t" (print-x86^ b) "\n")]
	 [`(negq ,q)
	  (string-append "\tnegq\t" (print-x86^ q) "\n")]
	 [`(callq read_int)
	  "\tcallq\tread_int\n"]
	 [`(int ,i)
	  (string-append "$" (number->string i))]
	 [`(stack ,loc)
	  (string-append (number->string loc) "(%rbp)")]
	 [`(reg ,r) "%rax"])) ;; this is dirty

(flatten `(program (+ 52 (- 10))))
(newline)
(selection-instruction (flatten `(program (+ 52 (- 10)))))
(newline)
(assign-homes (selection-instruction (flatten `(program (+ 52 (- 10))))))
;; (flatten `(program (let ([x 42]) (- 42))))
(newline)
(display
 (print-x86
  (assign-homes
   (selection-instruction
    (flatten `(program (+ 52 (- 10))))))))



(define (patch-instructions e) e)

(define r1-passes `(("uniquify",uniquify,interp-scheme)
                    ("flatten",flatten,interp-C)
                    ("select instructions",selection-instruction,interp-x86)
                    ("assign homes",assign-homes,interp-x86)
                    ;; ("patch instructions",patch-instructions,interp-x86)
                    ;; ("print-x86",print-x86, #f)
                    ))

;; (interp-tests "r1p-passes" r1-passes interp-scheme "r1" (range 1 1))
;; (display "tests passed!") (newline)

;; (display "Flatten Tests -----------------------------------")
;; (newline)
;; (flatten `(program (let ([x 41]) (+ x 1))))
;; (flatten `(program (let ([x 20]) (let ([y 22]) (+ x y)))))
;; (newline)
;; (flatten `(program (+ 1 2)))
;; (newline)
;; (flatten `(program
;;             (let ([x (+ (- 10) 11)])
;;               (+ x 41))))
;; (newline)
;; (newline)
;; (flatten `(program (let ([x 56])
;;                      (let ([y x])
;;                        y))))


;; (println `(Uniquify Tests -----------------------------------))
;; (uniquify `(program (let ([x 45]) (+ 3 x))))
;; (uniquify `(program (let ([x 45])
;;                             (let ([y 20]) (+ y x)))))
;; (uniquify `(program (let ([x (let ([y 30]) y)]) x)))
;; (uniquify `(program 1))
;; (uniquify `(program (let ([q (let ([z (let ([h 2]) 1)]) z)]) q)))
