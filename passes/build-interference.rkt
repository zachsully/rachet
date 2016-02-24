#lang racket
(require "../utilities.rkt")
(provide build-interference)

(define build-interference
  (lambda (e)
    (match e
      [`(program (,vs ,uncover) ,t ,instrs ...)
       (let ([graph (make-graph vs)])
            (build-graph graph uncover)
         `(program (,vs ,graph) ,t ,@instrs))])))

(define build-graph
  (lambda (graph uncover)
    (for ([line uncover])
      (let ([instr (first line)]
            [after-set (last line)])
        (match instr
          [`(,op (,_ ,src) (,_ ,dst)) #:when (member op '(movq movzbq))
	   (set-map (set-subtract after-set (set dst))
		      (lambda (live-after)
			(add-edge graph dst live-after)))]

	  ;; [`(movq (offset (,_ ,src-root) ,i) (,_ ,dst))
	  ;;  (set-map (set-subtract after-set (set src-root dst))
          ;;           (lambda (live-after)
          ;;             (add-edge graph dst live-after)))]

	  ;; [`(movq (,_ ,src) (offset (,_ ,dst-root) ,i))
	  ;;  (set-map (set-subtract after-set (set src dst-root))
          ;;           (lambda (live-after)
          ;;             (add-edge graph dst-root live-after)))]

	  ;; [`(movq (offset (,_ ,src-root) ,i) (offset (,_ ,dst-root) ,i))
	  ;;  (set-map (set-subtract after-set (set src-root dst-root))
          ;;           (lambda (live-after)
          ;;             (add-edge graph dst-root live-after)))]

          [`(,op (,_ ,src) (,_ ,dst)) #:when (member op '(addq subq xorq))
           (set-map (set-subtract after-set (set dst))
                    (lambda (live-after)
                      (add-edge graph dst live-after)))]

          [`(,op (,_ ,src) (,_ ,dst))
           #:when (member op '(cmpq))
           (void)]

          [`(,op (,_ ,dst))
           #:when (member op '(negq sete setl))
           (void)]
          [`(if (eq? (int 1) ,cnd) ,thn ,els)
           (begin
             (build-graph graph thn)
             (build-graph graph els))]
	  [`(if (eq? (int 0) ,cnd) ,thn ,els)
           (begin
             (build-graph graph thn)
             (build-graph graph els))]
          [`(callq ,label)
           (set-map after-set
                    (lambda (live-after)
                      (set-map caller-save
                               (lambda (call-save)
                                 (add-edge graph call-save live-after)))))]
          )))))

;; (pretty-print
;; (build-interference
;;  `(program ((eq7719 if7720)
;;   (((cmpq (int 0) (int 0)) ,(set 'rax) ,(set 'rax))
;;    ((sete (byte-reg al)) ,(set 'rax) ,(set 'rax))
;;    ((movzbq (byte-reg al) (var eq7719)) ,(set 'rax) ,(set 'eq7719))
;;    ((if (eq? #t (var eq7719))
;;      (((movq (int 42) (var if7720)) ,(set ) ,(set 'if7720)))
;;      (((movq (int 42) (var if7720)) ,(set ) ,(set 'if7720))))
;;     ,(set 'eq7719) ,(set 'if7720))
;;    ((movq (var if7720) (reg rax)) ,(set 'if7720) ,(set ))))
;;  (cmpq (int 0) (int 0))
;;  (sete (byte-reg al))
;;  (movzbq (byte-reg al) (var eq7719))
;;  (if (eq? #t (var eq7719))
;;     ((movq (int 42) (var if7720)))
;;     ((movq (int 777) (var if7720))))
;;  (movq (var if7720) (reg rax)))
