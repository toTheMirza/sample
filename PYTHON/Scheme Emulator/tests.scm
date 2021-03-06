;;; Test Cases for the Scheme Project 

;; To run all tests:
;;     python3 scheme_test.py tests.scm
;;


;; The following should work for the initial files.

3
; expect 3

-123
; expect -123

1.25
; expect 1.25

#t
; expect #t

#f
; expect #f

)
; expect Error

;; In the following sections, you should provide test cases, so that by 
;; running 
;;     python3 scheme_test.py tests.scm
;; you can test the portions of the project you've completed.  In fact, 
;; you might consider writing these tests BEFORE tackling the associated
;; problem!

; Problem 1  (the reader)
;   Initially, the project skeleton simply reads and prints the expressions
;   entered.  Later on, it starts evaluating them.  You may therefore need
;   to modify the tests you initially provide for this section when you get
;   to later sections.  For example, initially, entering the symbol x will
;   simply cause the evaluator to print "x" rather than attempting to evaluate
;   it (and getting an error).  Therefore, you may later have to modify
;   x to (e.g.) 'x

; YOUR TEST CASES HERE

'x
; expect x

'(1 2 3)
; expect (1 2 3)

(1 2 3)
; expect Error

'(1 2 3 . 4)
; expect (1 2 3 . 4)

; Problem A2 and B2 (symbol evaluation and simple defines)

; YOUR TEST CASES HERE

(define pi 3.1415926)
pi
; expect 3.1415926

(define pi2 (* 2 pi))
pi2
; expect 6.2831852



; Problem 3 (primitive function calls)

; YOUR TEST CASES HERE

(+ 2 3)
; expect 5

(+)
; expect 0

(list 1 2 3)
; expect (1 2 3)

(< 2 3)
; expect #t

(quotient 1)
; expect Error

; Problem A4, B4, A5, B5, and 6 (calls on user-defined functions)

; YOUR TEST CASES HERE

(define f (lambda (x) (* x 2)))
(define (g x) (* x 2))
(eqv? (f 2) (g 2))
; expect #t

(define h (lambda (x y . z) (* x 2)))
(h 2)
; expect Error

; Problem 7 (set!)

; YOUR TEST CASES HERE

(define q 4)
q
; expect 4
(set! q 5)
q
; expect 5
(set! qq 10)
; expect Error


; Problem A8 (if, and)

; YOUR TEST CASES HERE
(and (= 2 2) (> 2 1))
; expect #t
(and (< 2 2) (> 2 1))
; expect #f
(and (= 2 2) '(a b))
; expect (a b)
(and)
; expect #t

(if #t 'true (/ 1 0))
; expect true
(if #f 'true (/ 1 0))
; expect Error
(if #f 'true)
; expect Error

; Problem B8 (cond, or)

; YOUR TEST CASES HERE
(cond ((> 3 2) 'greater) ((< 3 2) 'less))
; expect greater
(cond ((> 3 3) 'greater) ((< 3 3) 'less) (else 'equal))
; expect equal
(cond ((if (< -2 -3) #f -3) => abs) (else #f))
; expect 3

; Problem 9 (let)

; YOUR TEST CASES HERE
(let ((x 2) (y 3)) (* x y))
; expect 6

(let ((x 2) (y 3)) (let ((x 7) (z (+ x y))) (* z x)))
; expect 35


; Extra Credit 1 (let*)

; YOUR TEST CASES HERE


; Extra Credit 2 (case)

; YOUR TEST CASES HERE


; Problem A10

;; The subsequence of list S for which F outputs a true value (i.e., one
;; other than #f), computed destructively
(define (filter! f s)
   ; *** YOUR CODE HERE ***
   (define (filt_help f s)
   		(cond ((null? s) s)
               ((null? (cdr s))
                  (if (f (car s)) s ()))
               (else
                  (cond ((f (car s))
                     (set-cdr! s (filt_help f (cdr s)))
                     s)
                  (else
                     (set! s (cdr s))
                     (filt_help f s))))))
   (filt_help f s)
)

(define (big x) (> x 5))

(define ints (list 1 10 3 8 4 7))
(define ints1 (cdr ints))

(define filtered-ints (filter! big ints))
filtered-ints
; expect (10 8 7)
(eq? filtered-ints ints1)
; expect #t


; Problem A11.

;; The number of ways to change TOTAL with DENOMS
;; At most MAX-COINS total coins can be used.
(define (count-change total denoms max-coins)
  ; *** YOUR CODE HERE ***
  (define (count-help htotal hdenoms hmax-coins)
      (cond
         ((<= hmax-coins 0) 0)
         ((eqv? htotal 0) 1)
         ((or (< htotal 0) (eqv? (length hdenoms) 0)) 0)
         (else
            (+ (count-help htotal (cdr hdenoms) hmax-coins) 
               (count-help (- htotal (car hdenoms)) hdenoms (- hmax-coins 1))))))
  (count-help total denoms max-coins)
)

(define us-coins '(50 25 10 5 1))
(count-change 20 us-coins 18)
; expect 8

; Problem B10

;; Reverse list L destructively, creating no new pairs.  May modify the 
;; cdrs of the items in list L.
(define (reverse! L)
   ; *** YOUR CODE HERE ***
   (define (rev S prev)
      (define x (cdr S))
      (set-cdr! S prev)
      (if (null? x) S (rev x S)))
   (rev L (list))
)

(define L (list 1 2 3 4))
(define LR (reverse! L))
LR
; expect (4 3 2 1)

(eq? L (list-tail LR 3))
; expect #t

; Problem B11

;; The number of ways to partition TOTAL, where 
;; each partition must be at most MAX-VALUE
(define (count-partitions total max-value)
  ; *** YOUR CODE HERE ***
  (define (countp-help htotal hmax-value)
   (cond
      ((or (< htotal 0) (<= hmax-value 0)) 0)
      ((eqv? htotal 0) 1)
      (else
         (+ (countp-help (- htotal hmax-value) hmax-value) 
            (countp-help htotal (- hmax-value 1))))))
  (countp-help total max-value)
)

(count-partitions 5 3)
; expect 5
; Note: The 5 partitions are [[3 2] [3 1 1] [2 2 1] [2 1 1 1] [1 1 1 1 1]]

; Problem 12

;; A list of all ways to partition TOTAL, where  each partition must 
;; be at most MAX-VALUE and there are at most MAX-PIECES partitions.
(define (list-partitions total max-pieces max-value)
  ; *** YOUR CODE HERE ***
  (define (list-h sofar htotal hmaxp hmaxv)
      (cond
         ((or (< htotal 0) (<= hmaxv 0)) (list))
         ((eqv? htotal 0) (list sofar))
         ((<= hmaxp 0) (list))
         (else
            (append (list-h (append sofar (list hmaxv)) (- htotal hmaxv) (- hmaxp 1) hmaxv)
                     (list-h sofar htotal hmaxp (- hmaxv 1) ) ) ) ) )

  (list-h (list) total max-pieces max-value)
)

(list-partitions 5 2 4)
; expect ((4 1) (3 2))
(list-partitions 7 3 5)
; expect ((5 2) (5 1 1) (4 3) (4 2 1) (3 3 1) (3 2 2))



