(define (fibonacci? n)
  (or (perfect-square? (- (* 5 (expt n 2)) 4)) 
      (perfect-square? (+ (* 5 (expt n 2)) 4))))

(define (perfect-square? n)
  (integer? (sqrt n)))

; smallest 1000 digit number is 10^999 
(define (slow-way)
  (let loop ([n (expt 10 999)])
    (if (fibonacci? n) n
      (loop (add1 n)))))

;simple but fast
(define (count-digits n)
  (string-length (number->string n)))

(define (euler_25)
  (let loop ([f 2] [current 1] [prev 1])
    (if (= (count-digits current) 1000) current
      (loop (add1 f) (+ current prev) current))))
