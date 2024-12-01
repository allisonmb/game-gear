.org %0

;Load the address $9020 into the IX register - one of the two index registers
LD IX, 9020h

;Store 0x53 at $9020 and increment IX - will be incrementing IX every time value is stored to memory
LD (IX+0), 53h
INC IX

;Add 0x15 to 0x30 and store at $9021
;The A reg is the default accumulator register which is used to store the result of most of the arithmetic instructions
LD A, 15h
ADD A, 30h
LD (IX+0), A
INC IX

;Subtract 0x3 from 0x50 and store at $9022
LD A, 50h
SUB 9h
LD (IX+0), A
INC IX


;OR 0x40 with 0x01 and store at $9023
LD A, 40h
OR 1h
LD (IX+0), A
INC IX

;exhange the AF and AF' registers to store 0x41 for later use
EX AF, AF'

;AND 0xEC with 0x20 and store at $9024
LD A, ECh
AND 20h
LD (IX+0), A
INC IX

;XOR 0x41 with 0x6 and store at $9025 - retrieve 0x41 from the A' register 
EX AF, AF'
XOR 6h
LD (IX+0), A
INC IX

;Perform logical right shit on 0xC3 and store at $9026 - note the carry flag is 1
INC IX

;Perform rotate left on 0x36 and store at $9027
INC IX

;Call get65h function and get the returned value from the stack and store at $9028
INC IX

;Set bit 5 in register C and store value in C at $9029
INC IX

;Jump to get47h function in the middle of the code. 47 will be stored at $9030
INC IX

;Retrieve the value 0x65 from $9028 in memory and store at $9031
INC IX

;Get 61 from imput instruction (this may not be possible with ide) and store at $9032
INC IX

;Perform arithmetic left shift on 0xD9 and store at $9033
INC IX

end:

JP end	