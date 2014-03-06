(define (digit-list n) (build-list n values))

;definitely doing 3x the work needed, only need to generate until 1000000th permutation, not 10!
(define (gen-permutations ls)
  (if (= 1 (length ls)) (list ls)
    (let loop ([foo (car ls)] [i 1])
      (append (map (lambda (bar)
                     (cons foo bar))
                   (gen-permutations (remove foo ls)))
              (if (= i (length ls)) '()
                (loop (list-ref ls i) (add1 i)))))))

(define (nth-permutation-of-k-digits n k)
  (list-ref (gen-permutations (digit-list k)) (sub1 n)))
