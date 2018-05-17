#lang racket

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))

(define (from-to s e)
  (if (= s e)
      (list s)
      (cons s (from-to (+ s 1) e))))

  ;;CWICZENIE 1
(define (queens board-size)
  ;; Return the representation of a board with 0 queens inserted
  (define (empty-board); reprezentacja jako lista pozycji w kolumnach.
    null)              ; (xn, xn-1, ..., x2, x1)
  ;; Return the representation of a board with a new queen at
  ;; (row, col) added to the partial representation `rest'
  (define (adjoin-position row col rest)
    (cons row rest))
  ;; Return true if the queen in k-th column does not attack any of
  ;; the others
  (define (safe? k positions)
    (let ([first (car positions)])
      (define (iter up down rest)
        (if (null? rest) #t
            (let ([check (car rest)])
              (cond [(= check first) #f]
                    [(= check up) #f]
                    [(= check down) #f]
                    [else (iter (+ 1 up) (- down 1) (cdr rest))]))))
      (iter (+ 1 first) (- first 1) (cdr positions))))
            
  ;; Return a list of all possible solutions for k first columns
  (define (queen-cols k)
    (if (= k 0)
        (list (empty-board))
        (filter
         (lambda (positions) (safe? k positions))
         (concatMap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (from-to 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;;CWICZENIE 3
(define (btree? t)
  (or (eq? t 'leaf)
      (and (list? t)
           (= 4 (length t))
           (eq? (car t) 'node)
           (btree? (caddr t)) ;caddr to lewe poddrzewo, cadddr to prawe poddrzewo
           (btree? (cadddr t)))))

(define (mirror t)  ;odwraca drzewo (zamienia prawe i lewe poddrzewa)
  (cond [(not (btree? t)) #f]
        [(eq? 'leaf t) 'leaf]
        [else (list 'node (cadr t) (mirror (cadddr t)) (mirror (caddr t)))]))

;;CWICZENIE 4

(define (flatten tree ans) 
  (if (eq? tree 'leaf)
      ans
      (flatten (node-left tree)
               (cons (node-val tree) (flatten (node-right tree) ans)))))

(define (flatten2 t);zapisuje drzewo w postaci infixowej (lewy środek prawy)
  (if (leaf? t) null
      (append (flatten2 (node-left t)) (cons (node-val t) (flatten2 (node-right t))))))

;;CWICZENIE 5
(define (leaf? x) ;z wykładu, potrzebne do BST
  (eq? x 'leaf))
(define leaf 'leaf)
(define (node-val x)
  (cadr x))
(define (node-left x)
  (caddr x))
(define (node-right x)
  (cadddr x))
(define (make-node v l r)
  (list 'node v l r))
(define (bst-insert x t)
  (cond [(leaf? t)
         (make-node x leaf leaf)]
        [(< x (node-val t))
         (make-node (node-val t)
                    (bst-insert x (node-left t))
                    (node-right t))]
        [else
         (make-node (node-val t)
                    (node-left t)
                    (bst-insert x (node-right t)))]))

(define (treesort xs) ;wstawia po kolei elementy listy do drzewa BST
  (define (iter xs tree)
    (if (null? xs)
        tree
        (iter (cdr xs) (bst-insert (car xs) tree))))
  (flatten (iter xs 'leaf) null))

;CWICZENIE 6
(define (delete tree x) ;usuwa element z drzewa
  (define (bst-min tree) ;znajduje najmniejszy element w drzewie
    (if (eq? 'leaf (node-left tree))
        (node-val tree)
        (bst-min (node-left tree))))
  
  (cond [(null? tree) null]
        [(= x (node-val tree))
         (if (eq? (node-right tree) 'leaf)
             (node-left tree)
         (let ([m (bst-min (node-right tree))]);bierzemy najmniejszy element w prawym poddrzewie,
           (make-node m (node-left tree) (delete (node-right tree) m))))];wstawiamy go na górę i usuwamy
        [(> x (node-val tree));gdy x większy, to chcemy usunąć z prawego poddrzewa
         (make-node (node-val tree)
                    (node-left tree)
                    (delete (node-right tree x)))]
        [(< x (node-val tree))
         (make-node (node-val tree)
                    (delete (node-left tree) x)
                    (node-right tree))]))