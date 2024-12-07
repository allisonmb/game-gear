# Emulator ROM Implementation
As part of our prototype we are developing a simple test ROM to run a "Hello World" demo program on any Game Gear Emulator. We are using DevkitSMS for this which is a library that allows c code to be compiled into Sega Master System and Sega Game Gear files. This process involves using a tool called BMP2Tile to turn a BMP image into readable tile and palette formats. The program uses the library's SMS_loadPSGaidencompressedTiles(), SMS_loadSTMcompresssedTileMap, GG_loadBGPalette(), SMS_displayOn(), and SMS_waitForVBlank() methods to load and display the "Hello World" background. SMS_AddSprite() is used to display a sprite of a Gator head which polls input from the directional pad and buttons to move around and change its image.

### How to use
1. Install Sega Game Gear Emulator, Fusion recommended (https://www.emulator-zone.com/doc.php/genesis/fusion.html)
2. Run makefile to compile code (if not already compiled)
3. In Fusion click File->Load Game Gear ROM (CTRL-A) and load "compileTest.gg"
4. Use arrow keys and 'A' to control program

### Setting Up the external controller
1. Program "/Keyboard/Keyboard.ino" to Arduino
2. Flash "/Keyboard/Arduino-keyboard-0.3.hex" to Arduino
3. Unplug and Replug Arduino to have it appear as a keyboard

### Bugs/History
There were some bugs throughout the development. One common mistake is using the Sega Master System color palette for Game Gear games. The color palette scheme is one of the few major differences between the two. When programming, bugs were a bit hard to detect with no terminal output from the fusion emulator. Luckily though compilation was very quick, requiring only one make command, so changes could be quickly made and tested. When learning how to display sprites, it was helpful to display all tiles of a sprite at once, and then sort from there which were needed and where.
