# Emulator ROM Implementation
As part of our prototype we are developing a simple test ROM to run a "Hello World" demo program on any Game Gear Emulator. We are using DevkitSMS for this which is a library that allows c code to be compiled into Sega Master System and Sega Game Gear files. This process involves using a tool called BMP2Tile to turn a BMP image into readable tile and palette formats. The program uses the library's SMS_loadPSGaidencompressedTiles(), SMS_loadSTMcompresssedTileMap, GG_loadBGPalette(), SMS_displayOn(), and SMS_waitForVBlank() methods to load and display the "Hello World" background. SMS_AddSprite() is used to display a sprite of a Gator head which polls input from the directional pad and buttons to move around and change its image.

### Current implementation for final product
[Retropie](https://retropie.org.uk/) and the [lr-genesis-plus-gx](https://github.com/libretro/Genesis-Plus-GX) Game Gear emulator are currently running the test rom on a Raspberry Pi Zero W. The controller to interface with the raspberry pi is custom using an Arduino Feather with [GP2040-CE](https://gp2040-ce.info/) firmware which makes any microcontroller with a RP2040 chip recognized as a controller via USB.

The following steps are to install and run retropie and the test rom on a Raspberry Pi Zero W. Please look at the official documentation for retropie to make adjustments if running on a different raspberry pi.
1. Using [Raspberry Pi Imager](https://www.raspberrypi.com/software/) install an image of retropie onto a micro sd card. In the imager, select Raspberry Pi Zero W as the device, Emulation and Game Os > Retropie > Retropie (RPI 1/Zero) for the OS, and the micro sd as the storage.
2. On boot, a welcome screen should apear followed by a controller configuration screen. Configure the controller based on the instructions on the screen.
3. Enter Configuration > WIFI on the main menu. Select No on the next screen. Then select 1 Connect to WiFi network. After completing the following prompts, the pi is connected to the network. Return to the main menu.
4. Enter Configuration > RASPI-CONFIG. Select 3 Interface Options > P2 SSH. Select yes to enable SSH.
5. Download [compileTest.gg](compileTest.gg) from this repo onto a computer.
6. Use sftp to transfer compileTest.gg from your computer to the raspberry pi. The pi's IP address can be found under Configuration > Show IP.
7. Ssh into the raspberry pi. User is pi default password is raspberry. (NOTE: For security, this default password should be changed.) Move the compileTest.gg from the home directory to /home/pi/RetroPie/roms/gamegear
8. Restart retropie. This can be done by accessing the retropie menu with the start button
9. Game Gear will now be an option from the main menu. Select it then the compileTest rom

### How to run test emulator without a raspberry pi
1. Install Sega Game Gear Emulator, Fusion recommended (https://www.emulator-zone.com/doc.php/genesis/fusion.html)
2. Run makefile to compile code (if not already compiled)
3. In Fusion click File->Load Game Gear ROM (CTRL-A) and load "compileTest.gg"
4. Use arrow keys and 'A' to control program

### Setting Up the external controller
1. Program "/Keyboard/Keyboard.ino" to Arduino
2. Flash "/Keyboard/Arduino-keyboard-0.3.hex" to Arduino
3. Unplug and Replug Arduino to have it appear as a keyboard

### Bugs/History
#### Initial test rom development (using fusion)
There were some bugs throughout the development. One common mistake is using the Sega Master System color palette for Game Gear games. The color palette scheme is one of the few major differences between the two. When programming, bugs were a bit hard to detect with no terminal output from the fusion emulator. Luckily though compilation was very quick, requiring only one make command, so changes could be quickly made and tested. When learning how to display sprites, it was helpful to display all tiles of a sprite at once, and then sort from there which were needed and where.
#### Raspberry Pi Setup
There was one main issue implementing retropie on the Raspberry Pi Zero W which is easily avoidable. The main issue was downloading the incorrect version of Retropie. This resulted in the pi booting straight to the terminal instead of into retropie. 
Some current issues with Retropie include:
- Booting into the retropie main menu. Ultimately, this will need to boot directly to a Game Gear ROM or menu specifically for the Game Gear
- There are other emulators in retropie that are loaded on boot but are never used for this project. These need to be removed from the retropie install to reduce boot time and save space
- There is currently no exit built into the test rom. When running in retropie the test rom must be exited using the retroarch menu which is accessed using a hotkey configured at retropie's first boot. [Here is more information on the hotkey](https://retropie.org.uk/docs/Controller-Configuration/#hotkey)
- Using the GP2040-CE firmware on the Adafruit feather is not ideal. Significantly fewer gpio pins are configured on the Adafruit feather when installing the pico's version of the firmware on it (there is no adafruit feather version of the firmware). Thus, only 6 buttons can be configured on the custom controller with the Arduino Feather. The Game Gear has a total of 8 buttons. This is easily fixed by replacing the Adafruit Feather with a Raspberry Pi Pico
