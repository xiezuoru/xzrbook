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
    cur.execute("SELECT * FROM sensorlog")
    data = cur.fetchall()
    cur.close()
    db.close()
    temp1 = data[len(data) - 1]
    return render_template('index.html', sensor1=temp1[1], sensor2=temp1[2], sensor3=temp1[3], sensor4=temp1[4])

#Get data
@app.route("/get",methods=['GET'])
def get_data():
    return '0'

#Adding data
@app.route("/input",methods=['POST','GET'])
def add_data():
    try:
        if request.method == 'POST':
            sensorvalue = request.form.get('val')
        else:
            sensorvalue = request.args.get('val')
        ss=sensorvalue.split(',')
        if len(ss)==4:
            nowtime = datetime.datetime.now()
            nowtime = nowtime.strftime('%Y-%m-%d %H:%M:%S')
            db = sqlite3.connect(DATABASE)
            cur = db.cursor()
            cur.execute("INSERT INTO sensorlog(sensor1,sensor2,sensor3,sensor4,updatetime) VALUES(%f,%f,%f,%f,'%s')" %(float(ss[0]),float(ss[1]),float(ss[2]),float(ss[3]),nowtime))
            db.commit()
            db.close()
            return '1'
        else:
            return '0'
    except:
        return '0'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080,debug=True)
