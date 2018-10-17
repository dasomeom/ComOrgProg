
;;====================================================
;; CS 2110 - Fall 2018
;; Timed Lab 3
;; timedlab3.asm
;;====================================================
;; Name:Dasom Eom
;;====================================================

.orig x3000

LD R0, STR_ADDR
AND R2, R2, 0
ADD R2, R2, 15
ADD R2, R2, 15
ADD R2, R2, 15
ADD R2, R2, 15
ADD R2, R2, 4

ADD R3, R2, 0
ADD R3, R3, 15
ADD R3, R3, 11

AND R4, R4, 0
ADD R4, R4, 15
ADD R4, R4, 15
ADD R4, R4, 15
ADD R4, R4, 15
ADD R4, R4, 15
ADD R4, R4, 15
ADD R4, R4, 7

AND R5, R5, 0
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 15
ADD R5, R5, 2


LOOP
	LDR R1, R0, 0

	NOT R1, R1
	ADD R1, R1, 1
	ADD R6, R1, R2
	BRP NOCHANGE
	ADD R6, R1, R5
	BRN NOCHANGE
	ADD R6, R1, R3
	BRZP CHANGE 
	BR TEMP

TEMP
	ADD R6, R1, R4
	BRNZ CHANGE
	BRP NOCHANGE

CHANGE 
	AND R1, R1, 0
	ADD R1, R1, 15
	ADD R1, R1, 15
	ADD R1, R1, 2
	STR R1, R0, 0
	ADD R0, R0, 1
	LDR R6, R0, 0
	BRZ SKIP
	BR LOOP

NOCHANGE
	ADD R0, R0, 1
	LDR R6, R0, 0
	BRZ SKIP
	BR LOOP

SKIP HALT

STR_ADDR .fill x5000
.end

.orig x5000
  .stringz "asdfasdfasdf"
.end