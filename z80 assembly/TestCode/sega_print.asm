.org %0

;Load the address $9020 into the IX register - one of the two index registers
LD IX, 9020h

;load 0's into memory to better show in demo the memory data changing
LD (IX+0), 0h
LD (IX+1), 0h
LD (IX+2), 0h
LD (IX+3), 0h
LD (IX+4), 0h
LD (IX+5), 0h
LD (IX+6), 0h
LD (IX+7), 0h
LD (IX+8), 0h
LD (IX+9), 0h
LD (IX+10), 0h
LD (IX+11), 0h
LD (IX+12), 0h
LD (IX+13), 0h


;Store 0x53 at $9020 and increment IX - will be incrementing IX every time value is stored to memory
LD (IX+0), 53h
INC IX

;Add 0x15 to 0x30 and store at $9021
;The A reg is the default accumulator register which is used to store the result of most of the arithmetic instructions
LD A, 15h
ADD A, 30h
LD (IX+0), A
INC IX

;Subtract 0x9 from 0x50 and store at $9022
get47h:
LD A, 50h
SUB 9h
LD (IX+0), A
INC IX

;load the value at $902A and check if that value is 47. if no, continue. if yes, jump to get47hReturn
LD HL, 902Ah
LD D, (HL)
CP D
JP Z, get47hReturn



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
LD C, C3h
SRL C
LD (IX+0), C
INC IX

;Perform rotate left on 0x36 and store at $9027
LD C, 36h
RL C
LD (IX+0), C
INC IX

;Call get65h function and get the returned value from the stack and store at $9028
CALL get65h
POP DE
LD (IX+0), E
INC IX

;Set bit 5 in register B and store value in B at $9029
SET 5, B
LD (IX+0), B
INC IX

;Jump to get47h function in the middle of the code. 47 will be stored at $902A
JP get47h
get47hReturn:

;Retrieve the value 0x65 from $9028 in memory and store at $902B
LD H, 90h
LD L, 28h
LD D, (HL)
LD (IX+0), D

;Get value from imput instruction - will be FF since nothing is connected to the input
LD C, 7h
IN D, (C)

;Reset the appropriate bits in D to change FF to 61
RES 7, D
RES 4, D
RES 3, D
RES 2, D
RES 1, D
LD  (IX+1), D

;Perform arithmetic left shift on 0xD9 and store at $902D
LD C, B9h
SLA C
LD (IX+2), C

end:

JP end

get65h:
	;store value in sp
	POP HL
	;store 65h in C and push onto stack
	LD C, 65h
	PUSH BC
	;push the original sp onto the stack
	PUSH HL
	RET