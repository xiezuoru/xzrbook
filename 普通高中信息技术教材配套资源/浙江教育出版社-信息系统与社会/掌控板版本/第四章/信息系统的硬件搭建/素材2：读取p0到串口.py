from mpython import *
import time
p0=MPythonPin(0,PinMode.ANALOG)
while True:
    print(p0.read_analog())
    time.sleep(0.2)
    