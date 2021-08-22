import win32api
import win32con
import serial
import time
ser = serial.Serial()
#设置通讯波特率
ser.baudrate = 9600
#设置串口号
ser.port = 'COM3'
ser.open()
while True:
        incoming=ser.readline()
        incoming=incoming.strip()
        print(incoming)
        print(type(incoming))
        incoming=incoming.decode("gb2312")
        print(type(incoming))
        if incoming=='A':            
            win32api.keybd_event(37,0,0,0)  #左移键的键位码是37
            win32api.keybd_event(37,0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='B':            
            win32api.keybd_event(39,0,0,0)  #右移键的键位码是39
            win32api.keybd_event(39,0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='E':            
            win32api.keybd_event(27,0,0,0)  #ESC的键位码是27
            win32api.keybd_event(27,0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='P':            
            win32api.keybd_event(116,0,0,0)  #F5的键位码是116
            win32api.keybd_event(116,0,win32con.KEYEVENTF_KEYUP,0) #释放按键
