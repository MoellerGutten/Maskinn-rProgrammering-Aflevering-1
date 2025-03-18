        .ORIG x3200
        
resultS ADD R0, R0, #-1 ; Test if R0 == 1
        BRzp POS
        
ZERO    LEA R0, NOTPRIME
        PUTS
        RET
        
POS     LEA R0, YESPRIME
        PUTS
        RET
        
NOTPRIME .STRINGZ "The number is not prime"
YESPRIME .STRINGZ "The number is prime"
        .END