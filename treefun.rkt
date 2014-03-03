; #lang racket
(struct node (value left right) #:transparent)

(define (insert itm tree)
  (cond [(null? tree) (node itm '() '())]
        [(<= itm (node-value tree)) (node (node-value tree) 
                                          (insert itm (node-left tree)) 
                                          (node-right tree))]
        [else (node (node-value tree)
                    (node-left tree)
                    (insert itm (node-right tree)))]))

(define (build-binary-tree ls)
  (if (null? ls) '()
    (let loop ([tree (node (car ls) '() '())] 
               [ls (cdr ls)])
      (if (null? ls) 
        tree
        (loop (insert (car ls) tree) (cdr ls))))))

(define (tree-min tree)
  (cond [(null? tree) '()]
        [(null? (node-left tree))
         (node-value tree)]
        [else (tree-min (node-left tree))]))

(define (tree-max tree)
  (cond [(null? tree) '()]
        [(null? (node-right tree))
         (node-value tree)]
        [else (tree-max (node-right tree))]))

(define (height node)
  (if (null? node) -1
    (add1 (max (height (node-left node)) 
               (height (node-right node))))))


(define (delete itm tree)
  (cond [(null? tree) #f]
        [(< itm (node-value tree)) (node (node-value tree)
                                         (delete itm (node-left tree))
                                         (node-right tree))]
        [(> itm (node-value tree)) (node (node-value tree)
                                         (node-left tree)
                                         (delete itm (node-right tree)))]
        [else (if (and (null? (node-left tree)) 
                       (null? (node-right tree))) 
                '()
                (node (tree-min (node-right tree))
                      (node-left tree)
                      (delete (tree-min (node-right tree)) (node-right tree))))]))

(define testls '(15 19 17 25 16 18 24 26))
(define testtree (build-binary-tree testls))

(define (graphviz-string tree title)
  (string-append "digraph " title "{\n \"\"[shape=none];\n"
                 (let loop ([str ""]
                            [node tree])
                   (if (null? node) ""
                     (string-append str
                                    (if (null? (node-left node)) (string-append " "
                                                                                (number->string (node-value node))
                                                                                "->\"\" [color=white];\n")
                                      (loop (string-append " "
                                                           (number->string (node-value node)) 
                                                           "->" 
                                                           (number->string (node-value (node-left node))) 
                                                           ";\n")
                                            (node-left node)))
                                    (if (null? (node-right node)) (string-append " "
                                                                                 (number->string (node-value node))
                                                                                 "->\"\" [color=white];\n")
                                      (loop (string-append " "
                                                           (number->string (node-value node)) 
                                                           "->" 
                                                           (number->string (node-value (node-right node))) 
                                                           ";\n")
                                            (node-right node))))))
                 "}"))


(define (str-to-file str filename)
  (call-with-output-file filename
                         #:exists 'replace
                         (lambda (out)
                           (display str out))))

(define (graph-out filename)
  (system (string-append "dot -Tsvg " filename " -O")))

(define (viewnior filename)
  (system (string-append "viewnior " filename)))

(define (print-to-image tree filename)
  (str-to-file (graphviz-string tree filename) filename)
  (graph-out filename))
  ; (viewnoir (string-append filename ".svg")))
