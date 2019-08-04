import serial,time
ser = serial.Serial()
ser.baudrate = 115200
ser.port = 'COM3'
#ser.port = '/dev/tty.SLAB_USBtoUART'
ser.open()
while True:
    time.sleep(1)
    ser.write('H'.encode())
    line = ser.readline()
    print(line.strip().decode())
    time.sleep(1)
    ser.write('S'.encode())
    line = ser.readline()
    print(line.strip().decode())