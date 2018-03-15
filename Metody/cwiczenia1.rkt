#lang racket

;;zad 4
(define (greatertwo x y z)
  (cond[(and (< x y) (< x z)) (sumsquares y z)]
       [(and (< y x) (< y z)) (sumsquares x z)]
       [else (sumsquares x y)]))

(define (sumsquares x y) (+ (* x x) (* y y)))



;; zad 8
(define (power-close-to b n)
  (define (iter guess b n)
    (if (> (expt b guess) n)
        guess
        (iter (+ guess 1) b n)
        )
    )

  (iter 0 b n)
  )