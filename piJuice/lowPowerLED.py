#!/usr/bin/python3

from pijuice import PiJuice # Import pijuice module
import RPi.GPIO as GPIO
import threading
import time
import os
import subprocess

power_led = 8
low_charge_thresh = 40
clk = 26 #volume a
dt = 15 #volume b

GPIO.setmode(GPIO.BCM)
GPIO.setup(clk, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(dt, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(power_led, GPIO.OUT)
GPIO.output(power_led, 0)


pijuice = PiJuice(1, 0x14) # Instantiate PiJuice interface object
print('CONNECTING....')
while pijuice.status.GetStatus().get('error') == 'COMMUNICATION_ERROR': pass
print('SUCCESS') # Read PiJuice status.

pijuice.status.SetIoDigitalOutput(1, 1)            
def led_ctrl():
    LED = 1
    
    while True:
        if pijuice.status.GetChargeLevel().get('data') <= low_charge_thresh:
            LED = 1 - LED
        else:
            LED = 1
        pijuice.status.SetIoDigitalOutput(1, LED)
        pijuice.status.SetLedState('D2', [LED * 50, 0, 0])
        # LED = 1 - LED
        GPIO.output(power_led, LED)


        time.sleep(1)  # prevent rapid toggle during same second

def volume_ctrl():
    clkLastState = GPIO.input(clk)
    counter = 50
    subprocess.run(f'amixer cset numid=1 {counter}%', shell=True)
    while True:
        clkState = GPIO.input(clk)
        dtState = GPIO.input(dt)
        if clkState == 1 and clkLastState == 0:
            #print('clkState: ' , clkState , ' dtState: ' , dtState)
            if dtState == 0:
                if (counter > 0):
                    counter -= 1
            else:
                if (counter < 100):
                    counter += 1
            subprocess.run(f'amixer cset numid=1 {counter}%', shell=True)
            print(counter)
        clkLastState = clkState

led_thread = threading.Thread(target=led_ctrl)
led_thread.start()

volume_thread = threading.Thread(target=volume_ctrl)
volume_thread.start()
# time.sleep(10)
