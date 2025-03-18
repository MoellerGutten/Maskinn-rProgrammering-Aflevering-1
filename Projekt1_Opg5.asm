        .ORIG x3500
        AND R0, R0, #0
        AND R1, R1, #0
        AND R5, R5, #0
        
LOOP    LD R5, goReadS
        JSRR R5
        ADD R0, R0, #0
        BRn SKIP
        
        LD R5, goIsPrime
        JSRR R5
        
        LD R5, goResultS
        JSRR R5
        
SKIP    LEA R0, nLine
        PUTS
        AND R0, R0, #0
        
        BR LOOP
        
goReadS     .FILL x3000
goIsPrime   .FILL x3100
goResultS   .FILL x3200
nLine       .STRINGZ "\n"
        
        .END