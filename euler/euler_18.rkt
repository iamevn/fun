; 75
; 95 64
; 17 47 82
; 18 35 87 10
; 20 04 82 47 65
; 19 01 23 75 03 34
; 88 02 77 73 07 63 67
; 99 65 04 28 06 16 70 92
; 41 41 26 56 83 40 80 70 33
; 41 48 72 33 47 32 37 16 94 29
; 53 71 44 65 25 43 91 52 97 51 14
; 70 11 33 28 77 73 17 78 39 68 17 57
; 91 71 52 38 17 14 91 43 58 50 27 29 48
; 63 66 04 68 89 53 67 30 73 16 69 87 40 31
; 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
(define triangle '(75 95 64 17 47 82 18 35 87 10 20 04 82 47 65 19 01 23 75 03 34 88 02 77 73 07 63 67 99 65 04 28 06 16 70 92 41 41 26 56 83 40 80 70 33 41 48 72 33 47 32 37 16 94 29 53 71 44 65 25 43 91 52 97 51 14 70 11 33 28 77 73 17 78 39 68 17 57 91 71 52 38 17 14 91 43 58 50 27 29 48 63 66 04 68 89 53 67 30 73 16 69 87 40 31 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23))

;to find max path sum from root of triangle
(define (max-path-sum node)
  (+ (car node)
     (if (null? (cdr node)) 0
       (max (max-path-sum (child-triangle node 'left))
            (max-path-sum (child-triangle node 'right))))))

(define test-triangle
  '(01 02 03 04 05 06 07 08 09 10 11 12 13 14 15))
; 01
; 02 03
; 04 05 06
; 07 08 09 10
; 11 12 13 14 15

;(child-triangle test-triangle 'left) filters out the right edge of the triangle
;   01 03 06 10 15 21 28 36 45 etc
;(child-triangle test-triangle 'right) filters out the left edge of the triangle
;   01 02 04 07 11 16 22 29 37 etc

(define (child-triangle ls rule)
  (let loop ([ls ls] [counter 1] [next-to-remove 1] [removed 0])
    (cond [(null? ls) '()]
          [(= next-to-remove counter)
           (loop (cdr ls) 
                 (add1 counter) 
                 (+ (+ removed 
                       (if (eq? rule 'right) 1 2)) 
                    next-to-remove) 
                 (add1 removed))]
          [else (cons (car ls) 
                      (loop (cdr ls) 
                            (add1 counter) 
                            next-to-remove 
                            removed))])))
