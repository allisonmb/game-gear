
# PiJuice Battery Setup

## Note - Ensure pijuice board is connected to the pi for the entire setup. The battery itself does NOT need to be connected to the pijuice

## 1. Install Lite Version of PiJuice Software
```bash
sudo apt-get install pijuice-base
```

## 2. Run PiJuice CLI
```bash
pijuice_cli
```

## 3. Choose Battery Profile
- Navigate to `Battery Profiles`
- Select: **PjZero_1200**

## 4. Configure Power Switch
- Navigate to `Buttons`
- Select `SW2`
  - Under **Press**, select: `HARD_FUNC_POWER_ON`
  - Under **Release**, select: `HARD_FUNC_POWER_OFF`

## 5. Configure LED Script

### a. Enable `pijuice.service`
```bash
sudo systemctl enable pijuice.service
sudo systemctl start pijuice.service
sudo systemctl status pijuice.service
```

### b. Ensure `lowPowerLED.py` Has Correct Ownership and Permissions
```bash
chmod +x /home/pi/lowPowerLED.py
chmod 777 /home/pi/lowPowerLED.py
sudo chown pi:pi /home/pi/lowPowerLED.py
```

### c. Set Script to Run on Boot
- Run `pijuice_cli`
- Navigate to `System Events`
  - Enable **System Start**
  - Set function to: `USER_FUNC1`
- Navigate to `User Scripts`
  - Set `USER_FUNC1` to:
    ```
    /home/pi/lowPowerLED.py
    ```

## 6. Configure Low Power Shutdown

- Navigate to `System Tasks`
  - Enable **Min Charge** and set threshold to **10%**
- Navigate to `System Events`
  - Enable **Low Charge**
  - Set function to: `SYS_FUNC_HALT_POW_OFF`
