from mpython import *
import time
while True:
    display.fill(0)
    display.DispChar("光线值：%d"%light.read(), 0, 0)
    display.show()
    time.sleep(0.2)