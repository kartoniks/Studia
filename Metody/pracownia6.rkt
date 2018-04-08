#lang racket

(define (const? t)
  (number? t))

(define (binop? t)
  (and (list? t)
       (= (length t) 3)
       (member (car t) '(+ - * /))))

(define (binop-op e)
  (car e))

(define (binop-left e)
  (cadr e))

(define (binop-right e)
  (caddr e))

(define (binop-cons op l r)
  (list op l r))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (let-def? t)
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e)
  (car e))

(define (let-def-expr e)
  (cadr e))

(define (let-def-cons x e)
  (list x e))

(define (let? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'let)
       (let-def? (cadr t))))

(define (let-def e)
  (cadr e))

(define (let-expr e)
  (caddr e))

(define (let-cons def e)
  (list 'let def e))

(define (var? t)
  (symbol? t))

(define (var-var e)
  e)

(define (var-cons x)
  x)

(define (hole? t)
  (eq? t 'hole))

(define (arith/let/holes? t)
  (or (hole? t)
      (const? t)
      (and (binop? t)
           (arith/let/holes? (binop-left  t))
           (arith/let/holes? (binop-right t)))
      (and (let? t)
           (arith/let/holes? (let-expr t))
           (arith/let/holes? (let-def-expr (let-def t))))
      (var? t)))

(define (num-of-holes t)
  (cond [(hole? t) 1]
        [(const? t) 0]
        [(binop? t)
         (+ (num-of-holes (binop-left  t))
            (num-of-holes (binop-right t)))]
        [(let? t)
         (+ (num-of-holes (let-expr t))
            (num-of-holes (let-def-expr (let-def t))))]
        [(var? t) 0]))

(define (arith/let/hole-expr? t)
  (and (arith/let/holes? t)
       (= (num-of-holes t) 1)))

(define (hole-context e)
  ;; TODO: zaimplementuj!
  (define (hole-iter ex acc)
    (cond [(hole? ex) acc]
          [(const? ex) null]
          [(var? ex) null]
          [(binop? ex) (append (hole-iter (binop-left ex) acc)
                                (hole-iter (binop-right ex) acc))]
          ;w założeniu jest jedna dziura, więc append będzie działał na listach pustych i jednym akumulatorze
          [(let? ex) (append (hole-iter (let-def ex) acc)
                              (hole-iter (let-expr ex) (cons (let-def-var (let-def ex)) acc)))]
          ;jeśli wyrażenie jest letem to trzeba szukać dziury w definicji i w podwyrażeniu
          ;ale nową zmienną dodać tylko do podwyrażenia
          [(let-def? ex) (hole-iter (let-def-expr ex) acc)]))
  (remove-duplicates (hole-iter e null)))

(define (test)
  ;; TODO: zaimplementuj!
  (define tests
    (list [cons '(+ 3 hole)
                '()]
          [cons '(let (x 3) (let (y hole) (+ x y)))
                '(x)]
          [cons '(let (piesek  1)
                 (let (kotek  7)
                   (let (piesek  9)
                     (let (chomik  5) hole))))
                '(chomik kotek piesek)]
          [cons '(+ (let (x 3) x) hole)
                '()]
          [cons '(let (x (let (y 3) hole)) x)
                '(y)]))
  (andmap (λ (test) (equal? (sort (hole-context (car test)) symbol<?) (cdr test)))
       tests) ;ktoś może mieć wynik w innej kolejności, dlatego sortowanie
  )
#|;stare testy:
(hole-context '(+ 3 hole))
(hole-context '(let (x 3) (let (y 7) (+ x hole))))
(hole-context '(let (x 3) (let (y hole) (+ x y))))
(hole-context '(let (piesek  1)
                 (let (kotek  7)
                   (let (piesek  9)
                     (let (chomik  5) hole)))))
(hole-context '(let(x 3) (let(hole y) (+ x hole))))|#
(test)