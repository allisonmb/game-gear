# Design Prototype
Our prototype is focused on exploring several aspects of the Game Gear handheld: first, how can we recreate the Z80 processor on an FPGA and run assembly code to test and validate that it is functioning properly. In addition, how can we create test ROM files for the Game Gear that can run in an emulator and eventually be used on the hardware FPGA implementation.

Each aspect of the project is linked below, with README files indicating their functionality, how to run them, and known bugs.
- [Emulator ROM Implementation](romDev/)
- [Cartridge Auto Launch Scripts](romDev/udev_scripts/)
- [PCB Designs](https://github.com/allisonmb/game-gear/tree/17-pcb/pcbDesign)
- [GPIOnext](https://github.com/mholgatem/GPIOnext) - Used for interfacing with buttons through GPIO
- [3d Model](https://drive.google.com/file/d/1HNF1D_YHym1qWQATkMjLh69oOEiKL8Yn/view?usp=sharing) - Will need blender to view

Below are links to parts of the project that are no longer in development
- [FPGA Implementation](A-Z80/)
- [Z80 Assembly Test Code](<z80 assembly/>)
