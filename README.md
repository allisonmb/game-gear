# game-gear

## Architecture
### PCBs and Hardware Overview
The game gear is made up of 3 PCB boards: The back board (or main board), DC-DC converter board, and sound board. The majority of components are contained on the back board, including the main memory (IC3), video memory (IC2), and ASIC (IC1). The ASIC chip is owned by Sega, and thus must be recreated. 

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/PCB%20Scans.PNG)

### ASIC - IC1
The ASIC chip is essentially the processor for the game gear. The main components in the ASIC are the CPU (z80), video display processor, standard cell array. The remainder of the components can be seen in the block diagram below. Asside from the z80, none of these components have a part number and thus will have to be recreated or replaced. Many of these components will be placed on the orange crab fpga, which will essentially replace the ASIC.

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/IC1%20Block%20Diagram.PNG)

### Memory - IC2, IC3, and the game cartridge
The memory included in the game gear itself are the main memory and video memory chips. The main memory is a 64kBit CMOS SRAM and the video memory is a  256kBit pseudo SRAM. Since the specific chips used in the game gear are no longer availible, they must be replaced with another suitable RAM chip. The main memory has been replaced by a 256kBit CMOS SRAM with nearly exact read/write cycle timing to the original. 

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Original%20IC3.PNG)

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Replacement%20IC3.PNG)

The game cartridge contains the data for the game itself and can be swapped out of the console. This recreation of the game gear will work with original game gear cartridges. It is possible to create a custom game gear cartridge, however it is difficult since it contains a Sega proprietary chip.

### Video
The game gear has a 3.2 inch backlit 160x144 resolution LCD screen using vga communication. Since it is nearly impossible to find a screen of this resoultion today, a higher resolution screen will be used and the graphics adjusted accordingly. 

### Sound

### Inputs
#### Buttons
There are a total of seven buttons on the game gear which are used to control gameplay. All of these are simple push buttons connected to the back board PCB. There is also a basic power switch.

#### Dials
The game gear contains two dials for brightness and volume. They are connected to the back board PCB and sound PCB, respectively.

#### Plug in connections
At the top of the console there is a headphone jack, gear-to-gear cable input, and power jack input. The headphone jack is a standard aux plug which will output sound to any device connected to it. The gear-to-gear input is used to connect two game gears together to play multiplayer games. The power jack input is used power the console with a cable wall adapter instead of with the batteries.

![alt text](https://github.com/allisonmb/game-gear/blob/main/README%20Images/Inputs.PNG)

## Completed components
IC3 - Main RAM

## In progress
Sound Chip
Back Baord Schematic/PCB
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

## Known Bugs
### IC3 - Main RAM
Possible timing issue due to the difference of some values in the read/write cycle for the replacement RAM. These values are: output hold from address change, chip selection to output in low z, write recovery time, and output active from end of write. This is unlikely to cause problems since the replacement RAM is faster and the difference is small (5ns).
