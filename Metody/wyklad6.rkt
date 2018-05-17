#lang racket

;; arithmetic expressions

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

(define (arith-expr? t)
  (or (const? t)
      (and (binop? t)
           (arith-expr? (binop-left  t))
           (arith-expr? (binop-right t)))))

;; calculator

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (eval-arith e)
  (cond [(const? e) e]
        [(binop? e)
         ((op->proc (binop-op e))
            (eval-arith (binop-left  e))
            (eval-arith (binop-right e)))]))

;; let expressions

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

(define (eval e)
  (cond [(const? e) e]
        [(binop? e)
         ((op->proc (binop-op e))
            (eval (binop-left  e))
            (eval (binop-right e)))]))

(eval '(+ 2 2))