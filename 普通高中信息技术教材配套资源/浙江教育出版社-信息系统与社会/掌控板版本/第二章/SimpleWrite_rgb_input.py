from mpython import *

while True:
    
    s = input("Input the Color(r/g/b):")
    display.fill(0)
    display.DispChar(s,0,0)
    display.show()
    if s=="r":
        rgb[0]=(255,0,0)
    if s=="g":
        rgb[0]=(0,255,0)
    if s=="b":
        rgb[0]=(0,0,255)
    rgb.write()