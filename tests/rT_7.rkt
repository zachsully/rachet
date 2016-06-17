(define (id [x : a]) : a x)
(vector-ref (id (vector 42)) 0)
