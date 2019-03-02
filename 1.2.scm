; 1.2.1 Linear Recursion and Iteration
; n! = n*(n-1)*(n-2)*...*3*2*1


; linearly recursive process factorial definition
(define (fact n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; iterative process factorial definition
(define (fact2 n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter  (* counter product)
                  (+ counter 1)
                  max-count)))

; encapsulated iterative factorial definition
(define (fact3 n)
  (define  (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))
  (fact-iter 1 1 n))

; recursive procedure is a procedure (method, function, etc [parens mine])
; defined with a call to itself.
; recursive process is a process that uses deferred operations as defined above
; in (fact n)
;
; This is fascinating:
;
; > As a consequence, these languages can describe iterative processes only by
; > resorting to special-purpose “looping constructs” such as do, repeat, until,
; > for, and while. The implementation of Scheme we shall consider in Chapter 5
; > does not share this defect. It will execute an iterative process in constant
; > space, even if the iterative process is described by a recursive procedure.
; > An implementation with this property is called tail-recursive. With a
; > tail-recursive implementation, iteration can be expressed using the ordinary
; > procedure call mechanism, so that special iteration constructs are useful
; > only as syntactic sugar.

; Exercise 1.9

; Based on
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(+ 4 5)
(inc (+ (dec 4) 5))
(inc (inc (+ (dec (dec 4)) 5)))
(inc (inc (inc (+ (dec (dec (dec 4))) 5))))
(inc (inc (inc (inc (dec (dec (dec (dec 4)))) 5))))
(inc (inc (inc (dec (dec (dec 3))) 6)))
(inc (inc (dec (dec 2)) 7))
(inc (dec 1) 8)
9
; I'm pretty sure that's recursive. The way I substituted was wrong, but I was
; right about it being recursive:
 (

+ 4 5)
 (inc (+ (dec 4) 5))
 (inc (+ 3 5))
 (inc (inc (+ (dec 3) 5)))
 (inc (inc (+ 2 5)))
 (inc (inc (inc (+ (dec 2) 5))))
 (inc (inc (inc (+ 1 5))))
 (inc (inc (inc (inc (+ (dec 1) 5)))))
 (inc (inc (inc (inc (+ 0 5)))))
 (inc (inc (inc (inc 5))))
 (inc (inc (inc 6)))
 (inc (inc 7))
 (inc 8)

 9


(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

(+ 4 5)

(+ (dec 4) (inc 5))
(+ (dec 3) (inc 6))
(+ (dec 2) (inc 7))
(+ (dec 1) (inc 8))
9
; I was sure that this was iterative and I was right:


 (+ 4 5)
 (+ (dec 4) (inc 5))
 (+ 3 6)
 (+ (dec 3) (inc 6))
 (+ 2 7)
 (+ (dec 2) (inc 7))
 (+ 1 8)
 (+ (dec 1) (inc 8))
 (+ 0 9)

 9

;> The easiest way to spot that the first process is recursive (without writing
;> out the substitution) is to note that the "+" procedure calls itself at the
;> end while nested in another expression; the second calls itself, but as the
;> top expression.


; Exercise 1.10

; Ackermann's function
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 256))
(A 0 512)
1024

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
; Screw this. I get it.
 (A 1 (A 0 (A 0 4)))
 (A 1 (A 0 8))
 (A 1 16)
 (A 0 (A 1 15))
 (A 0 (A 0 (A 1 14)))
 (A 0 (A 0 (A 0 (A 1 13))))
 (A 0 (A 0 (A 0 (A 0 (A 1 12)))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
 (A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
 (A 0 (A 0 (A 0 (A 0 4096))))
 (A 0 (A 0 (A 0 8192)))
 (A 0 (A 0 16384))
 (A 0 32768)
 65536

; Ackermann's function
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 3 3)

(A 2 (A 3 2))
(A 2 (A 2 (A 3 1))) (A 2 (A 2 2)) (A 2 (A 1 (A 2 1))) (A 2 (A 1 2))
; The answer is 65536. Screw it.
(define (f n) (A 0 n)) ; (* 2 n)
(define (g n) (A 1 n)) ; (^ 2 n) where ^ is exponent
(define (h n) (A 2 n)) ; I'm not quite sure what this is, but it is exponential.
; No, it's much faster than exponential. Ah, according to the answers its
; 2^2^...(n-1 times)
(define (k n) (* 5 n n)) ; 5n^2 (provided by sicp)

;          |0                     if n = 0,
; Fib(n) = |1                     if n = 1,
;          |Fib(n-1)+Fib(n-2)     otherwise.

; Tree recursive fibonacci function
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
;More precisely (see Exercise 1.13), Fib(n) is the closest integer to φ n / 5 ,
;where
;    φ = (1 + sqrt(5)) / 2 ≈ 1.6180
;is the golden ratio, which satisfies the equation
;    φ^2 = φ + 1.

(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0)
             (= kinds-of-coins 0))
         0)
        (else
          (+ (cc amount (- kinds-of-coins 1))
             (cc (- amount (first-denomination
                             kinds-of-coins))
                 kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

; This method is rather clever. I could encapsulate it, but there's no need.
; It's an impressive bit of deductive reasoning. I love recursion in cases like
; this. I am reminded of muuh-gnu's comment in r/lisp: "When you go with scheme,
; you will get recursion pushed on you like a political ideology whether you
; want it or not. Many iteration constructs are unavailable solely to make you
; get more familiar with recursion. Also other concepts (like continuations,
; hygienic macros, shared namespace) seem to be pushed more to force some user
; adoption, than because they are really useful. There is a much greater (and
; annoying) emphasis on code to be ideologically "clean" than useful and
; practical. A book like "Practical Scheme" (the equivalent of Practical Common
; Lisp) will never be written because it is essentially an oxymoron."
;
; To quote the text:
; "Count-change generates a tree-recursive process with redundancies similar to
; those in our first implementation of fib. (It will take quite a while for that
; 292 to be computed.) On the other hand, it is not obvious how to design a
; better algorithm for computing the result, and we leave this problem as a
; challenge. The observation that a tree-recursive process may be highly
; inefficient but often easy to specify and understand has led people to propose
; that one could get the best of both worlds by designing a “smart compiler”
; that could transform tree-recursive procedures into more efficient procedures
; that compute the same result."
;
; It's nice to live in 2019. 292 was calculated immediately. Let's see higher
; values. Slight pause on 500. 1000 takes a bit. Like 5-8 seconds. THe time it
; took me to <C-k>i and type the sentence "1000 takes a bit."

;;;;;;;;;;;;;;;;;;;;
; Exercise 1.11
;;;;;;;;;;;;;;;;;;;
; f(n) = n if n < 3
; and
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3

(define (f n)
  (if (< n 3)
      n
      (+
        (f (- n 1))
        (* 2
           (f (- n 2)))
        (* 3
           (f (- n 3))))))
; (f 4) is immediate. (f 234) doesn't seem to return.


; f(n) | n                                  if n <  3
;      | f(n-1) + 2f(n-2) + 3f(n-3)         if n >= 3

;Solution 1 (from wizardbook.wordpress.com):
(define (f-iter a b c count)
  (if (zero? count)
      c
      (f-iter b
              c
              (+ c (* 2 b) (* 3 a))
              (dec count))))

(define (f n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))

(f 2)
(iter 0 1 2 2)
(iter 1 2 (+ 2 (* 2 1) (* 3 0)) (- 2 1))
(iter 1 2 (+ 2 2 0) 1)
(iter 1 2 4 1)
(iter 2 4 (+ 4 (* 2 2) (* 3 2) (- 1 1)))
(iter 2 4 (+ 4 4 6) 0)
(iter 2 4 14 0)
2

; Oh holy crap. Duh. I'm thinking of (n-1), (n-2), and (n-3) as operations
; instead of the preceding values.
; f(n) | n                                  if n <  3
;      | f(n-1) + 2f(n-2) + 3f(n-3)         if n >= 3

(define (f n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))
; Conceptually I am having a little bit of trouble with this. But I'm thinking
; it is like this:
; a = (n - 3)
; b = (n - 2)
; c = (n - 1)
; count = n
; To get to n, we initially define (n - 1), (n - 2), and (n - 3) as though n
; were 2, since all n < 3 are simply n (so the sequence n < 3 is `0, 1, 2`).
; Since n is simply n-1 to n+1, we can ladder our sequence up *to* n by
; counting. This was throwing me for a loop initially. We always define the next
; a in terms of f(n) for n >= 3. When count is 0, a is n, b is (n+1), and c is
; (n+2).

;;;;;;;;;;;;;;;;
; Exercise 1.12
;;;;;;;;;;;;;;;;
; No friggin' clue.
; Damn, the first solution is eminently simple and I should have thought about
; it. I think the biggest problem I had in thinking of the solution as I thought
; the point of the exercise was to compute every element in a row with one
; method. Duh, no.

(define (pascal r c)
  (if (or (= c 1) (= c r))
      1
      (+ (pascal (- r 1) (- c 1)) (pascal (- r 1) c))))

; Modified to error-catch
(define (pascal r c)
  (cond ((or (= c 1) (= c r)) 1)
        ((> c r) -1)
        ((< c 1) -1)
        (else (+ (pascal (- r 1) (- c 1)) (pascal (- r 1) c)))))

; I haven't written a proof in years, there is no way I'm going to try this.
; I went back to wizardbook.wordpress.com and noticed the tagline:
; "Is this a cdadr which I see before me?"
; I know cdadr is some kind of complex recursive scheme function related to car
; and cdr but, while I don't understand what it does yet, that is hilarious:
; One of the greatest Macbeth sequences (which I should really put an effort to
; memorizing):
;
; Is this a dagger which I see before me,
; The handle toward my hand? Come, let me clutch thee.
; I have thee not, and yet I see thee still.
; Art thou not, fatal vision, sensible
; To feeling as to sight? or art thou but
; A dagger of the mind, a false creation,
; Proceeding from the heat-oppressed brain?
; I see thee yet, in form as palpable
; As this which now I draw.
; Thou marshall'st me the way that I was going;
; And such an instrument I was to use.
; Mine eyes are made the fools o' the other senses,
; Or else worth all the rest; I see thee still,
; And on thy blade and dudgeon gouts of blood,
; Which was not so before. There's no such thing:
; It is the bloody business which informs
; Thus to mine eyes. Now o'er the one halfworld
; Nature seems dead, and wicked dreams abuse
; The curtain'd sleep; witchcraft celebrates
; Pale Hecate's offerings, and wither'd murder,
; Alarum'd by his sentinel, the wolf,
; Whose howl's his watch, thus with his stealthy pace.
; With Tarquin's ravishing strides, towards his design
; Moves like a ghost. Thou sure and firm-set earth,
; Hear not my steps, which way they walk, for fear
; Thy very stones prate of my whereabout,
; And take the present horror from the time,
; Which now suits with it. Whiles I threat, he lives:
; Words to the heat of deeds too cold breath gives.

; I am starting §1.2.3 Orders of Growth but I'd rather work on my webapp.
