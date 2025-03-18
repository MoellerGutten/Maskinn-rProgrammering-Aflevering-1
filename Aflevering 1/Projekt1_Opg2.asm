        .ORIG x3000
        
readS   ST R1, ReadS_R1 ; Calle save        
        ST R2, ReadS_R2        
        ST R3, ReadS_R3        
    
        
        
        AND R0, R0, #0
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        
        LEA R0, PROMPT ; Add pointer to string msg
        PUTS ; Displays prompt
        
        GETC
        OUT
        ADD R1, R0, #0 ; Move first ('x0') to R1
        
        GETC
        OUT
        ADD R2, R0, #0 ; Move second ('0x') to R2
        
        LEA R0, newLine
        PUTS
        
        ; Go from ASCII to decimal:
        LD R3, CONV
        ADD R1, R1, R3
        ADD R2, R2, R3
        
        ; *10 first digit since its the 10's 
        AND R3, R3, #0 ; Clear Counter
        ADD R3, R3, #10 ; Counter
        AND R0, R0, #0 ; Accumulator
        
LOOP    ADD R0, R0, R1 ; Multiplying loop
        ADD R3, R3, #-1
        BRnp LOOP
        
        ADD R0, R0, R2 ; Add second digit, the 1's
        
        ; Restore registers       
        LD R1, ReadS_R1        
        LD R2, ReadS_R2        
        LD R3, ReadS_R3  
        
        RET
        
        


PROMPT  .STRINGZ "Input a 2 digit decimal number: "
newLine .STRINGZ "\n"
CONV    .FILL #-48

ReadS_R0    .BLKW 1 ; Space for registers
ReadS_R1    .BLKW 1
ReadS_R2    .BLKW 1
ReadS_R3    .BLKW 1


        .END