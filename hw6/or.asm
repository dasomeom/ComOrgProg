;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name:Dasom Eom
;;====================================

.orig x3000

  ;; YOUR CODE HERE :D

LD R0, A        ; R0 <- mem[A]
LD R1, B        ; R1 <- mem[B]
NOT R1, R1	; not R1
NOT R0, R0	; not R0
AND R0, R0, R1	; R0 = R0 AND R1
NOT R0, R0  ; not R0
ST R0, ANSWER   ; mem[ANSWER] <- R0
HALT

A      .fill x1010
B      .fill x0404

ANSWER .blkw 1

.end
