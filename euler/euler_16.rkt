(define (power-digit-sum n)
  (foldl + 0 (map (lambda (digit)
              (string->number (string digit)))
              (string->list (number->string n)))))

(power-digit-sum (expt 2 1000))
