(define (id [x : a]) : a x)
(id (if (id #f)
	0
	42))
