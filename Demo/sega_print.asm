.org %0

;Load the address $9020 into the IX register - one of the two index registers
LD IX, 9020h

;Store 0x53 at $9020 and increment IX - will be incrementing IX every time value is stored to memory
LD (IX+0), 53h
INC IX

;Add 0x15 to 0x30 and store at $9021

;Subtract 0x3 from 0x50 and store at $9022

;OR 0x40 with 0x01 and store at $9023

;AND 0xEC with 0x20 and store at $9024

;XOR 0x2E with 0x19 and store at $9025

;Perform logical right shit on 0xC3 and store at $9026 - note the carry flag is 1

;Perform rotate left on 0x36 and store at $9027

;Call get65h function and get the returned value from the stack and store at $9028

;Set bit 5 in register C and store value in C at $9029

;Jump to get47h function in the middle of the code. 47 will be stored at $9030

;Retrieve the value 0x65 from $9028 in memory and store at $9031

;Get 61 from imput instruction (this may not be possible with ide) and store at $9032

;Perform arithmetic left shift on 0xD9 and store at $9033

end:

JP end	