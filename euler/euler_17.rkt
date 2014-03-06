(define names (list "" "thousand" "million" "billion" "trillion" "quadrillion" "quintillion" "sextillion" "septillion" "octillion" "nonillion" "decillion" "undecillion" "duodecillion" "tredecillion" "quattuordecillion" "qinquadecillion" "sedecillion" "septendecillion" "octodecillion" "novendecillion" "vigntillion" "unvigintillion" "duovigintillion" "tresvigintillion" "quattuorvigintillion" "quinquavigintillion" "sesvigintillion" "octovigintillion" "novemvigintillion" "trigintillion" "untrigintillion" "duotrigintillion"))
(define <20 (list "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))
(define tens>20 (list "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "nintey"))

(define (to-word<20 n)
  (let loop ((n n) (ls <20))
    (if (= n 1) (car ls)
      (loop (- n 1) (cdr ls)))))

(define (to-word-tens n)
  (let loop ((n n) (ls tens>20))
    (if (= n 2) (car ls)
      (loop (- n 1) (cdr ls)))))

(define (name<1000 n) 
  (let loop ((n n) (ret '()))
    (cond ((= n 0) '("zero"))
          ((> (quotient n 100) 0)
           (cons (to-word<20 (quotient n 100))
                 (cons "hundred" 
                       (cond ((zero? (remainder n 100)) 
                              '())
                             ((< (remainder n 100) 20)
                              (cons "and" (cons (to-word<20 (remainder n 100)) ret)))
                             (else
                               (cons "and" (cons (to-word-tens (quotient (remainder n 100) 10)) (if (= (remainder n 10) 0) ret
                                                                                                  (cons (to-word<20 (remainder n 10)) ret)))))))))
          ((< (remainder n 100) 20)
           (cons (to-word<20 (remainder n 100)) ret))
          (else
            (cons (to-word-tens (quotient (remainder n 100) 10)) (if (= (remainder n 10) 0) ret
                                                                   (cons (to-word<20 (remainder n 10)) ret)))))))

(define (number-name n)
  (if (= n 0) '("zero")
    (let loop ((n n) (ls names) (ret '()))
      (if (or (not (number? n)) (= n 0)) ret
        (loop (quotient n 1000)
              (cdr ls)
              (if (= (remainder n 1000) 0) ret
                (append (name<1000 (remainder n 1000)) (if (null? (car ls)) ret
                                                         (cons (car ls) ret)))))))))

(define (count-letters number-ls)
  (foldl + 0 (map string-length number-ls)))

(define (number-lst max) 
  (map add1 (build-list max values)))

(define (euler-17 max)
  (foldl + 0 (map count-letters (map number-name (number-lst max)))))
