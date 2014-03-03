(struct node (value left right) #:transparent)

(define morse-alphabet
  '((#\A 1 0) (#\B 0 1 1 1) (#\C 0 1 0 1) (#\D 0 1 1) (#\E 1) (#\F 1 1 0 1) (#\G 0 0 1) (#\H 1 1 1 1) (#\I 1 1) (#\J 1 0 0 0) (#\K 0 1 0) (#\L 1 0 1 1) (#\M 0 0) (#\N 0 1) (#\O 0 0 0) (#\P 1 0 0 1) (#\Q 0 0 1 0) (#\R 1 0 1) (#\S 1 1 1) (#\T 0) (#\U 1 1 0) (#\V 1 1 1 0) (#\W 1 0 0) (#\X 0 1 1 0) (#\Y 0 1 0 0) (#\Z 0 0 1 1)))

(define (encode-char char)
  (let loop ([keys morse-alphabet])
    (if (equal? char (car (car keys))) (cdr (car keys))
      (loop (cdr keys)))))

(define (list-morse-encode ls)
  (let loop ([ls ls])
    (if (null? ls) '()
      (cons (encode-char (car ls)) (loop (cdr ls))))))

(define (morse-encode str)
  (list-morse-encode (string->list (string-upcase str))))
