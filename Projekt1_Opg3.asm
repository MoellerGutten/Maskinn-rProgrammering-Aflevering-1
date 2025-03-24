    .ORIG x3100
    
isPrime ST R1, isPrime_R1   ; Callee save
        ST R2, isPrime_R2
        ST R3, isPrime_R3
        ST R4, isPrime_R4
        
        AND R1, R1, #0      ; clear registers
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        
        ADD R4, R0, #-2     ; if number is 2, it's prime. this enables the subsequent optimization
        BRz YPrime
        AND R4, R4, #0
                        
        ADD R4, R4, x0001      ; bit mask for checking if R0 is even
        AND R4, R0, R4      ; And'ing bit mask
        BRz NPrime          ; If it is even, not a prime number (Purely optimization)
        
        ADD R1, R0, #0      ; Test number
        ADD R4, R1, #-1     ; If test number is 1, end (R4 is never used)
        BRz YPrime          ; If so end
        
LOOP    ADD R1, R1, #-1     ; Decrement test number
        ADD R4, R1, #-1     ; If test number is 1, end (R4 is never used)
        BRz YPrime

        NOT R1, R1          ; Negate test number:
        ADD R1, R1, #1
        
        ADD R2, R0, R1      ; Get result number
        BRz NPrime
        
SUB     ADD R2, R1, R2      ; If remainder is smaller than test number end, otherwise keep subtracting from input number
        BRz NPrime
        BRp SUB
        
        NOT R1, R1          ; Negate test number back to positive:
        ADD R1, R1, #1
        BRp LOOP        
    
    
NPrime  AND R0, R0, #0
        LD R1, isPrime_R1
        LD R2, isPrime_R2
        LD R3, isPrime_R3
        LD R4, isPrime_R4
        RET


YPrime  AND R0, R0, #0
        ADD R0, R0, #1
        LD R1, isPrime_R1
        LD R2, isPrime_R2
        LD R3, isPrime_R3
        LD R4, isPrime_R4
        RET

isPrime_R1  .BLKW 1 ; Space for registers
isPrime_R2  .BLKW 1
isPrime_R3  .BLKW 1
isPrime_R4  .BLKW 1

.END