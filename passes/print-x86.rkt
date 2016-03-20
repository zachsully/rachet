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
   [`(program ,extra ,t (defines ,defs ...) ,instrs ...)
    (string-append
     (if (null? defs) "" (string-append* (map print-define defs)))
     (print-main (number->string (* 8 (length (car extra)))) instrs))]))

(define (print-main n instrs)
  (let* ([head     (string-append "\t.globl main\nmain:\n")]
	 [init     (string-append
		    push-context
		    (if (eq? "0" n) ""
			(string-append "\tsubq\t$" n ",\t%rsp\n")))]
	 [shutdown (string-append
		    "\tmovq\t%rax,\t%rdi\n\tcallq\tprint_int\n"
		    (if (eq? "0" n) ""
			(string-append "\taddq\t$" n ",\t%rsp\n"))
		    "\tmovq\t$0,\t%rax\n" ;; clear rax
		    pop-context)]
	 [prog (foldr string-append "" (map print-instr instrs))])
    (string-append head init prog shutdown)))

(define (print-define def)
  (match def
   [`(define (,f) ,n (,vars ,max-stack) ,locals ,instrs ...)
    (let* ([head     (string-append "\t.globl "
				    (symbol->string f)
				    "\n"
				    (symbol->string f)
				    ":\n")]
	   [init     (string-append
		      push-context
		      (if (zero? n) ""
			  (string-append "\tsubq\t$"
					 (number->string (* 8 n))
					 ",\t%rsp\n")))]
	   [shutdown (string-append
		      (if (zero? n) ""
			  (string-append "\taddq\t$"
					 (number->string (* 8 n))
					 ",\t%rsp\n"))
		      pop-context)]
	   [prog (foldr string-append "" (map print-instr instrs))])
      (string-append head init prog shutdown "\n"))]))

;; saves caller-save register and moves base pointer
(define push-context
  (string-append
   "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n"
   (foldl string-append ""
	  (map (lambda (r)
		 (string-append
		  "\tpushq\t"
		  (string-append "%"
				 (symbol->string r))
		  "\n"))
	       (set->list caller-save)))))

;; returns from context returning caller-save regs and base pointer
(define pop-context
  (string-append
   (foldl string-append ""
	  (map (lambda (r)
		 (string-append
		  "\tpopq\t"
		  (string-append "%" (symbol->string r))
		  "\n"))
	       (set->list caller-save)))
   "\tpopq\t%rbp\n\tretq\n"))

(define (print-instr instr)
  (match instr
   [`(offset ,loc ,i)
    (string-append (number->string i) "(" (print-instr loc) ")")]
   [`(,op ,a ,b) #:when (member op '(movq addq cmpq movzbq xorq leaq))
    (string-append
     "\t" (symbol->string op) "\t" (print-instr a) ",\t" (print-instr b) "\n")]
   [`(,op ,q) #:when (member op '(negq sete setl))
    (string-append "\t" (symbol->string op) "\t" (print-instr q) "\n")]
   [`(callq ,func)
    (string-append "\tcallq\t" (symbol->string func) "\n")]
   [`(,op ,lbl) #:when(member op '(je jmp))
     (string-append "\t" (symbol->string op) "\t" (symbol->string lbl) "\n")]
   [`(label ,lbl)
     (string-append (symbol->string lbl) ":\n")]
   [`(int ,i)
    (string-append "$" (number->string i))]
   [`(stack ,loc)
    (string-append (number->string loc) "(%rbp)")]
   [`(,type ,r) #:when (member type '(reg byte-reg))
    (string-append "%" (symbol->string r))]
   [`(global-value ,v)
    (string-append (symbol->string v) "(%rip)")]
   [`(pushq ,v)
    (string-append "\tpushq\t" (print-instr v) "\n")]
   [`(popq ,v)
    (string-append "\tpopq\t" (print-instr v) "\n")]
   [`(function-ref ,label)
    (string-append (symbol->string label) "(%rip)")]
   [`(indirect-callq ,q)
    (string-append "\tcallq\t*" (print-instr q) "\n")]
   [`(stack-arg ,i)
    (string-append (number->string i) "(%rsp)")]))
