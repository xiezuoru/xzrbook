import sqlite3
import datetime
DATABASE = 'data/data.db'
def setup_db():
    db = sqlite3.connect(DATABASE)
    cur = db.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS sensorlog(logid INTEGER PRIMARY KEY autoincrement , sensor1 float,sensor2 float,sensor3 float,sensor4 float,updatetime TimeStamp NOT NULL DEFAULT (datetime('now','localtime')))")
    db.commit()
    cur.execute("SELECT COUNT(*) FROM sensorlog")
    now = datetime.datetime.now()
    now = now.strftime('%Y-%m-%d %H:%M:%S')
    if cur.fetchall()[0][0] == 0:
        cur.execute("INSERT INTO sensorlog(logid,sensor1,sensor2,sensor3,sensor4,updatetime) VALUES(1,22.5,70,300,73,'%s')"%now)
        db.commit()
if __name__ == "__main__":
  setup_db()
