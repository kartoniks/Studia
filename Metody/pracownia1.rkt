#lang racket
;;kod wzorowany na wykładzie

(define (dist x y)
  (abs (- x y)))

(define (cube x)
  (* x x x))

(define (cube-root x)

  (define (improve y)
    {/ (+ [/ x (* y y)] (* 2 y)) 3} )
  
  (define (good-enough? approx)
    (< (dist x (cube approx)) 0.0001))

  (define (iter approx)
    (cond
      [(good-enough? approx) approx]
      [else                  (iter (improve approx))]))
  
  (iter 1.0)
  )

(cube-root 27)
(cube-root -8)
(cube-root 0)
(cube-root 1000000)
(cube-root 123)
(cube (cube-root 123))
