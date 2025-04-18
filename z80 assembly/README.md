# Z80 Assembly

## IDE Testing code 
[This code](ideTesting/test.asm) was created to practice z80 assembly and learn the ez80Acclaim IDE. Mainly uses arithmetic and load instructions. Does not have much functionality

## Test code
[This code](TestCode/sega_print.asm) was created to ensure the majority of Z80 instructions worked with the ez80Acclaim IDE after issues with an online IDE (see bugs). This code makes use of 8-bit load, 16-bit load, 8-bit arithmetic, shift, rotate, call, jump, return, etc instructions. The code simply stores "SEGA Game Gear" in memory. However each character is calculated by using a combination of the instructions mentioned to ensure each instruction worked as intended. To ensure this, one instruction was added to the code at a time. Every time a new instruction was added, it was tested by running the code through the debugger and ensuring the registers and memory contained the intended value each time an instruction ran. 

## Car game
[This code](carGame/carGame.asm) was implemented to show that a game can be made with Z80 assembly alone. This game is run in the ZX Spin emulator. To run the code in the emulator load it at address 33000 (See Running the emulator below). The left control is space and the right control is left arrow key. The goal of the game is to avoid crashing the "car" into the walls. The main components of the code are keeping track of the score, displaying visuals, and the logic for the car and wall. A more detailed description of the program can be seen in the flow chart below[1].

![alt text](https://github.com/allisonmb/game-gear/blob/main/z80%20assembly/z80GameDiagram.drawio.png)

## Assembly project set up for ez80Acclaim ide:
- IDE download available at: https://www.zilog.com/index.php?option=com_zcm&task=sdlp
### Create project:
1. Go to file and select new project
2. Select the path where the project will be created
3. Select "Assembly Only" for Project Type
4. Select "eZ80" for CPU Family
5. Select "eZ80190" for CPU
6. Select "Executable" for Build Type
7. Click Continue
8. Check eZ80DevPlatform_190_RAM. Leave the rest as default and click Next
9. Change the memory and storage blocks to the desired ranges and click finish

### Add files to project:
- Select Project->Add Files...
- Select the file to be added and click add. Can create a blank .asm file to be added. (Haven't found a way to create new files with the ide)
- The new file will be under the "Assembly Only Project Files" directory

### Debugging with the ide:
1. Build the code (Make sure it is built, not assembled. Only assembling the file will lead to an error when debugging).
2. Click go
3. Add breakpoints by cliking beside a line of code then clicking the Add/Remove breakpoint button
4. Click restart
5. Use step buttons to step through the code

### Debugging windows:
-To access the debugging windows go to View->Debug Windows

## Set up ZX Spin emulator
- Get the zip file download from https://www.zophar.net/sinclair/zx-spin.html
- Open the emulator using the exe file
- Go to Tools -> Z80 Assembler...
- Open an asm file with File -> Open
- Assemble the code with File -> Assemble

### Running the emulator
- Click in the emulator window
- Type: `100 t ctrl-shift l <address of code start>` and press enter
- Type: `r` and press enter

## Difficulties 
  Finding an IDE environment to develop z80 assembly was difficult since the z80 processor is obsolete and Zilog no longer provides a development environment for it. Initially, 3 different online assemblers were tested however none properly ran a load instruction. Then, we discovered the online IDE available at https://github.com/IgnacioSearles/Z80-AssemblerAndEmulator[2]. This seemed to work fine initially and we started to write the [sega_print.asm](TestCode/sega_print.asm) code. Initially, we only coded with 8-bit load and arithmetic instructions which worked fine in this IDE. To test that they worked fine, we debugged line by line to ensure the values in the registers and memory were as expected. However, we ran into issues when we tried to implement 16-bit load and arithmetic instructions which threw a compiler error despite matching the syntax from the z80 cpu manual[3]. We also tried to implement input and output instructions, however both threw compiler errors as well. When checking the documentation of the online IDE closely, we discovered documentation describing the instructions used in the IDE which did not include the input and output instructions. Even though this documentation stated 16-bit load and arithmetic instructions should work, we decided to look for a different IDE since we needed to compile input and output instructions [2]. 
  After another long period of searching, we found the eZ80 chip is backwards compatable with the z80 [4]. As a result, we tried the official Zilog development IDE for the eZ80 called ez80Acclaim, hoping it would build and debug z80 assembly. Input, output, and 16-bit load and arithmetic instructions worked without errors in ez80Acclaim which led us to continue developing in it. There were however a couple issues with this IDE, described in the "Bugs and issues" section below, that we took a while attempting to find a solution, however decided to continue developing the code since both issues could be easily tested when running on the FPGA.

## Bugs and issues
- In sega_print.asm, when returning from the called function (get65h) the value stored in the C register remains even after returning
- in ez80Acclaim IDE must write hex values as xh and cannot write them as $x. This differs in other IDEs.
- Possible issue: code assembled from the ez80Acclaim IDE may not work on the FPGA since it is technically compiling for the ez80. Safer to use solely as development environment and then move the asm files to the A-z80 assembler for implementation on the FPGA
- When using the ez80Acclaim IDE input and output instructions cannot be controlled. Input instructions are set to FF
- In the ez80Acclaim IDE the UART debug window does not properly recognize UART output
- The ez80Acclaim IDE can only use the z80 instruction set. Some of the code in this repo is writen in 8080 since the A-Z80 assembler is able to translate 8080 to z80. See FPGA readme
- The ZX Spin emulator will freeze and crash if code is edited while running an emulation
- The car game needs to be modified to work on the FPGA. Currently it is set up to communicate with the ZX Spin emulator which is written in BASIC. The FPGA implementation would need to be written to communicate with its hardware instead of the emulator.
- The car game controls are not intuitive. Currently to move left space is used and to move right the left arrow key is used
- Do NOT use online IDE available at https://github.com/IgnacioSearles/Z80-AssemblerAndEmulator. This IDE does not implement input or output instructions and 16 bit arithmetic instructions are bugged [2].

## References
[1]  J. Kingsman. “Tutorial: ZX Spectrum Machine Code Game in 30 Minutes.” Chutney. Available: https://chuntey.wordpress.com/2010/01/12/tutorial-zx-spectrum-machine-code-game-30-minutes/
