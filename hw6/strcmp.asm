;;====================================
;; CS 2110 - Fall 2018
;; Homework 6
;;====================================
;; Name:Dasom Eom
;;====================================

.orig x3000

LD	R0, STR_ADDR_1; R0 has the address of STR_ADDR_1
LD	R1, STR_ADDR_2; R1 has the address of STR_ADDR_2
AND R4, R4, 0	; Clean R4

LOOPI	LDR R2, R0, 0	;
	BRZ AHA;
	LDR R3, R1, 0	;
	BRZ NEGA; 	
	ADD R0, R0, 1	;	
	ADD R1, R1, 1	;
	NOT R2, R2	;
	ADD R2, R2, 1	;
	ADD R2, R3, R2	;
	BRN NEGA	;
	BRZ LOOPI	;
	BRP POSI	; 

SUB	


AHA	LDR R3, R1, 0	;
	BRZ ZER; 	
	BRP POSI	;


NEGA	ADD R4, R4, 1;
	BR SKIP
ZER	AND R4, R4, 0;
	BR SKIP
POSI	ADD R4, R4, -1; 
	BR SKIP
SKIP
ST R4, ANSWER	;
HALT		 ;
STR_ADDR_1 .fill x4000
STR_ADDR_2 .fill x4050

ANSWER     .blkw 1

.end

.orig x4000
  .stringz "b"
.end

.orig x4050
  .stringz "a"
.end
