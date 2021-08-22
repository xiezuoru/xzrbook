import win32api
import win32con
import serial
import time
print("电脑魔法控制器-串口应用程序欢迎你！")
print("本程序支持PPT播放，太空弹球。")
ten=input('输入1选择PPT播放，输入2选择太空弹球：')
ser = serial.Serial()
#设置通讯波特率
ser.baudrate = 115200
#设置串口号
ser.port = 'COM3'
ser.open()
if ten=='1':
    keylist=(37,39,27,116);
    print("当前状态：控制PPT播放……")
else:
    keylist=(37,39,27,116);
    print("当前状态：控制太空弹球……")
while (1):
        incoming=ser.readline()
        incoming=incoming.strip()
        incoming=incoming.decode("gb2312")
        print(incoming)
        if incoming=='A':            
            win32api.keybd_event(keylist[0],0,0,0)  #左移键的键位码是37
            win32api.keybd_event(keylist[0],0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='B':            
            win32api.keybd_event(keylist[1],0,0,0)  #右移键的键位码是39
            win32api.keybd_event(keylist[1],0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='E':            
            win32api.keybd_event(keylist[2],0,0,0)  #ESC的键位码是27
            win32api.keybd_event(keylist[2],0,win32con.KEYEVENTF_KEYUP,0) #释放按键
        if incoming=='P':            
            win32api.keybd_event(keylist[3],0,0,0)  #F5的键位码是116
            win32api.keybd_event(keylist[3],0,win32con.KEYEVENTF_KEYUP,0) #释放按键
