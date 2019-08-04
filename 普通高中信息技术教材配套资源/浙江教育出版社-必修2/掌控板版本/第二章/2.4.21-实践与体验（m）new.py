from microbit import *
while True:
    s=input()
    if s=='H':
        display.show(Image.HAPPY)
        print("I am happy")
    elif s=='S':
        display.show(Image.SAD)
        print("I am sad")
    else:
        print("err")