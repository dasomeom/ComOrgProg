
;;====================================================
;; CS 2110 - Fall 2018
;; Timed Lab 4
;; converge.asm
;;====================================================
;; Name: Dasom
;;====================================================

.orig x3000

;; Don't try to run this code directly, since it only contains
;; subroutines that need to be invoked using the LC-3 calling
;; convention. Use Debug > Setup Test or Simulate Subroutine
;; Call in complx instead.
;;
;; Do not remove this line or you will break...
;; 'Simulate Subroutine Call'

halt

converge
    ADD R6, R6, -3   ;initialize space for everything
    STR R7, R6, 1    ;store RA
    STR R5, R6, 0    ;store old FP
    ADD R5, R6, -1 ;
    ADD R6, R6, -5 ;initialize space for registers
    STR R0, R6, 4 ;save R0
    STR R1, R6, 3 ;save R1
    STR R2, R6, 2 ;save R2
    STR R3, R6, 1 ;save R3
    STR R4, R6, 0 ;save R4
    LDR R3, R5, 4 ; n
    AND R1, R1, 0 ; 
    ADD R1, R1, -1; r1 -1
    ADD R1, R1, R3; check n == 0
    BRZ ZEROEND;

    ADD R6, R6, -2;
    STR R3, R6, 0 ;
    AND R1, R1, 0; 
    ADD R1, R1, 2 ;
    STR R1, R6, 1 ;
    LD R0, DIV_ADDR
    JSRR R0 ;

    AND R1, R1, 0 ; r1  = 0  moved
    ADD R1, R1, 1 ; r1 = 1   moved
    AND R4, R3, R1;          moved
    BRZ GOJSRRR   ;          moved
    BR GOCONVERGE ;          moved

GOJSRRR           ;          moved
    JSR converge  ;;;        Added
    LDR R2, R6, 0 ;
    ADD R6, R6, 3 ;;         Added
    ADD R3, R2, 1 ;
    STR R3, R5, 3 ;
    BR THEEND  

GOCONVERGE
    ADD R6, R6, -1;
    ADD R4, R3, R3;
    ADD R4, R4, R3;
    ADD R4, R4, 1 ;
    STR R4, R6, 0 ;
    JSR converge 
    LDR R2, R6, 0 ;
    ADD R6, R6, 1 ;
    ADD R3, R2, 1 ;
    STR R3, R5, 3 ;
    BR THEEND

ZEROEND
    AND R0, R0, 0;
    STR R0, R5, 3;
    BR THEEND
THEEND
    LDR R4, R5, -4 ;restore R4
    LDR R3, R5, -3 ;restore R3
    LDR R2, R5, -2 ;restore R2
    LDR R1, R5, -1 ;restore R1
    LDR R0, R5, -0 ;restore R0
    ADD R6, R5, 0 ;bring R6 back down to R5
    LDR R5, R6, 1 ;restore old frame pointer
    LDR R7, R6, 2 ;restore return address
    ADD R6, R6, 3 ;have R6 point to the return value
    RET


STACK    .fill xF000
DIV_ADDR .fill x6000 ;; Call the divide subroutine at
                     ;; this address!
.end


.orig x6000


divide  ;; DO NOT call JSR with this label! Use DIV_ADDR instead!
  .fill x1DBD
  .fill x7F81
  .fill x7B80
  .fill x1BBF
  .fill x1DBB
  .fill x7140
  .fill x737F
  .fill x757E
  .fill x777D
  .fill x797C
  .fill x6144
  .fill x6345
  .fill x54A0
  .fill x1620
  .fill x987F
  .fill x1921
  .fill x1903
  .fill x0805
  .fill x14A1
  .fill x987F
  .fill x1921
  .fill x16C4
  .fill x0FF7
  .fill x7543
  .fill x6140
  .fill x637F
  .fill x657E
  .fill x677D
  .fill x697C
  .fill x1D61
  .fill x6B80
  .fill x1DA1
  .fill x6F80
  .fill x1DA1
  .fill xC1C0
.end
