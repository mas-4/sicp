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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.1
(define a 3)
(define b (+ a 1))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.2 Answer: -37/150
(/ (+ 5 4
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* 3
      (- 6 2)
      (- 2 7)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.3
(define (sq x) (* x x))
(define (sos x y) (+ (sq x) (sq y)))

(define (sols x y z)
  (cond
    ((and (>= x z) (>= y z)) (sos x y))
    ((and (>= x y) (>= z y)) (sos x z))
    ((and (>= y x) (>= z x)) (sos y z))
        )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.4
; This function takes two arguments, a and b. If b is greater than 0, it adds a
; and b. If b is less then 0, it subtracts b from a. Essentially, this is
; equivalent to a plus the absolute value of b. This function is cool as hell. I
; think I get why lisp is so amazing now. Probably not.

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

; Under normal-order evaluation, the expansion of (p) would not occur until
; after the conditional were evaluated to be false. Under applicative-order, the
; operations are evaluated eagerly, that is, from the inside out, that is, all
; of the sub expressions are evaluated first. This should cause an error, I
; would think.
; It paused the program. p is undefined. Oh, no, p is an infinite loop. It is
; recursive.
; This was mostly difficult only because SICP didn't formally explain any of
; this stuff very well. I guess I just had trouble following it. The concepts in
; this book are not overly difficult. The difficulty lies in the way they
; explain it for an audience of eggheads in the 1980's who don't have a lot of
; experience at the keyboard.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section 1.1.7

; sqrt(x) = the y such that y >= 0 and y^2 = x.

; (define (sqrt x)
;   (the y (and (>= y 0)
;               (= (square y) x))))

(define (square x) (* x x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; I am not sure about scheme procedure overwriting. Since I might just be
; accessing the prebuilt sqrt, I'll define usqrt for user sqrt.
(define (usqrt x)
  (sqrt-iter 1.0 x))

; The difference between sqrt and usqrt is definitely minimal; that is to say,
; it is > 0.001 difference, as defined. Of course, we still get decimal
; expansion for perfect squares, which is unfortunate. Clearly a poorly defined
; function.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.6

; I don't like dashes.
(define (newif predicate
               thenclause
               elseclause)
  (cond (predicate thenclause)
        (else elseclause)))


(define (sqrt-iter guess x)
  (newif (good-enough? guess x)
         guess
         (sqrt-iter (improve guess x) x)))

; Interesting. Infinite loop. Why.
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; Okay, so we have this thing never evaluating to true. Why?
; It seems like
; Okay, I actually looked it up. It has to do with the applicative-order
; evaluation. Normal if statement is a special case. In this new-if the builtin
; normal order evaluation for special case if statement doesn't apply. So the
; new sqrt-iter evaluates the suboperations before the newif statement (which is
; compound), resulting in a re-evaluation of the next iteration of sqrt-iter, ad
; infinitum.
; This makes me think this version of scheme is really badly implemented. I
; absolutely do not like that it is applicative-order. I am used to
; short-circuit evaluation and lazy evaluation.

; I swear, vim is getting slow with some of these plugins. I'm going to have to
; delete some of these.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.7
; Because of the limited precision of usqrt (namely, a precision of < 0.001), we
; run into a problem with small numbers, especially those closer and closer (and
; less than), our precision level. (I'm going to get rid of this stupid paredit
; plugin that is driving me crazy). On the other hand, with extremely large
; numbers, the inaccurate precision typically means we never get to within the
; margin to break the iteration.


(define (good-enough? guess x)
  (< (abs (- guess (improve guess x))) (* guess 0.001)))

(define (sqrt-iter guess oldguess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (usqrt x)
  (sqrt-iter 1.0 2.0 x))

; I'm getting this from community.schemewiki.org. I tried implementing something
; but had trouble. I should have retained it. It might have worked. Except I
; didn't think to recalculate the (improve) value inside (good-enough?). That
; made it a lot easier. And (improve) is cheap.
; This new method is pretty darn accurate for small numbers (it's how I would
; have thought to implement the algorithm in the first place). It seems even
; more *inaccurate* for the large numbers, though. Oh, wait, I didn't even get
; an answer from the big numbers, so, anyway, it's pretty inaccurate for big
; numbers.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.8
; Ah, Newton's method for cube roots.
; x / y^2 + 2y
; ------------
;      3

; y is current guess, y2 is oldguess
(define (cbrt-iter guess oldguess x)
  (if (good-enough? guess oldguess x)
      guess
      (cbrt-iter (improve guess x) guess x)))

; We don't need a new good-enough. We didn't even need a new cbrt

(define (good-enough? guess oldguess x)
  (< (abs (- guess (improve guess x))) (* guess 0.001)))

(define (improve y x)
  (/ (+
       (/ x (square y))
       (* 2 y))
     3))

(define (cbrt x) (cbrt-iter 1.0 2.0 x))

; Well that didn't work. Interesting. I'm unsure why my improve didn't work
; instead of using this averaging method:

(define (improve guess x)
  (average3 (/ x (square guess)) guess guess))

(define (average3 x y z)
  (/ (+ x y z) 3))

; That's much cleaner than my improve, but where did I go wrong?
; found it: I had a bug in good-enough. I was missing a value. I rewrote them to
; not use y and just use guess and oldguess, which makes more sense. Mine works
; just fine. The method of using a new average was cleaner, though.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section 1.1.8
; Interestingly, they're teaching the decomposition strategy. I learned that
; years ago. It's basic programming 101.
; Fascinating, he's talking about scope. Like, my immediate reaction to this is,
; "These eggheads don't know about scope?" where my next reaction is "Oh, this
; is programming 101, the first some of these people in 1986 ever touched a real
; computer before.
; I'm going to test something.

(define (>= x y) 0)

; Yup. You overwrite the builtin pretty quickly. Not that that's not the case in
; every other damn language.

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/x guess)))

; These 4 definitions needlessly pollute the namespace.

(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

; Clean. I mean, it's an eyeful. There's not much whitespace in this language.
; That makes it look cluttered. But there is something clean about it.
; Now this next redefinition I dislike.

(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

; I guess because I am a Pythonista and
;
; > Explicit is better than implicit.
;
; I pulled that in from `:r!pyton -m this`. That felt awesome.
; But I guess I can see how this is *slightly* cleaner than before, when we had
; the smattering of x's scattered everywhere. Now, the x's are bound to the
; local scope of the larger definition. The internal functions are not reusable,
; but need they be? The whole point of this is that they need not be.
; Oh. Fascinating note:
; > Embedded definitions must come first in a procedure body. The management is
; > not responsible for the consequences of running programs that intertwine
; > definition and use.
; I want to try that and see what happens now!
; Not tonight.
; Python can do it. I've never bothered. I need to start getting more functional
; with my programming. My scripts are just procedural as all hell.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Well, that's the end of 1.1. Wow is this book long. I'm not going to move on
; tonight. I want to watch the next lecture or two.
; Oh. Reading some footnotes I see why they write 1.0. I'm used to a language
; converting my integers implicitly to floating point (or double point?). But
; now I see that that is *not* the case with this language. I need to explicitly
; add the .0 to have the proper decimal expansion.


; This book is very, *very* rigorous in the computer science discipline. I feel
; like I will have a much better grasp on recursion after I read it and work
; through it. I also love the idea of writing a DSL. Recursion is fascinating,
; but always scary difficult. One's mind does not naturally deal in recursion,
; which is funny, if Douglas Hofstadter is right.
; I wonder why he never discussed programmatic recursion in his books. It's such
; an obvious example.
; Did he? I should have read them. Now I'm too old for them.
