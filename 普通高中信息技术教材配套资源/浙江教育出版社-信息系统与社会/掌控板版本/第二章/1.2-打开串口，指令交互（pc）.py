import serial,time
ser = serial.Serial()
ser.baudrate = 115200
#ser.port = 'COM3'
ser.port = '/dev/tty.SLAB_USBtoUART'
ser.open()
while True:
    name=input()
    ser.write(name.encode())
    line = ser.readline()
    print(line.strip().decode())