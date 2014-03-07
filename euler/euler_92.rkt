(define (in-ls? n ls)
  (cond [(null? ls) #f]
        [(= n (car ls)) #t]
        [else (in-ls? n (cdr ls))]))

(define (next-in-chain n)
  (foldl + 0 (map (lambda (n) (expt n 2))
                  (map (lambda (foo) (string->number (string foo))) 
                       (string->list (number->string n))))))

(define (euler_92 ceil)
  (let loop ([start 1] [89-ls '(89)] [1-ls '(1)])
    ;(display start)(newline)
    (if (= start ceil) (length 89-ls)
      (let traverse ([n start] [ls '()])
        ;if n is in either list, append ls to appropriate
        ;list, loop with next n
        ;else traverse with new n by rule and add n to ls
        (cond [(in-ls? n 1-ls)
               (loop (add1 start) 89-ls (append ls 1-ls))]
              [(in-ls? n 89-ls)
               (loop (add1 start) (append ls 89-ls) 1-ls)]
              [else (traverse (next-in-chain n)
                              (cons n ls))])))))
