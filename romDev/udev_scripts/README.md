# Cartridge Auto Load Scripts
This directory contains the udev rule and correponsing systemd services and scripts to enable the automatic cartridge loading functionality of our system. When the user plugs in a cartridge, the cartridge is mounted, the .gg ROM file is found, and the ROM file is automatically loaded into the emulator. In addition, when the cartridge is removed the emulator will automatically quit.

# How to Use
1. First, copy the udev rule (99-external-storage.rules) from the etc/udev/rules.d folder to the corresponding directory (/etc/udev/rules.d) on the system. Make sure to change the hard-coded directories to have the right username.
2. Then, copy the systemd rules from etc/systemd/system/mount-cart@.service and etc/systemd/user/run-cart@.service to the corresponding directories. Once again, update the home directory usernames to match the current system.
3. Lastly, copy the scripts from the /home directory to the user's home directory (/home/*user*).
4. Restart to let the rules take effect, or run the following command: `sudo udevadm control --reload-rules && sudo udevadm trigger && sudo systemctl daemon-reload`.
5. Then, the udev rules should be fully functional.

# Known Bugs/Future Steps
Right now, this implementation looks for any USB device when deciding what to mount. Once we have the JoeyGG, we intend to expand the script by restricting it to only the UUID/manufacturer ID of the JoeyGG itself so that there are no false positives and negatives (for example auto killing the emulator when someone removes a flash drive).
