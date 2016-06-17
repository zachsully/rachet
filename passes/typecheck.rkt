#lang racket
(require "../utilities.rkt")
(provide typecheck)

;;
;; Typechecker
;;
;; typecheck : R3 -> Type
;;
;; Returns the type of the program or fails
;;

(define (typecheck^ env e)
 (match e
  [(? fixnum?) `(has-type ,e Integer)]

  [(? boolean?) `(has-type ,e Boolean)]

  [(? symbol?) `(has-type ,e ,(lookup e env))]

  [`(let ([,lhs ,rhs]) ,body)
   (match (typecheck^ env rhs)
    [`(has-type ,rhs ,rhs-t)
     (let* ([env^ (cons (cons lhs rhs-t) env)]
	    [ht   (typecheck^ env^ body)])
       `(has-type (let ([,lhs (has-type ,rhs ,rhs-t)])
		    ,ht)
		  ,(caddr ht)))])]

  [`(- ,e)
   (match (typecheck^ env e)
    [`(has-type ,e^ Integer) `(has-type (- (has-type ,e^ Integer)) Integer)]
    [else (error 'typecheck^ "'-' expects a Integer" e)])]

  [`(+ ,e1 ,e2)
   (let ([ht1 (typecheck^ env e1)]
         [ht2 (typecheck^ env e2)])
    (cond
    [(not (equal? 'Integer (caddr ht1)))
     (error 'typecheck^ "'+' expects a Integer")]
    [(not (equal? 'Integer (caddr ht2)))
     (error 'typecheck^ "'+' expects a Integer")]
    [else `(has-type (+ ,ht1 ,ht2) Integer)]))]

  [`(read) `(has-type ,e Integer)]

  [`(not ,e)
   (let ([ht (typecheck^ env e)])
     (match ht
      [`(has-type ,e^ Boolean) `(has-type (not ,ht) Boolean)]
      [else (error 'typecheck^ "'not' expects a Boolean")]))]

  [`(,op ,e1 ,e2) #:when (member op '(and or))
   (let ([ht1 (typecheck^ env e1)]
         [ht2 (typecheck^ env e2)])
     (cond
      [(not (equal? 'Boolean (caddr ht1)))
       (error 'typecheck^ "'and' expects a Boolean" e1)]
      [(not (equal? 'Boolean (caddr ht2)))
       (error 'typecheck^ "'and' expects a Boolean" e2)]
      [else `(has-type (,op ,ht1 ,ht2) Boolean)]))]

  [`(eq? ,e1 ,e2)
   (let ([ht1 (typecheck^ env e1)]
         [ht2 (typecheck^ env e2)])
     (cond
      [(eq? (caddr ht1) (caddr ht2))
       `(has-type (eq? ,ht1 ,ht2) Boolean)]
      [else (error 'typecheck^
                   (string-append "'eq?' expects a " (symbol->string ht2))
                   ht1)]))]

  [`(if ,cnd ,thn ,els)
   (let ([ht-cnd (typecheck^ env cnd)])
     (cond
      [(not (equal? 'Boolean (caddr ht-cnd)))
       (error 'typecheck^ "'if' expects a Boolean" cnd)]
      [else (let ([ht-thn (typecheck^ env thn)]
		  [ht-els (typecheck^ env els)])
	      (if (equal? (caddr ht-thn) (caddr ht-els))
		  `(has-type (if ,ht-cnd ,ht-thn ,ht-els) ,(caddr ht-thn))
		  (error 'typecheck^
			 "'if' expects branches to be same type")))]))]

  [`(vector ,args ...)
   (if (empty? args)
       (error 'typecheck^
              "'vector' expects at least one argument")
       (let* ([hts (map (lambda (a) (typecheck^ env a)) args)]
	      [ts  (map caddr hts)])
         `(has-type (vector ,@hts) (Vector ,@ts))))]

  [`(vector-ref ,arg ,i)
   (cond
    [(not (integer? i))
     (error 'typecheck^
            "'vector-ref' expects an integer for the second arg")]
    [else (let ([ht (typecheck^ env arg)])
            (match (caddr ht)
             [`(Vector ,args ...)
              (if (< (length args) i)
                  (error 'typecheck^
                         "'vector-ref' index does not exist in vector")
                  `(has-type (vector-ref ,ht ,i) ,(car (drop args i))))]
             [`,_
              (error 'typecheck^
                     "'vector-ref' expects a vector for the first arg")]))])]
  [`(vector-set! ,arg ,i ,narg)
   (cond
    [(not (integer? i))
     (error 'typecheck^
            "'vector-set!' expects an integer for the second arg")]
    [else
     (let ([ht (typecheck^ env arg)]
	   [n-ht (typecheck^ env narg)])
       (match (caddr ht)
        [`(Vector ,args ...)
	 (cond
	  [(< (length args) i)
	   (error 'typecheck^
		  "'vector-set!' index does not exist in vector")]
	  [(not (equal? (car (drop args i)) (caddr n-ht)))
	   (error 'typecheck^
		  "'vector-set!' attempting to change type of vector-field")]
	  [else `(has-type (vector-set! ,ht ,i ,n-ht) _)])]
	[`,_
	 (error 'typecheck^
		"'vector-set!' expects a vector for the first arg")]))])]

  ;; NOTE: define only returns has-types for its expressions
  [`(define (,name (,vars : ,ts) ...) : ,t ,ed)
   (let* ([env^ (append (map cons vars ts) env)]
	  [ht   (typecheck^ env^ ed)])
     (cond
      [(not (equal? (caddr ht) t))
       (error 'typecheck^
      	      (string-append
      	       "return type does not match definition in "
      	       (symbol->string name)))]
      [else `(define (,name ,@(map (lambda (v t) `(,v : ,t)) vars ts))
	       : ,t (has-type ,(cadr ht) ,t))]))]

  [`(lambda: ([,vs : ,ts] ...) : ,tt ,exp)
   (let* ([env^  (append (map cons vs ts) env)]
	  [exp-ht (typecheck^ env^ exp)])
     (cond
      [(equal? tt (caddr exp-ht))
       `(has-type (lambda: (,@(map (lambda (v t) `(,v : ,t)) vs ts))
			   : ,tt ,exp-ht) (,@ts -> ,tt))]
      [else (error 'typecheck^ "mismatch in return type")]))]

  [`(,func ,args ...)
   (let* ([f-ht    (typecheck^ env func)]
	  [arg-hts (map (lambda (a) (typecheck^ env a)) args)])
     (cond
      ;; check arity
      [(not (eq? (length args)
		 (- (length (caddr f-ht)) 2)))
       (error 'typecheck^
		(string-append (symbol->string func)
			       " expects "
			       (number->string (- (length (caddr f-ht)) 1))
			       " args; given "
			       (number->string (length args))))]

      ;; check correct types
      [(not (foldr (lambda (left right acc)
		     (and acc (or (equal? left right)
				  (not (monomorphic? right))
				  )))
		   #t
		   (map caddr arg-hts)
		   (reverse (cddr (reverse (caddr f-ht))))))
       (error 'typecheck^
	      (string-append (symbol->string func)
			     ": argument types don't match"))]
      [else
       (define arg-ts (map caddr arg-hts))
       (define farg-ts (reverse (cddr (reverse (caddr f-ht)))))
       (define unified-args (map unify
				 arg-ts
				 farg-ts))
       (define type-parameters (map cons farg-ts unified-args))
       (let* ([subs-t (map cons
			   (reverse (cddr (reverse (caddr f-ht))))
			   (map caddr arg-hts))]
	      [return-t (car (reverse (caddr f-ht)))]
	      [f-ht^ `(has-type ,(cadr f-ht) ,(parameterize (caddr f-ht)
							    type-parameters))])
	 `(has-type (,f-ht^ ,@arg-hts) ,(lookup return-t subs-t return-t)))]))]
  ))


;; takes a definition and creates and association for the func name and its type
(define (define-type d)
  (match d
   [`(define (,name (,vars : ,ts) ...) : ,t ,_)
    (cons name `(,@ts -> ,t))]))

(define (typecheck e)
  (match e
   [`(program ,defs ... ,e)
    (let* ([defs-env (map define-type defs)]
	   [defs^     (map (lambda (d)
	   		    (typecheck^ defs-env d)) defs)]
	   )
      `(program ,@defs^
		,(typecheck^ defs-env e)))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               UNIFICATION                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (unify t1 t2)
  (cond
   [(and (monomorphic? t1) (monomorphic? t2))
    (if (equal? t1 t2)
	t1
	(error 'unify "Cannot unify type ~a with ~a" t1 t2))]

   [(and (vector? t1) (vector? t2))
    `(Vector ,@(map unify (vec-types t1) (vec-types t2)))]

   [(and (func? t1) (func? t2))
    (define unified-args (map unify (arg-types t1) (arg-types t2)))
    (define uni-assoc (map cons (arg-types t1) unified-args))
    (define unified-args^ (map (lambda (x)
				 (lookup x uni-assoc x)) unified-args))
    (define urt (unify (return-type t1) (return-type t2)))
    `(,@unified-args^
      ->
      ,(lookup urt uni-assoc urt))]

   [(monomorphic? t2) t2]
   [(monomorphic? t1) t1]

   [(and (symbol? t1) (symbol? t2))
    (if (equal? t1 t2)
	t1
	(error 'unify "Cannot unify type ~a with ~a" t1 t2))]

   [(and (or (vector? t1) (func? t1)) (symbol? t2)) t1]
   [(and (or (vector? t2) (func? t2)) (symbol? t1)) t2]
   [else (error 'unify "Cannot unify type ~a with ~a" t1 t2)]))

(define (vector? t)
  (match t
   [`(Vector ,_ ...) #t]
   [else #f]))

(define (vec-types t)
  (match t
   [`(Vector ,es ...) es]
   [else #f]))

(define (func? t)
  (match t
   [`(,_ ... -> ,_) #t]
   [else #f]))

(define (arg-types t)
  (match t
   [`(,args ... -> ,_) args]
   [else (error "not function")]))

(define (return-type t)
  (match t
   [`(,_ ... -> ,r) r]
   [else #f]))

(define monomorphic (set 'Boolean 'Integer 'Void))
(define (monomorphic? t) (set-member? monomorphic t))

;; takes a function type and a type environment and returns the parameterized
;; function
(define (parameterize expr env)
  ;; (print expr) (print env) (newline) (newline)
  (match expr
   [(? symbol?)      (lookup expr env expr)]
   [`(,a)           `(,(parameterize a env))]
   [`(,a ,rest ...) `(,(parameterize a env)
		      ,@(map (lambda (q) (parameterize q env)) rest))]
   [`(-> ,a)        `(-> ,(parameterize a env))]
   [`(Vector ,as ...) `(Vector ,@(map (lambda (q) (parameterize q env)) as))]
   [else (error "What happened?")]))






;; (define (unify-assoc t1 t2)
;;   (cond
;;    [(and (monomorphic? t1) (monomorphic? t2))
;;     (if (equal? t1 t2)
;; 	'()
;; 	(error 'unify-assoc "Cannot unify ~a with ~a" t1 t2))]
;;    [(and (monomorphic? t1) (symbol? t2)) `((t1 . t2))]))

;; (define (paramterize t env)
;;   (match t
;;    [(? symbol?) (lookup t env t)]))

;; ;; (let ([a 'a]
;; ;;       [b 'Int])
;; ;;   (print a) (print b) (newline)
;; ;;   (paramterize a (unify-assoc a b))
;; ;;   )
