.org %0

;load int into all general purpose registers (A is accumulator register and IX and IY are incremented registers)
LD C, 10d
LD E, Bh
LD L, 12h
LD B, 13h
LD D, 14h
LD H, 15h

OUT (C),A

;store address $9020 into B and C
LD B, 90h
LD C, 20h

;store int in accumulator reg (A) to then be stored at address $9020
LD A, 5h
LD (BC), A

;load load 1 into A then load int in $9020 back into A (note any register pairing can be used with only A. HL is the only reg pair that can be used with any reg including A)
LD A, 1h
LD A, (BC)
;LD E, (BC) <- invalid instruction - results in compiler error

;store address $9025 into HL
LD H, 90h
LD L, 25h

;store value in D to $9025 and then load the int at $9025 in E
LD (HL), D
LD E, (HL)

;add values in A and E which will be stored in A
ADD A, E

;Add int to value in A which will be stored in A
ADD A, 3h

;Add value stored at $9025 to value in A which will be stored in A
ADD A, (HL)

;Subtract value in A by value at $9025
SUB A, (HL)

;increment A
INC A

;increment HL and store A at $9026
INC (HL)
LD (HL), A

;decrement HL and load value at $9025 into A
DEC (HL)
LD A, (HL)

;And value in A with $2
AND 2h

;OR value in A with $3
OR 3h

;exchange the address in HL to SP and then exchange SP and IY to get $9025 into IY
;LD SP, HL
;LD SP, IY

;load IY into C 
;LD C, (IY)

;load IX + 4 into H
;LD H, (IX+4h)

;end loop
end:
JP end