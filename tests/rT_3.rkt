(define (swap [v : (Vector a b)]) : (Vector b a)
  (vector (vector-ref v 1) (vector-ref v 0)))
(vector-ref (swap (vector #t 42)) 0)
