import serial
ser = serial.Serial()
ser.baudrate = 115200
#串口号以实际值为准，不同电脑不一样
ser.port = 'COM3'
#ser.port = '/dev/tty.SLAB_USBtoUART'
ser.open()
