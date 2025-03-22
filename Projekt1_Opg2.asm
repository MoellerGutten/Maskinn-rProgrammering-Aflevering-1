        .ORIG x3000
        
readS   ST R1, ReadS_R1 ; callee save
        ST R2, ReadS_R2
        ST R3, ReadS_R3
        ST R4, ReadS_R4
        ST R5, ReadS_R5
        ST R6, ReadS_R6
        ST R7, ReadS_R7
        
        AND R0, R0, #0  ; clear all registers
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        AND R5, R5, #0
        AND R6, R6, #0
        AND R7, R7, #0

        LEA R0, PROMPT
        PUTS            ; display prompt

        GETC            ; get the first digit
        ADD R5, R0, #-10
        BRz ENTER       ; enter was pressed, skip other digits
        AND R5, R5, #0
        OUT
        LD R5, CONV
        ADD R4, R0, R5
        BRn INVALID     ; if ascii value is <48, invalid input
        AND R4, R4, #0
        ADD R5, R5, #-10
        ADD R4, R0, R5
        BRzp INVALID    ; if ascii value is >57, invalid input
        AND R4, R4, #0
        LD R5, CONV
        ADD R6, R6, #1  ; increment digit counter
        ADD R4, R0, #0
        ADD R4, R4, R5  ; store decimal digit in r4
        
        GETC            ; get the second digit
        ADD R5, R0, #-10
        BRz ENTER       ; enter was pressed, skip other digits
        AND R5, R5, #0
        OUT
        LD R5, CONV
        ADD R3, R0, R5
        BRn INVALID     ; if ascii value is <48, invalid input
        AND R3, R3, #0
        ADD R5, R5, #-10
        ADD R3, R0, R5
        BRzp INVALID    ; if ascii value is >57, invalid input
        AND R3, R3, #0
        LD R5, CONV
        ADD R6, R6, #1  ; increment digit counter
        ADD R3, R0, #0
        ADD R3, R3, R5  ; store decimal digit in r3
        
        GETC            ; get the third digit
        ADD R5, R0, #-10
        BRz ENTER       ; enter was pressed, skip other digits
        AND R5, R5, #0
        OUT
        LD R5, CONV
        ADD R2, R0, R5
        BRn INVALID     ; if ascii value is <48, invalid input
        AND R2, R2, #0
        ADD R5, R5, #-10
        ADD R2, R0, R5
        BRzp INVALID    ; if ascii value is >57, invalid input
        AND R2, R2, #0
        LD R5, CONV
        ADD R6, R6, #1  ; increment digit counter
        ADD R2, R0, #0
        ADD R2, R2, R5  ; store decimal digit in r2
        
        GETC            ; get the fourth digit
        ADD R5, R0, #-10
        BRz ENTER       ; enter was pressed, skip other digits
        AND R5, R5, #0
        OUT
        LD R5, CONV
        ADD R1, R0, R5
        BRn INVALID     ; if ascii value is <48, invalid input
        AND R1, R1, #0
        ADD R5, R5, #-10
        ADD R1, R0, R5
        BRzp INVALID    ; if ascii value is >57, invalid input
        AND R1, R1, #0
        LD R5, CONV
        ADD R6, R6, #1  ; increment digit counter
        ADD R1, R0, #0
        ADD R1, R1, R5  ; store decimal digit in r1
        
        GETC            ; get the fifth digit
        ADD R5, R0, #-10
        BRz ENTER       ; enter was pressed, skip other digits
        AND R5, R5, #0
        OUT
        LD R5, CONV
        ADD R7, R7, R0
        ADD R7, R0, R5
        BRn INVALID     ; if ascii value is <48, invalid input
        AND R7, R7, #0
        ADD R5, R5, #-10
        ADD R7, R0, R5
        BRzp INVALID    ; if ascii value is >57, invalid input
        AND R7, R7, #0
        LD R5, CONV
        ADD R6, R6, #1  ; increment digit counter
        ADD R0, R0, R5  ; store decimal digit in r0
        
ENTER   AND R7, R7, #0  ; continue after getting input
        AND R5, R5, #0
        ADD R5, R4, #-10
        BRz INVALID     ; first key pressed was ENTER
LOOP    ADD R6, R6, #-1
        BRn DONE
        LEA R5, ONE     ; load #1 into r5
        ADD R5, R5, R6  ; change r5 to the address of the multiplier for the current digit
        LDR R5, R5, #0  ; change r5 to the value of the multiplier for the current digit
        ADD R4, R4, #0
        BRz BR_MULT     ; if the digit is 0, skip multiplication
MULT    ADD R7, R7, R5  ; multiply
        ADD R4, R4, #-1
        BRp MULT
BR_MULT AND R4, R4, #0  ; shift all register values to the above register
        ADD R4, R4, R3
        AND R3, R3, #0
        ADD R3, R3, R2
        AND R2, R2, #0
        ADD R2, R2, R1
        AND R1, R1, #0
        ADD R1, R1, R0
        AND R0, R0, #0
        ADD R6, R6, #0
        BRp LOOP         ; if counter is still positive, repeat loop
        AND R0, R0, #0
        ADD R0, R0, R7
        BR  DONE

INVALID LEA R0, INV
        PUTS
        AND R0, R0, #0
        ADD R0, R0, #-1
        
        LD R1, ReadS_R1 ; Restore registerS
        LD R2, ReadS_R2
        LD R3, ReadS_R3
        LD R4, ReadS_R4
        LD R5, ReadS_R5
        LD R6, ReadS_R6
        LD R7, ReadS_R7
        
        RET

DONE    LD R1, ReadS_R1 ; Restore registerS
        LD R2, ReadS_R2
        LD R3, ReadS_R3
        LD R4, ReadS_R4
        LD R5, ReadS_R5
        LD R6, ReadS_R6
        LD R7, ReadS_R7
        
        RET

PROMPT  .STRINGZ    "Input a decimal number (max 5 digits): "
INV     .STRINGZ    "\nInvalid input!"

CONV    .FILL       #-48
ONE     .FILL       #1
TEN     .FILL       #10
HUNDR   .FILL       #100
THOUS   .FILL       #1000
TENTHOU .FILL       #10000

ReadS_R1    .BLKW 1 ; Space for registers
ReadS_R2    .BLKW 1
ReadS_R3    .BLKW 1
ReadS_R4    .BLKW 1
ReadS_R5    .BLKW 1
ReadS_R6    .BLKW 1
ReadS_R7    .BLKW 1

        .END