#lang racket
;Współpraca podczas robienia listy z Dominik Hawryluk
(require "calc.rkt")

(define (def-name p)
  (car p))

(define (def-prods p)
  (cdr p))

(define (rule-name r)
  (car r))

(define (rule-body r)
  (cdr r))

(define (lookup-def g nt)
  (cond [(null? g) (error "unknown non-terminal" g)]
        [(eq? (def-name (car g)) nt) (def-prods (car g))]
        [else (lookup-def (cdr g) nt)]))

(define parse-error 'PARSEERROR)

(define (parse-error? r) (eq? r 'PARSEERROR))

(define (res v r)
  (cons v r))

(define (res-val r)
  (car r))

(define (res-input r)
  (cdr r))

;;

(define (token? e)
  (and (list? e)
       (> (length e) 0)
       (eq? (car e) 'token)))

(define (token-args e)
  (cdr e))

(define (nt? e)
  (symbol? e))

;;

(define (parse g e i)
  (cond [(token? e) (match-token (token-args e) i)]
        [(nt? e) (parse-nt g (lookup-def g e) i)]))

(define (parse-nt g ps i)
  (if (null? ps)
      parse-error
      (let ([r (parse-many g (rule-body (car ps)) i)])
        (if (parse-error? r)
            (parse-nt g (cdr ps) i)
            (res (cons (rule-name (car ps)) (res-val r))
                 (res-input r))))))

(define (parse-many g es i)
  (if (null? es)
      (res null i)
      (let ([r (parse g (car es) i)])
        (if (parse-error? r)
            parse-error
            (let ([rs (parse-many g (cdr es) (res-input r))])
              (if (parse-error? rs)
                  parse-error
                  (res (cons (res-val r) (res-val rs))
                       (res-input rs))))))))

(define (match-token xs i)
  (if (and (not (null? i))
           (member (car i) xs))
      (res (car i) (cdr i))
      parse-error))

;;

(define num-grammar
  '([digit {DIG (token #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)}]
    [numb {MANY digit numb}
          {SINGLE digit}]))

(define (node-name t)
  (car t))

(define (c->int c)
  (- (char->integer c) (char->integer #\0)))

(define (walk-tree-acc t acc)
  (cond [(eq? (node-name t) 'MANY)
         (walk-tree-acc
          (third t)
          (+ (* 10 acc) (c->int (second (second t)))))]
        [(eq? (node-name t) 'SINGLE)
         (+ (* 10 acc) (c->int (second (second t))))]))

(define (walk-tree t)
  (walk-tree-acc t 0))

;;

(define arith-grammar
  (append num-grammar
     '([add-expr {ADD-MANY   mult-expr (token #\+) add-expr}
                 {SUB-MANY   mult-expr (token #\-) add-expr}
                 {ADD-SINGLE mult-expr}]
       [mult-expr {MULT-MANY base-expr (token #\*) mult-expr}
                  {DIV-MANY base-expr (token #\/) mult-expr}
                  {MULT-SINGLE base-expr}]
       [base-expr {BASE-NUM numb}
                  {PARENS (token #\() add-expr (token #\))}])))

(define (arith-walk-tree t)
  (cond [(eq? (node-name t) 'ADD-SINGLE)
         (arith-walk-tree (second t))]
        [(eq? (node-name t) 'ADD-MANY)
         (binop-cons
          '+
          (arith-walk-tree (second t))
          (arith-walk-tree (fourth t)))]
        [(eq? (node-name t) 'SUB-MANY)
         (binop-cons
          '-
          (arith-walk-tree (second t))
          (arith-walk-tree (fourth t)))]
        [(eq? (node-name t) 'MULT-SINGLE)
         (arith-walk-tree (second t))]
        [(eq? (node-name t) 'MULT-MANY)
         (binop-cons
          '*
          (arith-walk-tree (second t))
          (arith-walk-tree (fourth t)))]
        [(eq? (node-name t) 'DIV-MANY)
         (binop-cons
          '/
          (arith-walk-tree (second t))
          (arith-walk-tree (fourth t)))]
        [(eq? (node-name t) 'BASE-NUM)
         (walk-tree (second t))]
        [(eq? (node-name t) 'PARENS)
         (arith-walk-tree (third t))]))

(define (calc s)
 (eval
  (rotate (arith-walk-tree
           (car
            (parse
             arith-grammar
             'add-expr
             (string->list s)))))))

#|Zamiast męczyć się z wyginaniem drzewa na poziomie arith-walk-tree,
wyginam je dopiero po przejściu na drzewa wyrażeń racketowych, na których
łatwiej mi się operowało.
Rotacja polega na "wepchaniu" minusa do lewego poddrzewa i dopasowania argumentów|# 
(define (rotate t)
  (cond [(number? t) t]
        [(and (list? t);odejmowanie odwraca gdy w prawym poddrzewie jest + albo -
              (eq? (car t) '-)
              (or (and (list? (third t)) (eq? '+ (first (third t))))
                  (and (list? (third t)) (eq? '- (first (third t))))))
         (let ([leftexp  (second t)]
               [midexp   (second (third t))]
               [rightexp (third (third t))]
               [oper     (first (third t))])
           (rotate (binop-cons oper
                       (binop-cons '-
                                   (rotate leftexp)
                                   (rotate midexp))
                       (rotate rightexp))))]
        [(and (list? t);dzielenie odwraca gdy w prawym poddrzewie jest * albo /
              (eq? (car t) '/)
              (or (and (list? (third t)) (eq? '* (first (third t))))
                  (and (list? (third t)) (eq? '/ (first (third t))))))
         (let ([leftexp  (second t)]
               [midexp   (second (third t))]
               [rightexp (third (third t))]
               [oper     (first (third t))])
           (rotate (binop-cons oper
                       (binop-cons '/
                                   (rotate leftexp)
                                   (rotate midexp))
                       (rotate rightexp))))]
        [(binop? t) (binop-cons (first t)
                                (rotate (second t))
                                (rotate (third t)))]
        [else t]))

(define exp1 "5-2-1")
(define exp2 "1-2-3-4-5-6-7-8")
(define exp3 "8-4/2-1")

(rotate (arith-walk-tree (car (parse
   arith-grammar
   'add-expr
   (string->list exp1)))))

(calc exp1)
(calc exp2)
(calc exp3)