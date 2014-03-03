#lang racket
(define (count-collatz n)
  (let loop ([n n] [len 1])
    (cond ((= n 1)
           len)
          ((even? n)
           (loop (/ n 2) (add1 len)))
          (else
           (loop (add1 (* 3 n)) (add1 len))))))

(define (check-collatz ceiling)
  (let loop ([n 1] [len 1] [next 2] [next-len (count-collatz 2)])
  (cond ((= next ceiling)
         (if (> len next-len) n
             next))
        ((>= len next-len)
         (loop n len (add1 next) (count-collatz (add1 next))))
        ((> next-len len)
         (loop next next-len (add1 next) (count-collatz (add1 next)))))))