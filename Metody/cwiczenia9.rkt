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
;;

(define (node l r)
  (list 'node l r))

(define (node? n)
  (tagged-tuple? 'node 3 n))

(define (node-left n)
  (second n))

(define (node-right n)
  (third n))

(define (leaf? n)
  (or (symbol? n)
      (number? n)
      (null? n)))

;;

(define (res v s)
  (cons v s))

(define (res-val r)
  (car r))

(define (res-state r)
  (cdr r))

;;

(define (rename t)
  (define (rename-st t i)
    (cond [(leaf? t) (res i (+ i 1))]
          [(node? t)
           (let* ([rl (rename-st (node-left t) i)]
                  [rr (rename-st (node-right t) (res-state rl))])
             (res (node (res-val rl) (res-val rr))
                  (res-state rr)))]))
  (res-val (rename-st t 0)))

;;

(define (st-app f x y)
  (lambda (i)
    (let* ([rx (x i)]
           [ry (y (res-state rx))])
      (res (f (res-val rx) (res-val ry))
           (res-state ry)))))

(define get-st
  (lambda (i)
    (res i i)))

(define (modify-st f)
  (lambda (i)
    (res null (f i))))
;;
(define (inc n)
  (+ n 1))

(define (rename2 t)
  (define (rename-st t)
    (cond [(leaf? t)
           (st-app (lambda (x y) x)
                         get-st
                         (modify-st inc))]
          [(node? t)
           (st-app node
                         (rename-st (node-left  t))
                         (rename-st (node-right t)))]))
  (res-val ((rename-st t) 0)))

;CWICZENIE 1: ST-APP DLA WIELU ARGUMENTOW
(define (multi-st-app f . args);przyjmuje dowolnie wiele zmiennych po f
  (define (helper xs i)
    (cond [(null? xs) null]
          [else (let ([result ((car xs) i)])
                  (cons result (helper (cdr xs) (res-state result))))]))
  (lambda (i)
    (let ([result (helper args i)])
      (res (apply f (map res-val result))
           (res-state (last result))))))

;CWICZENIE 2 GENERATOR LICZB PSEUDOLOSOWYCH
(define (rand max);zobacz, (rand 999999) jest obliczeniem, które przyjmuje stan 
  (lambda (i);i zwraca res, tak samo jak st-app
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      (res (modulo v max) v))))

(define (rand-rename t)
  (define (rename-st t)
    (cond [(leaf? t)
           (rand 10000000)]
          [(node? t)
           (st-app node
                         (rename-st (node-left  t))
                         (rename-st (node-right t)))]))
  (res-val ((rename-st t) 0)))
;JEZYK WHILE :D
;; WHILE
;;
; memory

(define empty-mem
  null)

(define (set-mem x v m)
  (cond [(null? m)
         (list (cons x v))]
        [(eq? x (caar m))
         (cons (cons x v) (cdr m))]
        [else
         (cons (car m) (set-mem x v (cdr m)))]))

(define (get-mem x m)
  (cond [(null? m) 0]
        [(eq? x (caar m)) (cdar m)]
        [else (get-mem x (cdr m))]))

; arith and bools

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= %))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op->proc op)
  (cond [(eq? op '%) modulo]
        [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]
        [(eq? op '=) =]
        [(eq? op '>) >]
        [(eq? op '>=) >=]
        [(eq? op '<)  <]
        [(eq? op '<=) <=]))

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(var? e) (get-mem e m)]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

;;
(define (assign? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (second t) ':=)))

(define (assign-var e)
  (first e))

(define (assign-expr e)
  (third e))

(define (if? t)
  (tagged-tuple? 'if 4 t))

(define (if-cond e)
  (second e))

(define (if-then e)
  (third e))

(define (if-else e)
  (fourth e))

(define (while? t)
  (tagged-tuple? 'while 3 t))

(define (while-cond t)
  (second t))

(define (while-expr t)
  (third t))

(define (block? t)
  (list? t))

;;

(define (eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          m)]
        [(if? e)
         (if (eval-arith (if-cond e) m)
             (eval (if-then e) m)
             (eval (if-else e) m))]
        [(while? e)
         (if (eval-arith (while-cond e) m)
             (eval e (eval (while-expr e) m))
             m)]
        [(++? e)
         (set-mem
          (++-var e)
          (+ (get-mem (++-var e) m) 1)
          m)]
        [(for? e);for jest ewaluowany jak zmieniony while
         (eval (list (for-assign e) (list 'while
                                          (for-cond e)
                                          (list (for-body e) (for-inc e))))
               m)]
        [(block? e)
         (if (null? e)
             m
             (eval (cdr e) (eval (car e) m)))]
        ))

(define (run e)
  (eval e empty-mem))

;;

(define fact10
  '( (i := 10)
     (r := 1)
     (while (> i 0)
       ( (r := (* i r))
         (i := (- i 1)) ))))

(define (computeFact10)
  (run fact10))

;CWICZENIE 3: liczenie fibonacciego i liczb pierwszych
(define fib10
  '( (n := 10)
     (f1 := 1)
     (f2 := 1)
     (while (> n 0)
       ( (temp := f2)
         (f2 := (+ f1 f2))
         (f1 := temp)
         (n := (- n 1))))))

(define (fib k);quasi-quote odcytowuje po przecinku
  `( (n := ,k)
     (f1 := 1)
     (f2 := 1)
     (while (> n 0)
       ( (temp := f2)
         (f2 := (+ f1 f2))
         (f1 := temp)
         (n := (- n 1))))))


(define (primesum n);liczy sumę n liczb pierwszych, też korzysta z quasi-quote
  `( (sum := 0)
     (n := ,n)
     (i := 2)
     (while (> n 0)
            ( (divs := 0)
              (j := 2)
              (while (<= (* j j) i)
                     ( (if (= (% i j) 0)
                           (divs := (+ divs 1))
                           ())
                       (if (> divs 0)
                           ()
                           ( (sum :=  (+ i sum))
                             (n := (- n 1))))
                       (i := (+ i 1))))))))
                    
;CWICZENIE 5: operator inkrementacji
(define (++? e)
  (and (list? e)
       (= 2 (length e))
       (symbol? (car e))
       (symbol? (cadr e))
       (or (eq? (car e) '++)
           (eq? (cadr e) '++))))

(define (++-var e)
  (if (eq? (car e) '++)
      (cadr e)
      (car e)))

;CWICZENIE 6: dodanie pętli for
(define (for? e)
  (tagged-tuple? 'for 5 e))
(define for-assign second)
(define for-cond third)
(define for-inc fourth)
(define for-body fifth)

;CWICZENIE 7: tłumaczenie programu z forami na program tylko z while
(define (translate e)
  (cond [(assign? e) e]
        [(if? e)
         (list 'if
               (translate (if-cond e))
               (translate (if-then e))
               (translate (if-else e)))]
        [(while? e)
         (list 'while
               (translate (while-cond e))
               (translate (while-expr e)))]
        [(++? e) e]
        [(for? e);for jest ewaluowany jak zmieniony while
         (list (for-assign e) (list 'while
                                    (for-cond e)
                                    (translate (list (for-body e) (for-inc e)))))]
        [(block? e)
         (map translate e)]
        ))
