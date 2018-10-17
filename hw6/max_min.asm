;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name: Dasom Eom
;;====================================

.orig x3000

LD R7, HEAD_ADDR	; LOADING ARRAY
LDR R1, R7, 1
ADD R6, R1, 0
ADD R5, R1, 0
LDR R0, R7, 0
ADD R7, R0, 0
BRZ LNULL	

LOOP	LDR R1, R7, 1
	NOT R2, R1	; R2 <- !R1
	ADD R2, R2, 1	; reversing sign of R1 in R2
	ADD R3, R5, R2	; R2 <- R5 + R2
	BRP LOOPN	;
	ADD R3, R6, R2	;
	BRN LOOPP	;
	LDR R0, R7, 0
	ADD R7, R0, 0	; R7 <- HEAD_ADDR[R0]
	BRNP LOOP	;
	BRZ SKIP

LOOPN	ADD R5, R1, 0	;
	LDR R0, R7, 0
	ADD R7, R0, 0	; R7 <- HEAD_ADDR[R0]
	BRNP LOOP	;
	BRZ SKIP

LOOPP	ADD R6, R1, 0	;
	LDR R0, R7, 0
	ADD R7, R0, 0	; R7 <- HEAD_ADDR[R0]
	BRNP LOOP	;
	BRZ SKIP

LNULL	ADD R6, R1, 0	; R6 <- 0
	ADD R5, R1, 0	;

SKIP	ST R5, ANSWER_MIN  ; mem[MIN_INT] <- R6
	ST R6, ANSWER_MAX  ; mem[MAX_INT] <- R5
		
HALT			;


HEAD_ADDR  .fill x4000

MAX_INT    .fill x7FFF
MIN_INT    .fill x8000

ANSWER_MAX .blkw 1
ANSWER_MIN .blkw 1

.end

.orig x4000
  .fill x000
  .fill 1
.end

