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
      (let ([instr (car line)]
            [after-set (caddr line)])
        (match instr

	 ;; free ptr is manage by c runtime
	 [`(movq (global-value free_ptr) (,_ ,dst))
	  (set-map (set-subtract after-set (set dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]

	 [`(addq (,_ ,src) (global-value free_ptr)) (void)]
	 ;; free ptr

         [`(movq (int ,_) (,_ ,dst))
	  (set-map (set-subtract after-set (set dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]

	 [`(movq (,_ ,src) (,_ ,dst))
	  (set-map (set-subtract after-set (set src dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]

	 [`(movzbq (,_ ,src) (,_ ,dst))
	  (set-map (set-subtract after-set (set src dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]


	 [`(movq (offset (,_ ,src-root) ,i) (,_ ,dst))
	  (add-edge graph dst src-root)
	  (set-map (set-subtract after-set (set src-root dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]

	 [`(movq (int ,_) (offset (,_ ,dst-root) ,i))
	  (set-map (set-subtract after-set (set dst-root))
		   (lambda (live-after)
		     (add-edge graph dst-root live-after)))]

	 [`(movq (,_ ,src) (offset (,_ ,dst-root) ,i))
	  (add-edge graph dst-root src)
	  (set-map (set-subtract after-set (set src dst-root))
		   (lambda (live-after)
		     (add-edge graph dst-root live-after)))]

	 [`(movq (offset (,_ ,src-root) ,i) (offset (,_ ,dst-root) ,i))
	  (add-edge graph dst-root src-root)
	  (set-map (set-subtract after-set (set src-root dst-root))
		   (lambda (live-after)
		     (add-edge graph dst-root live-after)))]


	 [`(,op (,_ ,src) (,_ ,dst)) #:when (member op '(addq subq xorq))
	  (set-map (set-subtract after-set (set dst))
		   (lambda (live-after)
		     (add-edge graph dst live-after)))]

	 [`(cmpq ,_ ,_) (void)]
	 [`(sete ,_) (void)]
	 [`(setl ,_) (void)]
	 [`(negq ,_) (void)]

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
