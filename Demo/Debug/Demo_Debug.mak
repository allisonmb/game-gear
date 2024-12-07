SHELL = cmd.exe

#
# ZDS II Make File - Demo project, Debug configuration
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
PRJDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Demo
PRJDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Demo

# intermediate files directory
WORKDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Demo\Debug
WORKDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Demo\Debug

# output files directory
OUTDIR = C:\Users\Allison\Desktop\UF\Year 4 Semester 1\Senior Design\Project\game-gear\Demo\Debug\
OUTDIR_ESCSPACE = C:\Users\Allison\Desktop\UF\Year\ 4\ Semester\ 1\Senior\ Design\Project\game-gear\Demo\Debug\

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

LDFLAGS = @.\Demo_Debug.linkcmd
build: Demo

buildall: clean Demo

relink: deltarget Demo

deltarget: 
	@if exist "$(WORKDIR)\Demo.lod"  \
            $(RM) "$(WORKDIR)\Demo.lod"
	@if exist "$(WORKDIR)\Demo.hex"  \
            $(RM) "$(WORKDIR)\Demo.hex"
	@if exist "$(WORKDIR)\Demo.map"  \
            $(RM) "$(WORKDIR)\Demo.map"

clean: 
	@if exist "$(WORKDIR)\Demo.lod"  \
            $(RM) "$(WORKDIR)\Demo.lod"
	@if exist "$(WORKDIR)\Demo.hex"  \
            $(RM) "$(WORKDIR)\Demo.hex"
	@if exist "$(WORKDIR)\Demo.map"  \
            $(RM) "$(WORKDIR)\Demo.map"
	@if exist "$(WORKDIR)\sega_print.obj"  \
            $(RM) "$(WORKDIR)\sega_print.obj"
	@if exist "$(WORKDIR)\sega_print.lis"  \
            $(RM) "$(WORKDIR)\sega_print.lis"
	@if exist "$(WORKDIR)\sega_print.lst"  \
            $(RM) "$(WORKDIR)\sega_print.lst"

# pre-4.11.0 compatibility
rebuildall: buildall 

LIBS = 

OBJS =  \
            $(WORKDIR_ESCSPACE)\sega_print.obj

Demo: $(OBJS)
	 $(LD) $(LDFLAGS)

$(WORKDIR_ESCSPACE)\sega_print.obj :  \
            $(PRJDIR_ESCSPACE)\sega_print.asm
	 $(AS) $(ASFLAGS) "$(PRJDIR)\sega_print.asm"

