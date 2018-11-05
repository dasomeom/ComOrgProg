;;====================================
;; CS 2110 - Fall 2018
;; Homework 7
;; string_ops.asm
;;====================================
;; Name:Dasom Eom
;;====================================

; Little reminder from your pals: don't run this directly by pressing
; ``Run'' in complx, since (look below) there's nothing put at address
; x3000. Instead, load it and use ``Debug'' -> ``Simulate Subroutine
; Call'' and choose the ``strlen'' label.

.orig x4000
   .stringz "gnu/linux"
.end


.orig x3000

halt

strlen
    ADD R6, R6, -3   ;initialize space for everything
    STR R7, R6, 1    ;store RA
    STR R5, R6, 0    ;store old FP
    ADD R6, R6, -4   ;initialize space for registers
    ADD R5, R6, 3    ;place new FP
    STR R0, R6, 3    ;store R0 on the stack
    STR R1, R6, 2    ;store R1 on the stack
    STR R2, R6, 1    ;store R2 on the stack
    STR R3, R6, 0    ;store R3 on the stack

     
    NOT R3, R3
    ADD R3, R3, 1
    AND R1, R1, 0    ;reset R1 to 0, it'll be the length

LOOP
    LDR R0, R0, 0
    BRZ ENDSTRING    ;if char=0,end
    ADD R2, R0, R3 
    BRZ Summation
    BRNP NOSUM

Summation
    LDR R0, R6, 3    ;load add str
    ADD R0, R0, 1
    STR R0, R6, 3
    ADD R1, R1, 1
    BR LOOP

NOSUM
    LDR R0, R6, 3    ;load add str
    ADD R0, R0, 1
    STR R0, R6, 3
    BR LOOP

ENDSTRING
    STR R1, R5, 3    ;store strlen at the return value spot


TEARDOWN
    LDR R3, R6, 0   ;reload R3
    LDR R2, R6, 1   ;reload R2
    LDR R1, R6, 2   ;reload R1
    LDR R0, R6, 3   ;reload R0
    ADD R6, R6, 4   ;add the stack pointer
    LDR R5, R6, 0   ;reload old FP
    LDR R7, R6, 1   ;reload return address
    ADD R6, R6, 2   ;put the stack pointer at the rv
    RET


count_occurrence
    ADD R6, R6, -3   ;initialize space for everything
    STR R7, R6, 1    ;store RA
    STR R5, R6, 0    ;store old FP
    ADD R6, R6, -4   ;R6 moves one more bit upper
    STR R3, R6, 3    ;store R3 on the stack
    STR R0, R6, 2    ;store R0 on the stack
    LDR R3, R6, 8    ;R3 <- char address
    LDR R0, R6, 7    ;R0 <- char address
    STR R3, R6, 1    ;
    STR R0, R6, 0    ;

    JSR strlen

    LDR R3, R6, 0   ;
    ADD R6, R6, 5   ;
    LDR R5, R6, 0   ;reload old FP
    STR R3, R6, 2   ;
    LDR R3, R6, -1  ;
    LDR R0, R6, -2  ;
    LDR R7, R6, 1   ;reload return address
    ADD R6, R6, 2   ;put the stack pointer at the rv
    RET 
    

; Needed by Simulate Subroutine Call in complx

STACK .fill xF000
.end

; You should not have to LD from any label, take the
; address off the stack instead :)
