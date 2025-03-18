    .ORIG x3100
    
isPrime ST R0, isPrime_R0 ; Callee save        
        ST R1, isPrime_R1        
        ST R2, isPrime_R2        
        ST R3, isPrime_R3     
        
        AND R1, R1, #0 ; Clear
        AND R2, R2, #0 ; Clear
        AND R3, R3, #0 ; Clear
        AND R4, R4, #0 ; Clear
                        
    
        ADD R1, R0, #0; Test number
        ADD R4, R1, #-1 ; If test number is 1, end
        BRz YPrime ; If so end
        
LOOP    ADD R1, R1, #-1 ; Decrement test number
        ADD R4, R1, #-1 ; If test number is 1, end
        BRz YPrime 

        ; Negate test number:
        NOT R1, R1
        ADD R1, R1, #1
        
        ADD R2, R0, R1 ; Get result number
        BRz NPrime
        
SUB     ADD R2, R1, R2 ; If remainder is smaller than test number end, otherwise keep subtracting from input number
        BRz NPrime
        BRp SUB
        
        ; Negate test number back to positive:
        NOT R1, R1
        ADD R1, R1, #1
        BRp LOOP        
    
    
NPrime  AND R0, R0, #0
        RET


YPrime  AND R0, R0, #0
        ADD R0, R0, #1
        RET


isPrime_R0    .BLKW 1 ; Space for registers
isPrime_R1    .BLKW 1
isPrime_R2    .BLKW 1
isPrime_R3    .BLKW 1
    .END