;number of paths through a nxn grid from top left to bottom right only moving right and down
;count the paths, reallly slow: O(!n) :(
(define (count-paths n)
  (let loop ([right n] [down n])
    (+ (if (= right 1) 1
         (loop (sub1 right) down))
       (if (= down 1) 1
         (loop right (sub1 down))))))

;2n choose n
(define (! n)
  (if (zero? n) 1
    (* n (! (sub1 n)))))

(define (paths x y)
  (/ (! (+ x y)) 
     (* (! x) (! y))))

(define (paths-through-square-lattice n)
  (paths n n))

(paths-through-square-lattice 20)
