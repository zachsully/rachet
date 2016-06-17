(define (add1 [x : Integer]) : Integer (+ 1 x))
(define (fmapVec1 [f : (a -> b)]
                  [v : (Vector a)])
  : (Vector b)
  (vector (f (vector-ref v 0))))
(vector-ref (fmapVec1 add1 (vector 41)) 0)
