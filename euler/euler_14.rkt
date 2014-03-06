<<<<<<< HEAD
; number of uniqure paths through an nxn grid
(define (paths-through-grid n)
  (if (= 1 n) 2
    (+ (* n n) (paths-through-grid (sub1 n)))))

; count paths through nxn grid
(define (count-paths n)
  (let loop ([right n] [down n])
    (+ (if (one? right) 1
         (loop (sub1 right) down))
       (if (one? down) 1
         (loop right (sub1 down))))))
=======
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

(check-collatz 1000000)
>>>>>>> 29ccea36fafc0f0695243a7c6e77d4da3ef051a5
