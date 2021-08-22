import radio
from microbit import *

radio.on()
t=True
while True:
  if button_a.is_pressed():
      if button_b.is_pressed():
        if t==True:
          radio.send("P")
          display.scroll("P")
        else:
          radio.send("E")
          display.scroll("E")
        t=not(t)
      else:
        radio.send("A")
        display.scroll("A")
  else:
    if button_b.is_pressed():
      radio.send("B")
      display.scroll("B")
