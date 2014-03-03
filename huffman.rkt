; #lang racket
;;huffman.rkt
;;Evan Minsk 06-02-2014
;;playing around with huffman encoding

;a node will have an index value and data which will contain either a pair nodes, or a char
(struct node (value data))
(struct node-pair (left right))

;constructs a node containing the sum of the values of the sub nodes and a list of the subnodes
(define (build-node a b #:transparent)
  (node (+ (node-value a) (node-value b)) (node-pair a b) #:transparent))

;returns the lowest value node in a list of nodes
(define (lowest ls)
  (let loop ([ls (cdr ls)] [ret (car ls)])
    (cond [(null? ls)
           ret]
          [(< (node-value (car ls)) (node-value ret))
           (loop (cdr ls) (car ls))]
          [else
            (loop (cdr ls) ret)])))

;sorts a list of nodes
(define (node-sort ls)
  (let loop ([ls ls])
    (if (null? (cdr ls)) 
      ls
      (cons (lowest ls)
            (loop (remove (lowest ls) ls))))))

;builds a tree using huffman sort method
;returns the tree with a single root node
(define (huff-sort ls)
  (let loop ([ls (node-sort ls)])
    (if (null? (cdr ls)) 
      (car ls)
      (loop (node-sort (cons (build-node (first ls) (second ls))
                             (cdr (cdr ls))))))))

;traverse tree in search of w and return the binary path (left right left left -> 0100)
;returns path as a list, returns null if w is not in tree
(define (huff-traverse tree w)
  (reverse (let search ([n tree] [path null])
             (cond [(node-pair? (node-data n))
                    (if (null? (search (node-pair-left (node-data n)) 
                                       (cons 0 path))) 
                      (search (node-pair-right (node-data n)) 
                              (cons 1 path))
                      (search (node-pair-left (node-data n))
                              (cons 0 path)))]
                   [else
                     (if (equal? (node-data n) w) 
                       path
                       '())]))))

;sample input and search
(define input 
  (list ;(node 0 "hello") (node 12 13) (node 3 '("this" "is" "a" "list")) (node 4 "world!")
    (node 1 #\B) (node 6 #\A) (node 4 #\N) (node 2 #\R) (node 5 #\M)))

;tree with single node as root
(define huffman-tree
  (huff-sort input))

;map traversal over the word BARN
(map (λ (letter)
        (huff-traverse huffman-tree letter))
     (string->list "BARN"))

(define wiki-list
  (list (node 7 #\space) (node 4 #\a) (node 4 #\e) (node 3 #\f) (node 2 #\h) (node 2 #\i) (node 2 #\m) (node 2 #\n) (node 2 #\s) (node 2 #\t) (node 1 #\l) (node 1 #\o) (node 1 #\p) (node 1 #\r) (node 1 #\u) (node 1 #\x)))
;;GO OVER ALGORITHM
