import sqlite3
import datetime
DATABASE = 'data/data.db'
def setup_db():
    db = sqlite3.connect(DATABASE)
    cur = db.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS sensorlist(sensorid INTEGER PRIMARY KEY autoincrement, sensorname text,maxvalue int,minvalue int)")
    cur.execute("CREATE TABLE IF NOT EXISTS sensorlog(logid INTEGER PRIMARY KEY autoincrement , sensorid int,sensorvalue float,updatetime time)")
    db.commit()
    cur.execute("SELECT COUNT(*) FROM sensorlist")
    if cur.fetchall()[0][0] == 0:
        cur.execute('INSERT INTO sensorlist(sensorid,sensorname,maxvalue,minvalue) VALUES(1,"温度传感器",39,5)')
        cur.execute('INSERT INTO sensorlist(sensorid,sensorname,maxvalue,minvalue) VALUES(2,"湿度传感器",80,20)')
        db.commit()
    cur.execute("SELECT COUNT(*) FROM sensorlog")
    now = datetime.datetime.now()
    now = now.strftime('%Y-%m-%d %H:%M:%S')
    if cur.fetchall()[0][0] == 0:
        cur.execute("INSERT INTO sensorlog(logid,sensorid,sensorvalue,updatetime) VALUES(1,1,39,'%s')"%now)
        db.commit()
if __name__ == "__main__":
  setup_db()
