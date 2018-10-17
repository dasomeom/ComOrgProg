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

LOOP	LDR R2, R0, 0	; R2 <- ARRAY_ADDR[K]
	ADD R3, R3, R2	;
	ADD R0, R0, 1	;
	ADD R1, R1, -1	;
	BRz SKIP
	BRp LOOP


SKIP ST R3, ANSWER     ; mem[ANSWER] <- R3
HALT		; done

ARRAY_ADDR .fill x4000
ARRAY_LEN  .fill 12

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
  .fill 4
  .fill 3
.end

