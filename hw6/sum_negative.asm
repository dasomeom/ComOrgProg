;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name: Dasom Eom
;;====================================

.orig x3000

  ;; YOUR CODE HERE :D

AND R3, R3, 0	 ; R3 = R3 AND 0 (Clean R3)
LD R0, ARRAY_ADDR; R0 <- mem[ARRAY]
LD R1, ARRAY_LEN ; R1 <- mem[LENGTH]
BRz SKIP	 ; If number is 0 or positive jump to SKIP, preparing ANSWER
LOOP	LDR R2, R0, 0	; R2 <- ARRAY_ADDR[K]
	BRn LA
	BRzp LB

LA	ADD R0, R0, 1	; R0 = R0 + 1	
	ADD R3, R3, R2	; K++
	ADD R1, R1, -1	; counter--
	BRp LOOP	; If counter <= 0 don't loop again

LB	ADD R0, R0, 1	; R0 = R0 + 1	
	ADD R1, R1, -1	; counter--
	BRp LOOP	; If counter <= 0 don't loop again
SKIP ST R3, ANSWER     ; mem[ANSWER] <- R3
HALT		; done

ARRAY_ADDR .fill x4000
ARRAY_LEN  .fill 10

ANSWER     .blkw 1

.end

.orig x4000
  .fill 7
  .fill -18
  .fill 0
  .fill 5
  .fill -9
  .fill 25
  .fill 1
  .fill -2
  .fill 10
  .fill -6
.end
