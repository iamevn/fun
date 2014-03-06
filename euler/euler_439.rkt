(require math/number-theory)

; sum of divisors of k
(define (d k)
  (foldl + 0 (divisors k)))

(define (buildlst max)
  (let loop ([n 1])
    (if (= n max) (list max)
      (cons n (loop (add1 n))))))

(define (sumd n)
  (foldl + 0 (map d (buildlst n))))

