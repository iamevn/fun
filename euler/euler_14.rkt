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
