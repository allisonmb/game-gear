# FPGA Implementation: A-Z80
Towards our goal of a realistic Game Gear representation, we intend to use an FPGA to replicate the Z80 and other boards such as the proprietary sound board. The [A-Z80](https://github.com/gdevic/A-Z80) does this, although it is somewhat outdated and does not have all of the functionality we need. However, it provides a full implementation of the Z80 along with some testing files. The implementation had to be updated from one that works on MAX II hardware to modern MAX 10 hardware (which is a jump from Quartus 13.0 to Quartus 23.1). As a result, the RAM and PLL (for the clock) had to be recreated in modern Quartus. Ultimately, this code is capable of converting a Z80 assembly file into a machine code memory initialization, synthesizing a memory and UART module, and then programming a DE10 Lite to replicate a Z80 that is running assembly code. The [provided test case](tools/zmac/hello_world.asm) is a "Hello World" implementation, which outputs printed statements over UART (in this case "CpE Design").

## How To Compile Assembly
1. Create and develop a Z80 assembly file in the [zmac folder](tools/zmac).
2. Drag and drop the created assembly file onto [make_fpga.bat](tools/zmac/make_fpga.bat).
3. Proceed with synthesizing and programming below.

## How to Synthesize and Program the DE10 Lite
1. Open the DE10 Lite Quartus project located [here](host/basic_de1/basic_de1.qpf).
2. Ensure that the DE10 Lite development kit is selected as the board.
3. Ensure the pins are correctly assigned according to the [DE10 Lite manual](https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Lite/DE10_Lite_User_Manual.pdf).
4. Click the play sign at the top to perform synthesis, planning, and routing.
5. Open the Programmer and select the USB-Blaster device.
6. Remove the default file for programming and click add file. Then, navigate to output_files and select the .pof file.
7. Program the board.
8. Proceed to use the programmed FPGA.

## Using the Programmed FPGA (For the provided hello_world.asm)
- KEY0 will act as a reset, immediately resetting the programmed output (along with the counter).
- KEY1 will act as a non-maskable interrupt, spamming "IM2" and then continuing after KEY1 is released.
- The UART output can be visualized using a DAD board with WaveForms (through the 'protocol' menu), and will be on GPIO pin 6, with a baud rate of 115200, 8 data bits, 1 stop bit, no parity, and a CR LF as the end of line.

## Known Bugs/History
Synthesis can be a bit finicky in Quartus, and so some errors may appear on different versions of Quartus or with different FPGAs other than the DE10 Lite. This code will not run on boards that are not in the MAX 10 family without a decent amount of modification. Getting the UART code to properly output was challenging, but I was finally able to do so after significant trouble with porting from MAX II (which modern versions of Quartus do not support and cannot convert) to MAX 10. Ultimately, I had to delete the IP files and recreate them with as similar of settings and initializations as I could, and it took some trial and error. Thus, porting to other families may be similarly difficult. When starting Quartus, it may prompt to overwrite or update the database file from another version of Quartus, and this is normal and can be accepted.
