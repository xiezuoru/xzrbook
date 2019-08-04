from mpython import *
from machine import UART
uart = UART(1, 115200, rx=3, tx=1) 
while True:
    if uart.any():
        incoming = str(uart.read())
        if incoming==str(b"H"):
            uart.write("I am happy\r\n")
            rgb[0] = (255, 0, 0)
        elif incoming==str(b"S"):
            uart.write("I am sad\r\n") 
            rgb[0] = (0, 0, 255)
        else:
            uart.write("err\r\n")
            rgb[0] = (0, 0, 0)
        rgb.write()