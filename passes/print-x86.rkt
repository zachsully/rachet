#lang racket
(require "../utilities.rkt")
(provide print-x86)


(define (print-x86 e)
  (match e
   [`(program ,v ,es ...)
     (let ([size (number->string (* 8 (length v)))])
       (let ([head (string-append "\t.globl main\nmain:\n")]
             [init (string-append
                    "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n\tsubq\t$"
                    size
                    ",\t%rsp\n"
		    (foldl string-append ""
			   (map (lambda (r)
				  (string-append
				   "\tpushq\t"
				   (string-append "%" (symbol->string r))
				   "\n")) (set->list callee-save))))]
             [shutdown (string-append
			(if (equal? "0" size)
			   ""
			   (string-append
			    "\taddq\t$"
			    size
			    ",\t%rsp\n"))
			"\tmovq\t%rax,\t%rdi\n\tcallq\tprint_int\n"
			(foldl string-append ""
			   (map (lambda (r)
				  (string-append
				   "\tpopq\t"
				   (string-append "%" (symbol->string r))
				   "\n")) (set->list callee-save)))
			"\tpopq\t%rbp\n\tretq\n")]
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
	 [`(callq read_int) "\tcallq\tread_int\n"]
	 [`(int ,i)
	  (string-append "$" (number->string i))]
	 [`(stack ,loc)
	  (string-append (number->string loc) "(%rbp)")]
	 [`(reg ,r) (string-append "%" (symbol->string r))])) ;; this is dirty
