import siot
import time

SERVER = "127.0.0.1"            #MQTT服务器IP
CLIENT_ID = ""                  #在SIoT上，CLIENT_ID可以留空
IOT_pubTopic  = 'ailab/sensor1'       #“topic”为“项目名称/设备名称”
IOT_UserName ='siot'            #用户名
IOT_PassWord ='dfrobot'         #密码

siot.init(CLIENT_ID, SERVER, user=IOT_UserName, password=IOT_PassWord)
siot.connect()
siot.loop()

tick = 0

try:
    while True:
        siot.publish(IOT_pubTopic, "value %d"%tick)
        time.sleep(1)           #隔1秒发送一次
        tick = tick+1
except:
   siot.stop()
   print("disconnect seccused")