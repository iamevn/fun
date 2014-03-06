(define (leapyear? year)
  (if (zero? (modulo year 4))
    (if (zero? (modulo year 100))
      (if (zero? (modulo year 400)) #t
        #f)
      #t)
    #f))

(define (month-lengths year)
  (list 31 (if (leapyear? year) 29 28) 31 30 31 30 31 31 30 31 30 31))

(define (modulo-month-list year)
  (map (lambda (days) (modulo days 7)) (month-lengths year)))

(define (build-offset-list years)
  (foldl append '() (map modulo-month-list (map (lambda (x) (+ x 1900)) 
                                                (build-list years values)))))

; day -364 had value 1
; day 1 (1 Jan 1901) had value (+ 1 (modulo 365 7)) = 2
(define (sundays-on-first-of-month years)
  (let loop ([init 2] [count 0] [ls (build-offset-list years)])
    (if (null? (cdr ls)) count
      (loop (modulo (+ init (car ls)) 7) 
            (if (zero? init) (add1 count) 
              count)
            (cdr ls)))))
