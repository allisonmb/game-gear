SHELL = cmd.exe

#
# ZDS II Make File - testing project, Debug configuration
#
# Generated by: ZDS II - eZ80Acclaim! 5.3.5 (Build 23020901)
#   IDE component: d:5.3.0:23020901
#   Install Path: C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\
#

RM = del

# ZDS base directory
ZDSDIR = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5
ZDSDIR_ESCSPACE = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5

# ZDS bin directory
BIN = $(ZDSDIR)\bin

# ZDS include base directory
INCLUDE = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\include
INCLUDE_ESCSPACE = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\include

# ZTP base directory
ZTPDIR = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\ZTP2.5.1
ZTPDIR_ESCSPACE = C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\ZTP2.5.1

# project directory
PRJDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Testing
PRJDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Testing

# intermediate files directory
WORKDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Testing\Debug
WORKDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Testing\Debug

# output files directory
OUTDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Testing\Debug\
OUTDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Testing\Debug\

# tools
CC = @"$(BIN)\eZ80cc"
AS = @"$(BIN)\eZ80asm"
LD = @"$(BIN)\eZ80link"
AR = @"$(BIN)\eZ80lib"
WEBTOC = @"$(BIN)\mkwebpage"

ASFLAGS =  \
-define:_EZ80=1 -define:_SIMULATE=1  \
-include:"\"..;C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\include\std;C:\Zilog\ZDSII_eZ80Acclaim!_5.3.5\include\zilog\""  \
-list -NOlistmac -name -pagelen:0 -pagewidth:80 -quiet -sdiopt  \
-warn -debug -NOigcase -cpu:eZ80190

LDFLAGS = @.\testing_Debug.linkcmd
build: testing

buildall: clean testing

relink: deltarget testing

deltarget: 
	@if exist "$(WORKDIR)\testing.lod"  \
            $(RM) "$(WORKDIR)\testing.lod"
	@if exist "$(WORKDIR)\testing.hex"  \
            $(RM) "$(WORKDIR)\testing.hex"
	@if exist "$(WORKDIR)\testing.map"  \
            $(RM) "$(WORKDIR)\testing.map"

clean: 
	@if exist "$(WORKDIR)\testing.lod"  \
            $(RM) "$(WORKDIR)\testing.lod"
	@if exist "$(WORKDIR)\testing.hex"  \
            $(RM) "$(WORKDIR)\testing.hex"
	@if exist "$(WORKDIR)\testing.map"  \
            $(RM) "$(WORKDIR)\testing.map"
	@if exist "$(WORKDIR)\test.obj"  \
            $(RM) "$(WORKDIR)\test.obj"
	@if exist "$(WORKDIR)\test.lis"  \
            $(RM) "$(WORKDIR)\test.lis"
	@if exist "$(WORKDIR)\test.lst"  \
            $(RM) "$(WORKDIR)\test.lst"

# pre-4.11.0 compatibility
rebuildall: buildall 

LIBS = 

OBJS =  \
            $(WORKDIR_ESCSPACE)\test.obj

testing: $(OBJS)
	 $(LD) $(LDFLAGS)

$(WORKDIR_ESCSPACE)\test.obj :  \
            $(PRJDIR_ESCSPACE)\test.asm
	 $(AS) $(ASFLAGS) "$(PRJDIR)\test.asm"

