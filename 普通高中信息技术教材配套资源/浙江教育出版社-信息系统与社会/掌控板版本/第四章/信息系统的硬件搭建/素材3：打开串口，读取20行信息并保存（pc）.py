import serial
ser = serial.Serial()
ser.baudrate = 115200
ser.port = 'COM3'
ser.open()
f= open('senser.txt', 'wb')
#读取20行的数据
a=20
while a>0:
	a-=1
	line=ser.readline()
	print(line)
	f.write(line)
f.close()
ser.close()
