from mpython import *
from machine import UART
display.fill(0)
display.DispChar("开始监听...",0,0)
display.show()
uart = UART(1, 115200, rx=3, tx=1) 
while True:
    if uart.any():
        incoming = str(uart.read())
        display.fill(0)
        display.DispChar(incoming,0,0)
        display.show()
        if incoming==str(b"H"):
            uart.write("I am happy\r\n")
            rgb[0] = (255, 0, 0)
            rgb.write()
        elif incoming==str(b"S"):
            uart.write("I am sad\r\n") 
            rgb[0] = (0, 0, 255)
            rgb.write()
        else:
            uart.write("err\r\n")
            rgb[0] = (0, 0, 0)
            rgb.write()