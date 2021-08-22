from mpython import *
import network
import urequests
import ujson

my_wifi = wifi()

my_wifi.connectWiFi('jf', '20040404')
url = 'http://192.168.199.235:8080'
stu="STU001"
rsp = urequests.get(url + '/test_connect')
d = rsp.json()
oled.fill(0)
if d["status"]=="ok":
    oled.DispChar("服务器连接成功..",0,0,)
    oled.DispChar("学生："+stu,0,16,)
    oled.DispChar("触摸选择答案，B键提交..",0,32,)
    ans="A"
    while 1:
        if touchPad_P.read()<400:
            ans="A"
        elif touchPad_Y.read()<400 or touchPad_T.read()<400:
            ans="B"
        elif touchPad_H.read()<400 or touchPad_O.read()<400:
            ans="C"
        elif touchPad_N.read()<400:
            ans="D"
        oled.DispChar(ans,0,48,)
        if button_b.value()==0:
            rsp = urequests.get(url + '/post_ans?stu=' + stu +'&ans='+ ans)
            d = rsp.json()
            if d["status"]=="success":
                oled.DispChar("答案提交成功！",12,48,)
        oled.show()        
                