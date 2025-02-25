# PCB Design and Schematics
There are 3 PCBs: the left, right, and center PCBs. These are connected to eachother with header pins. Note: The "main PCB" is an old version which was before the PCB was split into 3. "GG PCB" is a remake of the original Game Gear PCB from https://oshwlab.com/maarten040476_3348/sega-game-gear-837-7996.
## Currently Implemented
### Center PCB
The center PCB connects to the left and right PCBs. 
The center PCB contains:
- [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/)
- [3.5 Waveshare HDMI Screen](https://www.waveshare.com/wiki/3.5inch_HDMI_LCD)

### Left PCB
The left PCB contains:
- D-Pad buttons - These are traces on the board that are not connected. They are connected by a metal disk attached to the button that completes the circuit when the button is pushed.
- Power LED - A 3mm red LED with a 270 ohm resistor.

### Right PCB
The right PCB contains:
 - Start, 1, and 2 buttons - Works the same as the D-Pad buttons

## To be Implemented
### Center PCB
- Batery PCB - Need to decide on exact battery and battery board that will provide enough power for the other components

### Left PCB
- Volume Dial - Connected to rotary encoder that can be interpreted by the Raspberry Pi to change the system's volume level.
- Audio Amplifier - Connected to the Raspberry Pi and is capable of converting digital sound to anologue to go to a speaker. Currently looking at using [MAX98357A](https://www.adafruit.com/product/3006)

### Right PCB
The right PCB contains:
 - Brightness Dial - Same implementation as the volume dial, except for the screen brightness

## Current Issues
- The PCB is not complete, the parts listed above need to be added
- There may be an issue with using the MAX98357 audio amplifier with the PiJuice. Both use i2c for communication with the Raspberry Pi. However, they use different pins to do so and thus both may work together.
- The battery must be large enough to support the Raspberry Pi and the HDMI screen. The power consumption for both needs to be measured to choose a big enough battery.
- The largest single cell battery that can fit in the current case is 1200mAh. It is unlikely this is sufficient to power the console. There are two possible fixes for this. The case can be altered to allow a larger signle cell battery to fit, but this would cause issues with holding the console. Or multiple batteries in series could be used, but this would eliminate use of some battery PCBs which only work with single cell batteries.
