(define (const [c : a] [t : b]) : a c)
(define (id [x : a]) : a x)
(const (if (const #t 0)
	   (const (id 42) #f)
	   (const 777 (const #f #t))) #f)