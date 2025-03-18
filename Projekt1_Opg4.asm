        .ORIG x3200
        
resultS ADD R0, R0, #-1 ; Test if R0 == 1
        BRzp POS
        
ZERO    LEA R0, NOTPRIME
        PUTS
        RET
        
POS     LEA R0, YESPRIME
        PUTS
        RET
        
NOTPRIME .STRINGZ "\nThe number is not prime"
YESPRIME .STRINGZ "\nThe number is prime"
        .END