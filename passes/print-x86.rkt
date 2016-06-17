#lang racket
(require "../utilities.rkt")
(provide print-x86)

;;
;; Print-x86
;;
;; print-x86 : x86' -> x86
;;
;; Takes our most reduced AST of x86' and outputs a string of x86
;;

(define (print-x86 p)
  (match p
   [`(program ,extra (defines ,defs ...) ,instrs ...)
    (string-append
     (if (null? defs) "" (string-append* (map print-define defs)))
     (print-main (number->string (* 8 (length (car extra)))) instrs))]))


(define (symbol->string^ sym)
  (string-replace
   (string-replace
    (symbol->string sym)
    "?" "")
   "-" ""))

(define (print-main n instrs)
  (let* ([save-regs (set->list callee-save)]
	 [head     (string-append "\t.globl main\nmain:\n")]
	 [init     (string-append
		    "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n"
		    (push-regs save-regs)
		    (if (eq? "0" n) ""
			(string-append "\tsubq\t$" n ",\t%rsp\n")))]
	 [shutdown (string-append
		    "\tmovq\t%rax,\t%rdi\n\tcallq\tprint_int\n"
		    (if (eq? "0" n) ""
			(string-append "\taddq\t$" n ",\t%rsp\n"))
		    "\tmovq\t$0,\t%rax\n" ;; clear rax
		    (pop-regs save-regs)
		    "\tpopq\t%rbp\n\tretq\n")]
	 [prog (foldr string-append "" (map
					  (lambda (l)
					    (print-instr l #t)) instrs))])
    (string-append head init prog shutdown)))

(define (print-define def)
  (match def
   [`(define (,f) ,n (,vars ,max-stack) ,instrs ...)
    (let* ([stack-space (+ max-stack n 1)]
	   [save-regs (set->list callee-save)]
	   [head     (string-append "\t.globl "
				    (symbol->string^ f)
				    "\n"
				    (symbol->string^ f)
				    ":\n")]
	   [init     (string-append
		      "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n"
		      (if (zero? stack-space) ""
			  (string-append "\tsubq\t$"
					 (number->string (* 8 stack-space))
					 ",\t%rsp\n"))
		      (push-regs save-regs))]
	   [shutdown (string-append
		      (pop-regs save-regs)
		      (if (zero? stack-space) ""
			  (string-append "\taddq\t$"
					 (number->string (* 8 stack-space))
					 ",\t%rsp\n"))
		      "\tpopq\t%rbp\n\tretq\n")]
	   [prog (foldr string-append "" (map
					  (lambda (l)
					    (print-instr l #f)) instrs))])
      (string-append head init prog shutdown "\n"))]))

;; saves caller-save register and moves base pointer
(define (push-regs rs)
  (string-append
   (foldl string-append ""
	  (map (lambda (r)
		 (string-append
		  "\tpushq\t"
		  (string-append "%"
				 (symbol->string^ r))
		  "\n"))
	       rs))))

;; returns from caller-save returning caller-save regs and base pointer
(define (pop-regs rs)
  (string-append
   (foldl string-append ""
	  (map (lambda (r)
		 (string-append
		  "\tpopq\t"
		  (string-append "%" (symbol->string^ r))
		  "\n"))
	       (reverse rs)))))

(define (print-instr instr k)
  (match instr
   [`(offset ,loc ,i)
    (string-append (number->string i) "(" (print-instr loc k) ")")]

   [`(,op ,a ,b) #:when (member op '(movq addq cmpq movzbq xorq leaq))
    (string-append
     "\t" (symbol->string^ op)
     "\t" (print-instr a k)
     ",\t" (print-instr b k) "\n")]

   [`(,op ,q) #:when (member op '(negq sete setl))
    (string-append
     "\t" (symbol->string^ op)
     "\t" (print-instr q k) "\n")]

   [`(callq ,func)
    (string-append "\tcallq\t" (symbol->string^ func) "\n")]

   [`(,op ,lbl) #:when(member op '(je jmp))
    (string-append
     "\t" (symbol->string^ op)
     "\t" (symbol->string^ lbl) "\n")]

   [`(label ,lbl)
    (string-append (symbol->string^ lbl) ":\n")]

   [`(int ,i)
    (string-append "$" (number->string i))]

   [`(stack ,loc)
    (string-append (number->string loc) "(%rbp)")]

   [`(,type ,r) #:when (member type '(reg byte-reg))
    (string-append "%" (symbol->string^ r))]

   [`(global-value ,v)
    (string-append (symbol->string^ v) "(%rip)")]

   [`(pushq ,v)
    (string-append "\tpushq\t" (print-instr v k) "\n")]

   [`(popq ,v)
    (string-append "\tpopq\t" (print-instr v k) "\n")]

   [`(function-ref ,label)
    (string-append (symbol->string^ label) "(%rip)")]

   [`(indirect-callq ,q)
    (string-append "\tcallq\t*" (print-instr q k) "\n")]

   [`(stack-arg ,i)
    (if k
	(string-append (number->string i) "(%rsp)")
	(string-append (number->string (+ i 16)) "(%rbp)"))]))
