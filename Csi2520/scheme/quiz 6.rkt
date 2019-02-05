#lang scheme "quiz 6"

(define (duplicatePair list)
  (let dup ([acc '()]
            [curr (car list)]
            [rest (cdr list)])
    (cond
      [(null? rest) '()]
      [(not (member curr acc)) (cons (cons curr (numDuplicates curr list)) (dup (cons curr acc) (car rest) (cdr rest)))]
      [else (dup (cons curr acc) (car rest) (cdr rest))]))) 

(define (numDuplicates el list)
  (cond
    [(null? list) 0]
    [(equal? (car list) el) (+ 1 (numDuplicates el (cdr list)))]
    [else (+ 0 (numDuplicates el (cdr list)))]))


(duplicatePair '(1 a 5 6 2 b a 5 5))