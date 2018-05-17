#lang racket

;cwiczenie 1
;(define (make-rat n d)
 ; (cons n (cons d null)))

(define (square x) (* x x))

(define (make-rat n d)
  (let ((c (gcd n d)))
    (list (/ n c) (/ d c))))

(define (rat-num q)
  (car q))

(define (rat-den q)
  (car (cdr q)))

(define (rat? q)
  (and (pair? (cdr q))
       (null? (cdr (cdr q)))
       (not (= (rat-num q) 0))
       (= 1 (gcd (rat-num q) (rat-den q)))))

;cwiczenie 2
(define (make-point x y) (cons x y))

(define (point-x p) (car p))

(define (point-y p) (cdr p))

(define (point? p) (pair? p))

(define (display-point p)
  (display "(")
  (display (point-x p))
  (display ", ")
  (display (point-y p))
  (display ")"))
;wektory:
(define (make-vect A B)
  (cons A B))

(define (vect-begin v) (car v))

(define (vect-end v) (cdr v))

(define (vect? v)
  (and (point? (car v))
       (point? (cdr v))))

(define (vect-length v)
  (sqrt (+ (square (- (point-x (vect-begin v))
                      (point-x (vect-end v))))
           (square (- (point-y (vect-begin v))
                      (point-y (vect-end v)))))))
; (vect-length (make-vect (make-point 4 3) (make-point 0 0)))
(define (vect-scale v k)
  (make-vect (vect-begin v)
             (make-point (+ (point-x (vect-begin v)) 
                            (* k
                               (- (point-x (vect-end v))
                                  (point-x (vect-begin v)))))
                         (+ (point-y (vect-begin v))
                            (* k
                               (- (point-y (vect-end v))
                                  (point-y (vect-begin v))))))))
;(display-vect (vect-scale (make-vect (make-point 1 1) (make-point 5 4)) 2))
(define (vect-translate v p)
  (make-vect p
             (make-point (+ (point-x p)
                            (- (point-x (vect-end v))
                               (point-x (vect-begin v))))
                         (+ (point-y p)
                            (- (point-y (vect-end v))
                               (point-y (vect-begin v)))))))
;(display-vect (vect-translate (make-vect (make-point 0 0) (make-point 4 3)) (make-point 5 0)))
 
(define (display-vect v)
  (display "[")
  (display-point (vect-begin v))
  (display ", ")
  (display-point (vect-end v))
  (display "]"))

;;zadanie 3
  
(define (make-alt-vect p alfa lenth)
  (if (and (point? p) (>= alfa 0) (< alfa 6.28318) (>= lenth 0))
      (cons p (cons alfa lenth))
      false))
 
(define (is-vector? v)
  (and (pair? v)
       (point? (car v)))
       (pair? (cdr v))
       (not (pair? (car (cdr v))))
       (not (pair? (cdr (cdr v)))))
 
(define (vect-alt-begin v)
  (if (is-vector? v)
      (car v)
      false))
 
(define (vect-alt-alfa v)
  (if (is-vector? v)
      (car (cdr v))
      false))
 
(define (vect-alt-lenth v)
  (if (is-vector? v)
      (cdr (cdr v))
      false))
 
(define (alt-scale v k)
  (if (is-vector? v) 
      (make-alt-vect (vect-alt-begin v)
                     (vect-alt-alfa v)
                     (* k (vect-alt-lenth v)))
      false))

(define (alt-trans v p)
  (if (and (is-vector? v) (point? p)) 
      (make-alt-vect (p)
                     (vect-alt-alfa v)
                     (vect-alt-lenth v))
      false))
 
;;latwe, ale trzebaby doklepac poczatek i koniec wektora, dlugosc, czy wektor, translacje i skalowanie... nużące, łatwe
 
;;zadanie 4
(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys)))) 
             
(define (reverse items)
  (if (null? items)
      null
      (append (reverse (cdr items)) (list (car items)))))
  
(define (reverse-iter l)
  (define (iter l acc)
    (if (null? l)
        acc
        (iter (cdr l) (cons (car l) acc))))
  (iter l null))

;;zadanie 5
(define (insert xs n) ;wstawia liczbe n w uporzadkowaną listę xs
  (if (or (null? xs) (> (car xs) n))
      (cons n xs)
      (cons (car xs) (insert (cdr xs) n))))
 
(define (ins-sort l)
  (if (null? l)
      null
      (insert (ins-sort (cdr l)) (car l))))

;;zadanie 6 liczenie wszystkich permutacji listy
(define (place x ys) ; place wstawia x w każde miejsce listy ys
  (if (null? ys)     ; 
      (list (list x))
      (cons (cons x ys) ;pierwsza permutacja (x przed listą ys)
            (map (λ (zs) (cons (car ys) zs))
                 (place x (cdr ys))))))

(define (concat xss);(concat '((1 2)(3 4)(5 6)))
  (if (null? xss);dla listy list zwraca ich konkatenację
      null
      (append (car xss) (concat (cdr xss)))))

(define (permi xs)
  (if (null? xs)         ;jeśli lista jest pusta to zwróć listę z listą pustą
      '(())
      (concat (map (λ (zs) (place (car xs) zs))
                   (permi (cdr xs))))))
              



