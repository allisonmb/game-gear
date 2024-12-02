# game-gear

## Architecture
### PCBs and Hardware Overview
The game gear is made up of 3 PCB boards: The back board (or main board), DC-DC converter board, and sound board. The majority of components are contained on the back board, including the main memory (IC3), video memory (IC2), and ASIC (IC1). The ASIC chip is owned by Sega, and thus must be recreated. [1]

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/PCB%20Scans.PNG)

Figure 1: Scans of the PCB boards [1]

### ASIC - IC1
The ASIC chip is essentially the processor for the game gear. The main components in the ASIC are the CPU (z80), video display processor, standard cell array. The remainder of the components can be seen in the block diagram below. Asside from the z80, none of these components have a part number and thus will have to be recreated or replaced [1]. Many of these components will be placed on the orange crab fpga, which will essentially replace the ASIC.

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/IC1%20Block%20Diagram.PNG)

Figure 2: Block diagram of the contents of the ASIC chip and its connections to other subsystems [1]

### Memory - IC2, IC3, and the game cartridge
The memory included in the game gear itself are the main memory and video memory chips. The main memory is a 64kBit CMOS SRAM and the video memory is a  256kBit pseudo SRAM [1]. Since the specific chips used in the game gear are no longer availible, they must be replaced with another suitable RAM chip. The main memory has been replaced by a 256kBit CMOS SRAM with nearly exact read/write cycle timing to the original [2]. 

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Original%20IC3.PNG)

Figure 3: Original IC3 chip [3]

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Replacement%20IC3.PNG)

Figure 4: Replacement IC3 chip

The game cartridge contains the data for the game itself and can be swapped out of the console. This recreation of the game gear will work with original game gear cartridges. It is possible to create a custom game gear cartridge, however it is difficult since it contains a Sega proprietary chip [4].

### Video
The game gear has a 3.2 inch backlit 256x192 resolution LCD screen using vga communication [5]. Since it is nearly impossible to find a screen of this resoultion today, a higher resolution screen will be used and the graphics adjusted accordingly. 

### Sound
The sound chip on the game gear is a SN76489 with four channel mono sound and three square wave generator outputted through one speaker in the console [6]. The majority of the components for the sound are contained on the sound board [1]. The SN76496 is obsolite so it will be recreated through emulation. It is also possible to play sound through the headphone jack on the top of the console which will be included in this recreation.

### Inputs
#### Buttons
There are a total of seven buttons on the game gear which are used to control gameplay [1]. All of these are simple push buttons connected to the back board PCB [3]. There is also a basic power switch [1].

#### Dials
The game gear contains two dials for brightness and volume. They are connected to the back board PCB and sound PCB, respectively [1].

#### Plug in connections
At the top of the console there is a headphone jack, gear-to-gear cable input, and power jack input. The headphone jack is a standard aux plug which will output sound to any device connected to it [1]. The gear-to-gear input is used to connect two game gears together to play multiplayer games [7]. The power jack input is used power the console with a cable wall adapter instead of with the batteries.

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Inputs.PNG) 

Figure 5: All inputs for the game gear [1]

## Completed components
IC3 - Main RAM

## In progress
Sound Chip
Back Board Schematic/PCB
LCD Screen

## Not started
### ASIC chip
Visual Display Processor
Standard Cell Array
Main Clock
DC-AC Converter

### Other components
DC-DC Converter Board Schematic/PCB
Sound Board Schematic/PCB
Speaker
IC2 - VRAM
Cartridge

### Emulator Work
As part of our prototype we are developing a simple test ROM to run a "Hello World" demo program on any Game Gear Emulator. We are using DevkitSMS for this which is a library that allows c code to be compiled into Sega Master System and Sega Game Gear files. This process involves using a tool called BMP2Tile to turn a BMP image into readable tile and palette formats. The program uses the library's SMS_loadPSGaidencompressedTiles(), SMS_loadSTMcompresssedTileMap, GG_loadBGPalette(), SMS_displayOn(), and SMS_waitForVBlank() methods to load and display the "Hello World" background. 

## Known Bugs
### IC3 - Main RAM
Possible timing issue due to the difference of some values in the read/write cycle for the replacement RAM. These values are: output hold from address change, chip selection to output in low z, write recovery time, and output active from end of write. This is unlikely to cause problems since the replacement RAM is faster and the difference is small (5ns).
### FPGA HDL Flashing
Synthesis and routing on FPGAs can often be a bit finnicky, especially depending on the pipeline being used. Thus, there is the potential that issues arise when our results are translated to the OrangeCrab board with a Lattice FPGA. Similarly, the pinout is different for Lattice and many of these files (A-Z80) were intended for Intel FPGAs, so we may have to do some tweaking to reconfigure it. Similarly, Quartus cannot be used for the Lattice FPGAs, and as a result for OrangeCrab we need to use the Open Source FPGA toolchain with Yosys and NextPnR. We expect that issues will arise when we transfer things over to the actual FPGA for our final product.
### Sound Chip Imperfections
Currently, the waves produced by our emulated sound chip are perfect and ideal square waves. However, in the real world this is likely not the case. As a result, for optimal recreation of the original hardware, we should try to emulate this imperfection somehow. For instance, making jumps slightly more progressive (add some delay time) rather than instantaneous or shifting the offsets of our signals.

## References
[1]  Sega, "Sega Service Manual Game Gear VA1," December 1993. [Online]. Available: https://gamesx.com/wiki/lib/exe/fetch.php?    media=schematics:service_manual_-_game_gear_va1.pdf. [Accessed 24 October 2024].

[2]  Major Brands, "HM62256 Series," [Online]. Available: https://www.jameco.com/Jameco/Products/ProdDS/42850.pdf. [Accessed 24 October 2024].

[3]  J. Lewis (2023) "bit-preserve" (Version 1.0) [Souce code]. https://github.com/baldengineer/bit-preserve/tree/main/Sega/Game%20Gear.

[4]  G. O’Brien, "DIY SEGA Game Gear 512Kb Flash Cartridge," October 2010. [Online]. Available: https://www.smspower.org/uploads/Development/DIY_SEGA_Game_Gear_512Kb_Flash_Cartridge.pdf. [Accessed 25 October 2024].

[5] Luke from RetroSix, "VA0/VA1 LCD Interface (Game Gear)," Retrosix, 16 December 2023. [Online]. Available: https://www.retrosix.wiki/va0va1-lcd-interface-game-gear. [Accessed 25 October 2024].

[6] "Sega Master System/Technical specifications," Sega Retro, [Online]. Available: https://segaretro.org/Sega_Master_System/Technical_specifications. [Accessed 23 October 2024].

[7] "Gear-to-Gear Cable," Sega Retro, [Online]. Available: https://segaretro.org/Gear-to-Gear_Cable. [Accessed 25 October 2024].
