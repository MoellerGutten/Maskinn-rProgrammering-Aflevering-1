        .ORIG x3000
        LD R0, A
        LD R1, B
        
X       NOT R2, R0 ; (a) Negating number
        ADD R2, R2, #1 ; (b) with 2s complement
        ADD R2, R2, R1 ; If diff is zero we're done
        BRz DONE ; (c) Branch to end
        
        ADD R1,R1, #-1 ; Otherwise decrement big num
        ADD R0, R0, #1 ; (d) And increment small num
        BRnzp X ; Loop
        
DONE    ST R1, C
        TRAP x25
        
        A .BLKW 1
        B .BLKW 1
        C .BLKW 1
        .END