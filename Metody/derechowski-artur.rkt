#lang racket

;; expressions

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * /))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define op-left second)
(define op-right third)

(define (op-cons op args)
  (cons op args))

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

(define (arith/let-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith/let-expr? (op-args t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-def-expr (let-def t))))
      (var? t)))

;; let-lifted expressions

(define (arith-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith-expr? (op-args t)))
      (var? t)))

(define (let-lifted-expr? t)
  (or (and (let? t)
           (let-lifted-expr? (let-expr t))
           (arith-expr? (let-def-expr (let-def t))))
      (arith-expr? t)))

;; generating a symbol using a counter

(define (number->symbol i)
  (string->symbol (string-append "x" (number->string i))))

(define (numbered? t);typ danych zapamiętujący daną i licznik 
  (and (list? t)
       (= 3 (length t))
       (eq? (car t) 'num)
       (const? (cadr t))))
(define num-iter second)
(define num-expr third)
(define (num-cons it val)
  (list 'num it val))

;; environments (could be useful for something)

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

;; the let-lift procedure

(define (let-lift e)
  (define (swap-vars e envi);wylicza wyrażenia arytmetyczne w środowisku
    (cond [(const? e) e]
          [(var? e) (find-in-env e envi)]
          [else (map (λ (arg) (if (and (var? arg)
                                       (not (member arg '(+ - * /))))
                                  (find-in-env arg envi)
                                  arg))
                     e)]))
  (define (rename-uni numex it env);zmienia wartości wszystkich zmiennych na unikalne
    #|(writeln numex)
    (writeln it)
    (writeln env)|#
    ;bierze wyrażenie w postaci numerowanej (z prefiksem - globalny licznik)
    ;tutaj dużo czytelniej byłoby użyć instrukcji set!,
    ;zamiast skomplikowanego przekazywania licznika, ale ona chyba nie jest czysto funkcyjna?
    (cond [(arith-expr? (num-expr numex)) (num-cons it (swap-vars (num-expr numex) env))]
          [(let? (num-expr numex))
           (let* ([newval (number->symbol it)]
                  [def-subf (rename-uni
                             (num-cons (+ 1 it) (let-def-expr (let-def (num-expr numex))))
                             (+ 1 it)
                             env)]
                  [exp-subf (rename-uni
                             (num-cons (num-iter def-subf) (let-expr (num-expr numex)))
                             (num-iter def-subf)
                             (add-to-env (let-def-var (let-def (num-expr numex)))
                                         newval
                                         env))])
             (num-cons (num-iter exp-subf)
                       (let-cons (let-def-cons newval (num-expr def-subf))
                                 (num-expr exp-subf))))]
          [(op? (num-expr numex))
           (let* ([subleft (rename-uni (num-cons it (op-left (num-expr numex)))
                                       it
                                       env)]
                  [subright (rename-uni (num-cons (num-iter subleft) (op-right (num-expr numex)))
                                        (num-iter subleft)
                                        env)])
             (num-cons (num-iter subright)
                       (op-cons (op-op (num-expr numex))
                                (list (num-expr subleft)
                                      (num-expr subright)))))]))

  (define (letpulldef ex);znajduje w wyrażeniu leta, w którego definicji już nie ma letów, albo zwraca #f
    (cond [(and (let? ex);"prosty" let, którego zawsze można wyciągnąć na przód
                (arith-expr? (let-def-expr (let-def ex))))
           (let-def ex)]
          [(arith-expr? ex) #f]
          [(op? ex) (if (letpulldef (op-left ex))
                        (letpulldef (op-left ex))
                        (letpulldef (op-right ex)))]
          [(let? ex) (if (letpulldef (let-def-expr (let-def ex)))
                         (letpulldef (let-def-expr (let-def ex)))
                         (letpulldef (let-expr ex)))]))

  (define (inside? ls val)
    ;(writeln ls)
    (cond [(null? ls) #f]
          [(equal? ls val) #t]
          [(not (list? ls)) #f]
          [(list? (car ls)) (or (inside? (car ls) val)
                                (inside? (cdr ls) val))]
          [(list? ls) (inside? (cdr ls) val)]))
  
  (define (letremove ex);usuwa let-definicję z wyrażenia (tę najbardziej zagnieżdżoną, która nie zależy od innych)
    (cond [(and (let? ex)
                (equal? (let-def ex) (letpulldef ex)))
           (let-expr ex)]
          [(arith-expr? ex) ex]
          [(op? ex) (op-cons (op-op ex)
                             (if (inside? (op-left ex) (letpulldef ex))
                                 (list (letremove (op-left ex)) (op-right ex))
                                 (list (op-left ex) (letremove (op-right ex)))))]
          [(let? ex) (if (letremove (let-def-expr (let-def ex)))
                         (let-cons (let-def-cons (let-def-var (let-def ex))
                                                 (letremove (let-def-expr (let-def ex))))
                                   (let-expr ex))
                         (let-cons (let-def-cons (let-def-var (let-def ex))
                                                 (let-def-expr (let-def ex)))
                                   (letremove (let-expr ex))))]))

  (define (deflist ex defs);wyciąga let-definicje z wyrażenia aż nie będzie żadnej i zapisuje razem z wyrażeniem
    (let* ([nextdef (letpulldef ex)]
           [cleared (letremove ex)])
      ;(writeln nextdef)
      ;(writeln cleared)
      (if nextdef
          (deflist cleared (cons nextdef defs))
          (list (reverse defs) cleared))))

  (define (finaltransform ls);funkcja pomocnicza, zapisująca listy w odpowiedni sposób
    (cond [(null? (car ls)) (cadr ls)]
          [else (let-cons (caar ls) (finaltransform (list (cdr (car ls)) (cadr ls))))]))
                 
  (let* ([uniexp (num-expr (rename-uni (num-cons 0 e) 0 empty-env))]
         [separated (deflist uniexp '())]);lista definicji i wyrażenia bez definicji
    (finaltransform separated)
    )
  )

#|Pomysł na program był taki, żeby najpierw przemianować wszystkie zmienne na unikalne
wartości, potem wyciągać kolejno zagnieżdżone lety z wyrażenia, a na koniec połączyć to let-cons.
Założyłem, że operatory są dwuargumentowe (w mailu wykładowca odpowiedział, że można tak
zrobić, bo "nie ma to wielkiego znaczenia dla idei rozwiązania", a ja miałem dużo trudności
z przekazywaniem globalnego licznika w przypadku zmiennej liczby argumentów.
TESTY: |#
(let-lift '(let (x 2) x));prosty test
(let-lift '(let (x (- 2 (let (z 3) z))) (+ x 2)));test z zagnieżdżonym letem
(let-lift '(let (x (let (x 2) x)) x));test z powtarzającą się nazwą
(let-lift '(let (x (let (y 2) (let (z 3) z))) (let (q 1) (+ q x))));test z wielkrotnym zagnieżdżeniem
(let-lift '(+ (let (x 5) x) (let (x 1) x)));test z operatorem na wierzchu
