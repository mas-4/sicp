(define size 2)
(define pi 3.14159)
(define radius 10)

(* pi (* radius radius))

(define circumference (* 2 pi radius))

(* (+ 2 (* 4 6)) (+ 3 5 7))

; the beginning of the programmatic definitions for chapter 1
(define (square x) (* x x))

; sum of squares (with a better name)
(define (sos x y)
  (+ (square x) (square y)))

(define (f a)
  (sos (+ a 1) (* a 2))
  )

; An initial case statement (switch) based absolute function
; (define (abs x)
;   (cond ((> x 0) x)
;         ((= x 0) 0)
;         ((< x 0) (- x))))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

; An initial version of >=; It seems that >= and <= are already defined.
; Nonetheless, I guess I'm overwriting them.
; (define (>= x y)
;   (or (> x y) (= x y))
;   )

(define (>= x y)
  (not (< x y)))

; my own personal test
(define ($ x y)
  (* x y))

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

; output should be 6 --> correct
(+ 2 (if (> b a) b a))

; output should be 16 --> correct
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
