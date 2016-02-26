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

(define (print-x86 e)
  (match e
   [`(program (,v ,x) ,t ,es ...)
    (let ([size (number->string (* 8 (length v)))])
      (let ([head (string-append "\t.globl main\nmain:\n")]
            [init
             (string-append
              "\tpushq\t%rbp\n\tmovq\t%rsp,\t%rbp\n"
              (if (eq? "0" size)
                  "" (string-append "\tsubq\t$" size ",\t%rsp\n"))
              (foldl string-append ""
                     (map (lambda (r)
                            (string-append
                             "\tpushq\t"
                             (string-append "%" (symbol->string r))
                             "\n")) (set->list caller-save))))]
            [shutdown
             (string-append
              "\tmovq\t%rax,\t%rdi\n\tcallq\tprint_int\n\tmovq\t$0,\t%rax\n"
              (foldl string-append ""
                     (map (lambda (r)
                            (string-append
                             "\tpopq\t"
                             (string-append "%" (symbol->string r))
                             "\n")) (set->list caller-save)))
              (if (eq? "0" size)
                  "" (string-append "\taddq\t$" size ",\t%rsp\n"))
              "\tpopq\t%rbp\n\tretq\n")]
            [prog (foldr string-append "" (map print-x86^ es))])
        (string-append head init prog shutdown)))]))

(define (print-x86^ e)
  (match e
   [`(offset ,loc ,i)
    (string-append (number->string i) "(" (print-x86^ loc) ")")]
   [`(,op ,a ,b) #:when (member op '(movq addq cmpq movzbq xorq))
    (string-append
     "\t" (symbol->string op) "\t" (print-x86^ a) ",\t" (print-x86^ b) "\n")]
   [`(,op ,q) #:when (member op '(negq sete setl))
    (string-append "\t" (symbol->string op) "\t" (print-x86^ q) "\n")]
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
    (string-append "\tpushq\t" (print-x86^ v))]
   [`(popq ,v)
    (string-append "\tpopq\t" (print-x86^ v))]))
