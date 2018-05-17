#!/usr/bin/env racket
#lang racket

(define (var? t)
  (symbol? t))

(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq? 'neg (car t))))

(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'disj (car t))))

(define (prop? f)
  (or (var? f)
      (and (neg? f)
           (prop? (neg-subf f)))
      (and (disj? f)
           (prop? (disj-left f))
           (prop? (disj-rght f)))
      (and (conj? f)
           (prop? (conj-left f))
           (prop? (conj-rght f)))))

;;; Zadanie 1

(define (neg s)
  (list 'neg s))

(define (neg-subf t)
  (second t))

(define (conj sl sr)
  (list 'conj sl sr))

(define (conj-left t)
  (second t))

(define (conj-rght t)
  (third t))

(define (disj sl sr)
  (list 'disj sl sr))

(define (disj-left t)
  (second t))

(define (disj-rght t)
  (third t))

;;; Zadanie 2

(define (free-vars t)
  (define (aux t fv)
    (cond [(var? t) (cons t fv)]
          [(neg? t) (aux (neg-subf t) fv)]
          [(disj? t) (aux (disj-left t) (aux (disj-rght t) fv))]
          [(conj? t) (aux (conj-left t) (aux (conj-rght t) fv))]))
  (remove-duplicates (aux t null)))

;;; (displayln (free-vars (neg (conj 'a (disj 'a 'a)))))

(define (gen-vals xs)
  (if (null? xs)
      (list null)
      (let* ((vss (gen-vals (cdr xs)))
             (x (car xs))
             (vst (map (lambda (vs) (cons (list x true) vs)) vss))
             (vsf (map (lambda (vs) (cons (list x false) vs)) vss)))
        (append vst vsf))))

;;; Zadanie 3

(define (var-val v vals)
    (cond [(null? vals) (error "Undefined variable" v)]
          [(eq? v (caar vals)) (cadar vals)]
          [else (var-val v (cdr vals))]))

(define (eval-formula t vals)
  (cond [(var? t)  (var-val t vals)]
        [(neg? t)  (not (eval-formula (neg-subf t) vals))]
        [(disj? t) (or  (eval-formula (disj-left t) vals)
                        (eval-formula (disj-rght t) vals))]
        [(conj? t) (and (eval-formula (conj-left t) vals)
                        (eval-formula (conj-rght t) vals))]))

(define (falsifiable-eval? t)
  (define all-vals (gen-vals (free-vars t)))
  (define (aux t vals)
    (cond [(null? vals) #f]
          [(eq? #f (eval-formula t (car vals))) (car vals)]
          [else (aux t (cdr vals))]))
  (aux t all-vals))

;;; Zadanie 4

(define (lit? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'lit (first t))
       (or (eq? 'normal (second t))
           (eq? 'negatv (second t)))
       (var? (third t))))

(define (lit n v)
  (list 'lit
        (if n 'normal 'negatv)
        v))

(define (lit-neg? t)
  (eq? (second t) 'negatv))

(define (lit-subf t)
  (third t))

(define (lit-negate t)
  (lit (not (lit-neg? t)) (lit-subf t)))

(define (nnf? f)
  (or (var? f) 
    (and (neg? f) 
         (var? (neg-subf f)))
    (lit? f)
    (and (disj? f) 
         (nnf? (disj-left f))
         (nnf? (disj-rght f))) 
    (and (conj? f) 
         (nnf? (conj-left f))
         (nnf? (conj-rght f)))))


(define (free-vars-bis t)
  (define (aux t fv)
    (cond [(var? t) (cons t fv)]
          [(lit? t) (cons (lit-subf t) fv)]
          [(neg? t) (aux (neg-subf t) fv)]
          [(disj? t) (aux (disj-left t) (aux (disj-rght t) fv))]
          [(conj? t) (aux (conj-left t) (aux (conj-rght t) fv))]))
  (remove-duplicates (aux t null)))

(define (eval-formula-bis t vals)
  (cond [(var? t)  (var-val t vals)]
        [(lit? t)  ((if (lit-neg? t) not identity) (var-val (lit-subf t) vals))]
        [(neg? t)  (not (eval-formula-bis (neg-subf t) vals))]
        [(disj? t) (or  (eval-formula-bis (disj-left t) vals)
                        (eval-formula-bis (disj-rght t) vals))]
        [(conj? t) (and (eval-formula-bis (conj-left t) vals)
                        (eval-formula-bis (conj-rght t) vals))]))

(define (falsifiable-eval-bis? t)
  (define all-vals (gen-vals (free-vars-bis t)))
  (define (aux t vals)
    (cond [(null? vals) #f]
          [(eq? #f (eval-formula-bis t (car vals))) (car vals)]
          [else (aux t (cdr vals))]))
  (aux t all-vals))

;;; Zadanie 5

(define (convert-to-nnf f)
  (define (neg-formula f)
      (cond [(var? f) (lit #f f)]
            [(lit? f) (lit-negate f)]
            [(neg? f) (convert-to-nnf (neg-subf f))]
            [(disj? f) (conj (neg-formula (disj-left f))
                             (neg-formula (disj-rght f)))]
            [(conj? f) (disj (neg-formula (conj-left f))
                             (neg-formula (conj-rght f)))]))
  (cond [(var? f) (lit #t f)]
        [(lit? f) f]
        [(neg? f) (neg-formula (neg-subf f))]
        [(disj? f) (disj (convert-to-nnf (disj-left f))
                         (convert-to-nnf (disj-rght f)))]
        [(conj? f) (conj (convert-to-nnf (conj-left f))
                         (convert-to-nnf (conj-rght f)))]))

;;; (convert-to-nnf (neg (neg (disj (neg (conj 'a 'c)) (neg 'b)))))

;;; Zadanie 6

(define (cnf? l)
  (define (is-disj? l)
    (and (list? l)
         (<= 1 (length l))
         (eq? 'cnf-disj (car l))
         (andmap lit? (cdr l))))
  (and (list? l)
       (<= 1 (length l))
       (eq? 'cnf-conj (car l))
       (andmap is-disj? (cdr l))))

(define (lit->cnf l)
  (list 'cnf-conj (list 'cnf-disj l)))

(define (cnf-conj->cnf c1 c2)
  (append (list 'cnf-conj) (cdr c1) (cdr c2)))

(define (cnf-disj->cnf c1 c2)
  (define (mmerge xs)
    (append (list 'cnf-disj) (apply append xs)))
  (append (list 'cnf-conj) (map mmerge (cartesian-product (map cdr (cdr c1)) (map cdr (cdr c2))))))

(define (convert-to-cnf f)
  (cond [(lit? f) (lit->cnf f)]
        [(conj? f) 
          (let ((left (convert-to-cnf (conj-left f)))
                (rght (convert-to-cnf (conj-rght f))))
            (cnf-conj->cnf left rght))]
        [(disj? f) 
          (let ((left (convert-to-cnf (disj-left f)))
                (rght (convert-to-cnf (disj-rght f))))
            (cnf-disj->cnf left rght))]))

(define (display-cnf cs)
  (define (display-cnf-disj cs)
    (define (display-cnf-lit l)
      (format "~a~a" (if (lit-neg? l) "¬" "") (lit-subf l)))
    (string-join (map display-cnf-lit (cdr cs)) " | "
                 #:before-first "(" #:after-last ")"))
  (string-join (map display-cnf-disj (cdr cs)) " & "
               #:before-first "(" #:after-last ")"))

;;; (cnf? (list 'cnf-conj))
;;; (cnf? (list 'cnf-conj (list 'cnf-disj)))
;;; (cnf? (list 'cnf-conj (list 'cnf-disj (lit #t 'a) (lit #f 'a))))

(define first-expr
  (cnf-conj->cnf 
    (lit->cnf (lit #t 'a))
    (cnf-disj->cnf (lit->cnf (lit #t 'b)) 
                       (lit->cnf (lit #f 'c)))))

(define first-expr-nnf
  (conj (lit #t 'a) (disj (lit #t 'b) (lit #f 'c))))

(define secon-expr
  (cnf-conj->cnf 
    (lit->cnf (lit #t 'd))
    (cnf-disj->cnf (lit->cnf (lit #t 'e)) 
                       (lit->cnf (lit #f 'f)))))

(define secon-expr-nnf
  (conj (lit #t 'd) (disj (lit #t 'e) (lit #f 'f))))

(define my-expr 
  (cnf-disj->cnf first-expr secon-expr))

(define my-expr-nnf
  (disj first-expr-nnf secon-expr-nnf))

;;; (cnf? (convert-to-cnf my-expr-nnf))


(define (eval-cnf t vals)
  (define (eval-cnf-disj t)
    (define (eval-lit t)
      ((if (lit-neg? t) not identity) (var-val (lit-subf t) vals)))
    (ormap eval-lit (cdr t)))
  (andmap eval-cnf-disj (cdr t)))

(define (free-vars-cnf t)
  (remove-duplicates (apply append (map (lambda (t) (map (lambda (l) (lit-subf l)) (cdr t))) (cdr t)))))

(define (falsifiable-cnf? t)
  (define all-vals (gen-vals (free-vars-cnf t)))
  (define (aux t vals)
    (cond [(null? vals) #f]
          [(eq? #f (eval-cnf t (car vals))) (car vals)]
          [else (aux t (cdr vals))]))
  (aux t all-vals))

(sort (falsifiable-eval-bis? my-expr-nnf) string<? #:key (lambda (x) (symbol->string (car x))))
(sort (falsifiable-cnf? (convert-to-cnf my-expr-nnf)) string<? #:key (lambda (x) (symbol->string (car x))))
