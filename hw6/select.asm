;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name:Dasom Eom
;;====================================

.orig x3000

LD R7, ARRAY_LEN	; R3 is temporary value of LENGTH
ADD R5, R7, -1		; Check LENGTH is 1 or not, LENGTH - 1
BRz SKIP		; If LENGTH - 1 == 0 sorting is not needed
LD R6, ARRAY_ADDR 	; R6 is paramter Array

; 	Outer loop
LOOPI	ADD R5, R6, 1	; R5 <- R6 + 1 (j = i+1)
	ADD R4, R7, -1	; R4 <- length of j (i-1)
	LDR R0, R6, 0	; R0 <- mem[R6 + 0] will be used as a minimum
	NOT R0, R0	; Not R0
	ADD R0, R0, 1	; Add 1 to R0. with not R0, it changes the sign
	BPnzp LOOPII 

;	Inner loop
LOOPII	LDR R2, R5, 0 	; R2 <- mem[R5] (mem[j])
	ADD R3, R0, R2	; R3 <- R0 - R1 After checking arr[i]<arr[j]
	BRN CHANGE	; if R3 is negative, move to CHANGE
	BRZP NEXT	; if R3 is zero or positive, move to NEXT
	

CHANGE	ADD R0, R2, 0	; minvalue R0 <- R2
	NOT R0, R0	; Not R0
	ADD R0, R0, 1	; Add 1 to R0. with not R0, it changes the sign
	AND R1, R1, 0	;
	ADD R1, R5, 0	; Save R5 address in R1
	ADD R5, R5, 1	; mem[j++] pointer++
	ADD R4, R4, -1	; j--
	BRP LOOPII	;
	BRNZ LASTJ	; the end of j loop
	

NEXT	ADD R5, R5, 1 	; Array pointer++ R5 <- mem[R5 + 1]
	ADD R4, R4, -1	; j - 1
	BRNZ LASTJ	; the end of j loop
	BRP LOOPII	;

LASTJ	LDR R3, R6, 0 	; R3 <- mem[0]
	ADD R2, R3, R0	; check if mem[i] is the smallest
	BRZ LASTNO	; if so, go to LASTNO loop
	NOT R0, R0	; R0 = NOT R0
	ADD R0, R0, 1	; Reverse the sign of R0
	STR R0, R6, 0	; R6[0] <- R0
	STR R3, R1, 0	; R1 <- R0    	
	ADD R6, R6, 1	; outerloop counter++, i++
	ADD R7, R7, -1	; i--
	BRP LOOPI	; if R3 is positive, move to LOOPI
	BRZ SKIP	; if R3 is zero, move to SKIP

LASTNO	ADD R6, R6, 1	; outerloop counter++, i++
	ADD R7, R7, -1	; i--
	BRP LOOPI	; if R3 is positive, move to LOOPI
	BRZ SKIP	; if R3 is zero, move to SKIP
	


SKIP
HALT	; done
ADDRESS .fill 0
ARRAY_ADDR .fill x4000
ARRAY_LEN  .fill 2

.end

.orig x4000
  .fill 1
  .fill 2


.end
