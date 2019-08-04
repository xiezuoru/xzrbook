# coding= UTF-8
import sqlite3
import datetime
import json
from flask import Flask,render_template, request
DATABASE = 'data/data.db'
app = Flask(__name__)
@app.route("/")
def hello():
    db = sqlite3.connect(DATABASE)
    cur = db.cursor()
    cur.execute("SELECT * FROM sensorlog WHERE sensorid =1")
    data = cur.fetchall()
    cur.close()
    db.close()
    temp1 = data[len(data) - 1]
    temp=temp1[2]
    return render_template('vews.html', data=data,temp=temp)

#Get data
@app.route("/get",methods=['GET'])
def get_data():
    sensorid=int(request.args.get('id'))
    db = sqlite3.connect(DATABASE)
    cur = db.cursor()
    cur.execute("SELECT * FROM sensorlog WHERE sensorid = %s"% sensorid)
    data = cur.fetchall()
    dbsum=len(data)
    dset={'sensorid':sensorid}
    temp=[]
    for i in range(dbsum):
        value={}
        value['sensorvalue']=data[i][2]
        value['updatetime']=data[i][3]
        temp.append(value)
        #dset['value']={'sensorvalue':data[i-1][2],'updatetime':data[i-1][3]}
    dset['value']=temp
    djson=json.dumps(dset)
    return djson

#Adding data
@app.route("/input",methods=['POST','GET'])
def add_data():
    if request.method == 'POST':
        sensorid = int(request.form.get('id'))
        sensorvalue = float(request.form.get('val'))
    else:
        sensorid = int(request.args.get('id'))
        sensorvalue = float(request.args.get('val')) 
    nowtime = datetime.datetime.now()
    nowtime = nowtime.strftime('%Y-%m-%d %H:%M:%S')
    db = sqlite3.connect(DATABASE)
    cur = db.cursor()
    cur.execute("INSERT INTO sensorlog(sensorid,sensorvalue,updatetime) VALUES(%d,%f,'%s')" %(sensorid,sensorvalue,nowtime) )
    db.commit()
    cur.execute("SELECT * FROM sensorlist where sensorid = %d"% sensorid)
    rv = cur.fetchall()
    cur.close()
    db.close()
    maxrv = rv[0][2]
    minrv = rv[0][3]
    if sensorvalue > maxrv or sensorvalue < minrv:
        return '1'
    else:
        return '0'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080,debug=True,threaded=True)
