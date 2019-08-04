import serial
ser = serial.Serial()
#设置通讯波特率，需要与mpython中设定的通讯速率一致
ser.baudrate = 115200
#设置串口号
#ser.port = 'COM3'
ser.port = '/dev/tty.SLAB_USBtoUART'
ser.open()
while True:
    print(ser.readline())
