#lang racket

;; pomocnicza funkcja dla list tagowanych o określonej długości
(define (tagged-tuple? tag len p)
  (and (list? p)
       (= (length p) len)
       (eq? (car p) tag)))

(define (tagged-list? tag p)
  (and (pair? p)
       (eq? (car p) tag)
       (list? (cdr p))))

;; reprezentacja danych wejściowych (z ćwiczeń)
(define (var? x)
  (symbol? x))

(define (var x)
  x)

(define (var-name x)
  x)

;; przydatne predykaty na zmiennych
(define (var<? x y)
  (symbol<? x y))

(define (var=? x y)
  (eq? x y))

(define (literal? x)
  (and (tagged-tuple? 'literal 3 x)
       (boolean? (cadr x))
       (var? (caddr x))))

(define (literal pol x)
  (list 'literal pol x))

(define (literal-pol x)
  (cadr x))

(define (literal-var x)
  (caddr x))

(define (clause? x)
  (and (tagged-list? 'clause x)
       (andmap literal? (cdr x))))

(define (clause . lits)
  (cons 'clause lits))

(define (clause-lits c)
  (cdr c))

(define (cnf? x)
  (and (tagged-list? 'cnf x)
       (andmap clause? (cdr x))))

(define (cnf . cs)
    (cons 'cnf cs))

(define (cnf-clauses x)
  (cdr x))

;; oblicza wartość formuły w CNF z częściowym wartościowaniem. jeśli zmienna nie jest
;; zwartościowana, literał jest uznawany za fałszywy.
(define (valuate-partial val form)
  (define (val-lit l)
    (let ((r (assoc (literal-var l) val)))
      (cond
       [(not r)  false]
       [(cadr r) (literal-pol l)]
       [else     (not (literal-pol l))])))
  (define (val-clause c)
    (ormap val-lit (clause-lits c)))
  (andmap val-clause (cnf-clauses form)))

;; reprezentacja dowodów sprzeczności

(define (axiom? p)
  (tagged-tuple? 'axiom 2 p))

(define (proof-axiom c)
  (list 'axiom c))

(define (axiom-clause p)
  (cadr p))

(define (res? p)
  (tagged-tuple? 'resolve 4 p))

(define (proof-res x pp pn)
  (list 'resolve x pp pn))

(define (res-var p)
  (cadr p))

(define (res-proof-pos p)
  (caddr p))

(define (res-proof-neg p)
  (cadddr p))

;; sprawdza strukturę, ale nie poprawność dowodu
(define (proof? p)
  (or (and (axiom? p)
           (clause? (axiom-clause p)))
      (and (res? p)
           (var? (res-var p))
           (proof? (res-proof-pos p))
           (proof? (res-proof-neg p)))))

;; procedura sprawdzająca poprawność dowodu
(define (check-proof pf form)
  (define (run-axiom c)
    (displayln (list 'checking 'axiom c))
    (and (member c (cnf-clauses form))
         (clause-lits c)))
  (define (run-res x cpos cneg)
    (displayln (list 'checking 'resolution 'of x 'for cpos 'and cneg))
    (and (findf (lambda (l) (and (literal-pol l)
                                 (eq? x (literal-var l))))
                cpos)
         (findf (lambda (l) (and (not (literal-pol l))
                                 (eq? x (literal-var l))))
                cneg)
         (append (remove* (list (literal true x))  cpos)
                 (remove* (list (literal false x)) cneg))))
  (define (run-proof pf)
    (cond
     [(axiom? pf) (run-axiom (axiom-clause pf))]
     [(res? pf)   (run-res (res-var pf)
                           (run-proof (res-proof-pos pf))
                           (run-proof (res-proof-neg pf)))]
     [else        false]))
  (null? (run-proof pf)))


;; reprezentacja wewnętrzna

;; sprawdza posortowanie w porządku ściśle rosnącym, bez duplikatów
(define (sorted? vs)
  (or (null? vs)
      (null? (cdr vs))
      (and (var<? (car vs) (cadr vs))
           (sorted? (cdr vs)))))

(define (sorted-varlist? x)
  (and (list? x)
       (andmap (var? x))
       (sorted? x)))

;; klauzulę reprezentujemy jako parę list — osobno wystąpienia pozytywne i negatywne. Dodatkowo
;; pamiętamy wyprowadzenie tej klauzuli (dowód) i jej rozmiar.
(define (res-clause? x)
  (and (tagged-tuple? 'res-int 5 x)
       (sorted-varlist? (second x))
       (sorted-varlist? (third x))
       (= (fourth x) (+ (length (second x)) (length (third x))))
       (proof? (fifth x))))

(define (res-clause pos neg proof)
  (list 'res-int pos neg (+ (length pos) (length neg)) proof))

(define (res-clause-pos c)
  (second c))

(define (res-clause-neg c)
  (third c))

(define (res-clause-size c)
  (fourth c))

(define (res-clause-proof c)
  (fifth c))

;; przedstawia klauzulę jako parę list zmiennych występujących odpowiednio pozytywnie i negatywnie
(define (print-res-clause c)
  (list (res-clause-pos c) (res-clause-neg c)))

;; sprawdzanie klauzuli sprzecznej
(define (clause-false? c)
  (and (null? (res-clause-pos c))
       (null? (res-clause-neg c))))

;; pomocnicze procedury: scalanie i usuwanie duplikatów z list posortowanych
(define (merge-vars xs ys)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [(var<? (car xs) (car ys))
         (cons (car xs) (merge-vars (cdr xs) ys))]
        [(var<? (car ys) (car xs))
         (cons (car ys) (merge-vars xs (cdr ys)))]
        [else (cons (car xs) (merge-vars (cdr xs) (cdr ys)))]))

(define (remove-duplicates-vars xs)
  (cond [(null? xs) xs]
        [(null? (cdr xs)) xs]
        [(var=? (car xs) (cadr xs)) (remove-duplicates-vars (cdr xs))]
        [else (cons (car xs) (remove-duplicates-vars (cdr xs)))]))

(define (rev-append xs ys)
  (if (null? xs) ys
      (rev-append (cdr xs) (cons (car xs) ys))))

;; TODO: miejsce na uzupełnienie własnych funkcji pomocniczych
(define (make-clause var pos-cl neg-cl) ;tworzy rezolwentę dwóch klauzul i wspólnej zmiennej
  (let ([new-pos (merge-vars (remove var (res-clause-pos pos-cl))
                             (remove var (res-clause-pos neg-cl)))]
        [new-neg (merge-vars (remove var (res-clause-neg pos-cl))
                             (remove var (res-clause-neg neg-cl)))])
    (res-clause new-pos
                new-neg
                (proof-res var
                           (res-clause-proof pos-cl)
                           (res-clause-proof neg-cl)))))

(define (list-find list1 list2) ;znajduje wspólny element w listach albo zwraca fałsz
  (cond [(and (null? list1)
              (null? list2)) #f]
        [(null? list1) (list-find list1 (cdr list2))]
        [(null? list2) (list-find (cdr list1) list2)]
        [(var=? (car list1) (car list2)) (car list1)] 
        [(var<? (car list1) (car list2)) (list-find (cdr list1) list2)]
        [else                            (list-find list1 (cdr list2))]))
  
(define (clause-trivial? c)
  ;; TODO: zaimplementuj!
  (if (eq? (list-find (res-clause-pos c)
                    (res-clause-neg c)) false)
      false
      true))

(define (resolve c1 c2)
  ;; TODO: zaimplementuj!
  (let ([v1 (list-find (res-clause-pos c1)
                       (res-clause-neg c2))]
        [v2 (list-find (res-clause-pos c2)
                       (res-clause-neg c1))])
    (cond [(var? v1) (make-clause v1 c1 c2)]
          [(var? v2) (make-clause v2 c2 c1)]
          [else false])))

(define (resolve-single-prove s-clause checked pending)
  ;; TODO: zaimplementuj!
  (define (includes l s-cl);czy lista l zawiera s-clause
      (cond [(null? l) false]
            [(eq? (car s-cl) (car l)) true]
            [else (includes (cdr l) s-cl)]))
  (define (swap-by-res cl) ;podstawia zamiast klauzuli jej rezolwentę jeśli zawiera s
    (cond [(and (= 1 (length (res-clause-pos s-clause)))
                (includes (res-clause-neg cl) (res-clause-pos s-clause)))
           (res-clause (res-clause-pos cl)
                       (remove (res-clause-pos s-clause)
                               (res-clause-neg cl))
                       (res-clause-proof cl))]
          [(and (= 1 (length (res-clause-neg s-clause)))
                (includes (res-clause-pos cl) (res-clause-neg s-clause)))
           (res-clause (remove (res-clause-neg s-clause)
                               (res-clause-pos cl))
                       (res-clause-pos cl)
                       (res-clause-proof cl))]
          [else cl]))

  (let* ([new-checked (sort (cons s-clause (map (λ (cl) (swap-by-res cl)) checked))
                           < #:key res-clause-size)]
        [new-pending (sort (map (λ (cl) (swap-by-res cl)) pending)
                           < #:key res-clause-size)]
        [resolvents   (filter-map (lambda (c) (resolve c s-clause))
                                   checked)]
        [sorted-rs    (sort resolvents < #:key res-clause-size)])
    (subsume-add-prove new-checked new-pending sorted-rs)))

  ;; Poniższa implementacja działa w ten sam sposób co dla większych klauzul — łatwo ją poprawić!
 #| (let* ((resolvents   (filter-map (lambda (c) (resolve c s-clause))
                                     checked))
         (sorted-rs    (sort resolvents < #:key res-clause-size)))
    (subsume-add-prove (cons s-clause checked) pending sorted-rs)))|#

;; wstawianie klauzuli w posortowaną względem rozmiaru listę klauzul
(define (insert nc ncs)
  ;(writeln ncs)
  (cond
   [(null? ncs)                     (list nc)]
   [(< (res-clause-size nc)
       (res-clause-size (car ncs))) (cons nc ncs)]
   [else                            (cons (car ncs) (insert nc (cdr ncs)))]))

;; sortowanie klauzul względem rozmiaru (funkcja biblioteczna sort)
(define (sort-clauses cs)
  (sort cs < #:key res-clause-size))

;; główna procedura szukająca dowodu sprzeczności
;; zakładamy że w checked i pending nigdy nie ma klauzuli sprzecznej
(define (resolve-prove checked pending)
  (cond
   ;; jeśli lista pending jest pusta, to checked jest zamknięta na rezolucję czyli spełnialna
   [(null? pending) (generate-valuation (sort-clauses checked))]
   ;; jeśli klauzula ma jeden literał, to możemy traktować łatwo i efektywnie ją przetworzyć
   [(= 1 (res-clause-size (car pending)))
    (resolve-single-prove (car pending) checked (cdr pending))]
   ;; w przeciwnym wypadku wykonujemy rezolucję z wszystkimi klauzulami już sprawdzonymi, a
   ;; następnie dodajemy otrzymane klauzule do zbioru i kontynuujemy obliczenia
   [else
    (let* ((next-clause  (car pending))
           (rest-pending (cdr pending))
           (resolvents   (filter-map (lambda (c) (resolve c next-clause))
                                     checked))
           (sorted-rs    (sort-clauses resolvents)))
      (subsume-add-prove (cons next-clause checked) rest-pending sorted-rs))]))

;; procedura upraszczająca stan obliczeń biorąc pod uwagę świeżo wygenerowane klauzule i
;; kontynuująca obliczenia. Do uzupełnienia.
(define (subsume-add-prove checked pending new)
  #|(writeln checked)
  (writeln pending)
  (writeln new)
  (writeln "stop")|#
  (cond
   [(null? new)                 (resolve-prove checked pending)]
   ;; jeśli klauzula do przetworzenia jest sprzeczna to jej wyprowadzenie jest dowodem sprzeczności
   ;; początkowej formuły
   [(clause-false? (car new))   (list 'unsat (res-clause-proof (car new)))]
   ;; jeśli klauzula jest trywialna to nie ma potrzeby jej przetwarzać
   [(clause-trivial? (car new)) (subsume-add-prove checked pending (cdr new))]
   [else
    ;; TODO: zaimplementuj!
    (define (includes l1 l2);czy lista l1 jest zawarta w liście l2
      (cond [(null? l1) true]
            [(null? l2) false]
            [(eq? (car l1) (car l2)) (includes (cdr l1) (cdr l2))]
            [else (includes l1 (cdr l2))]))
    
    (define (harder? cl)
      (and (includes (res-clause-pos cl) (res-clause-pos (car new)))
           (includes (res-clause-neg cl) (res-clause-neg (car new)))))
    (define (not-easier? l)
      (or (not (includes (res-clause-pos (car new)) (res-clause-pos l)))
          (not (includes (res-clause-neg (car new)) (res-clause-neg l)))))
    
    (cond [(ormap harder? checked) (subsume-add-prove checked pending (cdr new))];jeśli któraś klauzula jest trudniejsza, to nie dodajemy
          [(ormap harder? pending) (subsume-add-prove checked pending (cdr new))]
          [else (subsume-add-prove (filter not-easier? checked)
                                   (insert (car new) (filter not-easier? pending))
                                   (cdr new))])
    ;; Poniższa implementacja nie sprawdza czy nowa klauzula nie jest lepsza (bądź gorsza) od już
    ;; rozpatrzonych; popraw to!
    ]))

(define (generate-valuation resolved)
  ;; TODO: zaimplementuj!
  {define (delete var cl-list)
    (map (λ (cl) (res-clause (remove var (res-clause-pos cl))
                             (remove var (res-clause-neg cl))
                             (res-clause-proof cl)))
         cl-list)}
  
  {define (iter-valuate remaining acc); w akumulatorze listy pozytywnych i negatywnych wartościowań
    (if (null? remaining)
        acc
        (let ([first (car remaining)])
          (cond [(= 0 (res-clause-size first))
                 (iter-valuate (cdr remaining) acc)]
                [(= 1 (res-clause-size first));gdy klauzula jest literałem, to ją wyrzucam
                 (if (= 1 (length (res-clause-pos first)))
                     (iter-valuate (delete (car (res-clause-pos first)) (cdr remaining))
                                   (cons (cons (car (res-clause-pos first)) (car acc))
                                         (cdr acc)));dodaje pozytywną zmienną do akumulatora
                     (iter-valuate (delete (car (res-clause-neg first)) (cdr remaining))
                                   (cons (car acc)
                                         (cons (car (res-clause-neg first)) (cdr acc)))))]
                [else (if (< 0 (length (res-clause-pos first)))
                          (iter-valuate (delete (car (res-clause-pos first)) remaining)
                                        (cons (cons (car (res-clause-pos first)) (car acc))
                                              (cdr acc)));tu też dodaje zmienną jako pozytywną
                          (iter-valuate (delete (car (res-clause-neg first)) remaining)
                                        (cons (car acc);tu dodaje zmienną do drugiej listy - jako negatywną
                                              (cons (car (res-clause-neg first)) (cdr acc)))))])))}

  (iter-valuate resolved (cons '() '())))   
          
          
           ;; Ta implementacja mówi tylko że formuła może być spełniona, ale nie mówi jak. Uzupełnij ją!

;; procedura przetwarzające wejściowy CNF na wewnętrzną reprezentację klauzul
(define (form->clauses f)
  (define (conv-clause c)
    (define (aux ls pos neg)
      (cond
       [(null? ls)
        (res-clause (remove-duplicates-vars (sort pos var<?))
                    (remove-duplicates-vars (sort neg var<?))
                    (proof-axiom c))]
       [(literal-pol (car ls))
        (aux (cdr ls)
             (cons (literal-var (car ls)) pos)
             neg)]
       [else
        (aux (cdr ls)
             pos
             (cons (literal-var (car ls)) neg))]))
    (aux (clause-lits c) null null))
  (map conv-clause (cnf-clauses f)))

(define (prove form)
  (let* ((clauses (form->clauses form)))
    (subsume-add-prove '() '() clauses)))

;; procedura testująca: próbuje dowieść sprzeczność formuły i sprawdza czy wygenerowany
;; dowód/waluacja są poprawne. Uwaga: żeby działała dla formuł spełnialnych trzeba umieć wygenerować
;; poprawną waluację.
(define (prove-and-check form)
  (let* ((res (prove form))
         (sat (car res))
         (pf-val (cadr res)))
    (if (eq? sat 'sat)
        (valuate-partial pf-val form)
        (check-proof pf-val form))))

;;; TODO: poniżej wpisz swoje testy

(define c1 (res-clause '(x) '(y) 'axiom))
(define c2 (res-clause '(a) '(x) 'axiom))
(define c3 (res-clause '(y) '(a) 'axiom))
#|subsumpcja chyba jest nie tylko optymalizacją, a raczej
jest konieczna dla własności stopu SAT-solvera. Na przykład klauzule c1, c2, c3 generują
(bez subsumpcji) klauzule odpowiednio ~c1, ~c2, ~c3. Te z kolei dodane do kolejki
pending znowu generują c1, c2, c3. Jeśli nie sprawdzimy, czy rezolwenta jest już w checked,
to ponownie dodamy te same klauzule (c1, c2, c3), które wywołają znowu ~c1, ~c2, ~c3 itd...|#
(define c4 (res-clause '(z u v w) '(x p r s) 'axiom))
(define c5 (res-clause '(a b c) '(d e f) 'axiom))
(define x1 (res-clause '(x) '() 'axiom))
(define x2 (res-clause '() '(x) 'axiom))
(resolve c1 c2)
(resolve-prove '() (list c1 c2 c3))
(resolve-prove '() (list c1 c2 c3 c4 c5))
(resolve-prove '() (list x1 x2))
