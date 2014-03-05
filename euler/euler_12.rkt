;What is the value of the first triangle number to have over 500 divisors


(define (nth-triangle-number n)
  (if (zero? n) 0
    (+ n (nth-triangle-number (sub1 n)))))

(define (list-divisors-slow n)
  (let loop ([ret '()] [a n])
    (if (zero? a) ret
      (loop (if (zero? (modulo n a)) (cons a ret)
              ret)
            (sub1 a)))))

(define (list-divisors n)
  (let ([cap (sqrt n)])
    (let loop ([ret '()] [a 1])
      (cond [(= a cap)
             (cons a ret)]
            [(> a cap)
             ret]
            [else
              (let ([div (/ n a)])
                (loop (if (integer? div) (cons div (cons a ret))
                        ret) 
                      (add1 a)))]))))

;find the first triangle number with over 500 divisors
(let loop ([index 1] [trinum 1])
  (if (> (length (list-divisors trinum)) 500) trinum
    (loop (add1 index) (+ 1 index trinum))))
