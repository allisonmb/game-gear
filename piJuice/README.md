# PiJuice Battery Setup
1. Install lite version of pijuice software:
	a. cmd: sudo apt-get install pijuice-base
2. run pijuice_cli
3. Choose Battery Profile
	a. navigate to 'Battery Profiles'
	b. Select 'PjZero_1200'  
4. Configure power switch
	a. navigate to 'Buttons'
	b. select 'SW2'
	c. select 'Press'
	d. select 'HARD_FUNC_POWER_ON'
	e. go to 'Release;
	f. select 'HARD_FUNC_POWER_OFF'
5. Configure LED script
	a. enable pijuice.service
	    i. cmd: sudo systemctl enable pijuice.service
	    ii. cmd: sudo systemctl start pijuice.service
	    iii. verify system status with cmd: sudo systemctl status pijuice.service
	b. ensure 'lowPowerLED.py' has correct ownership and permissions
		i. cmd: chmod +x /home/pi/lowPowerLED.py
		ii. cmd: 777 /home/pi/lowPowerLED.py
		iii. cmd: sudo chown pi:pi /home/pi/lowPowerLED.py
	c. run pijuice_cli and navigate to 'System Events'
	d. enable 'System Start' event and select 'USER_FUNC1'
	e. navigate to 'User Scripts'
	f. set 'USER_FUNC1' to /home/pi/lowPowerLED.py
6. Configure Low Power Shutdown
	a. navigate to 'System Tasks'
	b. enable 'Min Charge' and set threshold to 10%
	c. navigate to 'System Events'
	d. enable 'Low Charge' and set function to 'SYS_FUNC_HALT_POW_OFF' 
