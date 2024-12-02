# Variables
SDCC = sdcc
IHX2SMS = ihx2sms
CFLAGS = -c -mz80 --no-peep -DTARGET_GG
#CFLAGS = -c -mz80 --no-peep 
LFLAGS = -o subOutput/compileTest.ihx -mz80 --no-std-crt0 --data-loc 0xC000
CRT0 = crt0/crt0_sms.rel
LIB = SMSlib/SMSlib_GG.lib
#LIB = SMSlib/SMSlib.lib
SRC = compileTest.c assets.c
OBJ = subOutput/compileTest.rel subOutput/assets.rel
IHX = subOutput/compileTest.ihx
GG = compileTest.gg
#GG = compileTest.sms

# Targets
all: $(GG)

# Ensure subOutput directory exists
subOutput:
	@if not exist subOutput mkdir subOutput

# Compile the source files to object files
subOutput/%.rel: %.c | subOutput
	$(SDCC) $(CFLAGS) $< -o subOutput/

# Link the object files to produce the .ihx file
$(IHX): $(OBJ)
	$(SDCC) $(LFLAGS) $(CRT0) $(OBJ) $(LIB)

# Convert .ihx file to .gg file
$(GG): $(IHX)
	$(IHX2SMS) $(IHX) $@

# Clean build files
clean:
	@if exist subOutput rmdir /s /q subOutput
	@if exist $(GG) del $(GG)
