import radio
from microbit import *

uart.init(baudrate=9600, bits=8, parity=None, stop=1)
radio.on()

while True:
  incoming=radio.receive()
  if not(incoming==None):
    display.scroll(incoming)
    if incoming=="A" or incoming=="B" or incoming=="P" or incoming=="E":
      uart.write(incoming)
      uart.write('\n')
