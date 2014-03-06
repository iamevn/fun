(define (power-digit-sum n)
  (foldl + 0 (map (lambda (digit)
<<<<<<< HEAD
              (string->number (string digit)))
              (string->list (number->string n)))))
=======
                    (string->number (string digit)))
                  (string->list (number->string n)))))
>>>>>>> 29ccea36fafc0f0695243a7c6e77d4da3ef051a5

(power-digit-sum (expt 2 1000))
