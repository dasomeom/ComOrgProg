;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name:Dasom Eom
;;====================================

.orig x3000

  ;; YOUR CODE HERE :D

LEA R0, A
LDI R2, A
AND R2, R0, R1
ST R2, A
HALT

A      .fill x6666


ANSWER .blkw 1

.end
