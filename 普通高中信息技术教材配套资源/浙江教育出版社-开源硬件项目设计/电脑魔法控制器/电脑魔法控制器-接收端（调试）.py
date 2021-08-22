import radio
from microbit import *

radio.on()

while True:
  if button_a.get_presses():
    print("A")
  if button_b.get_presses():
    print("B")
  incoming=radio.receive()
  if not(incoming==None):
    display.scroll(incoming)
    if incoming=="A" or incoming=="B" or incoming=="P" or incoming=="E":
      print(incoming)
