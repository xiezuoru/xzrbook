from flask import Flask,render_template,request
import sqlite3
import json
db_file="data.db"
real_answer="-"
app=Flask(__name__)
#from flask_cors import CORS  #跨域访问
#CORS(app)
def str_to_json(s):
    s=s.split(":")
    res={}
    res["status"]=str(s[0])
    res["msg"]=s[1]
    res=json.dumps(res,ensure_ascii=False)
    return res

@app.route("/",methods=["GET"])  #显示网页
def web():
    return render_template("aic.html")

@app.route("/test_connect",methods=["POST","GET"]) #测试连接
def test():
    return str_to_json("ok:")

@app.route("/real_ans",methods=["POST","GET"])  #获取(GET)/设置(POST)正确答案
def real_ans():
    global real_answer
    if request.method=="POST" :
        r_ans=request.values.get("r_ans")
        if r_ans is None:
            return str_to_json("error:r_ans")
        real_answer=str(r_ans)
        return str_to_json("success:")
    if request.method=="GET" :
        return str_to_json("success:"+real_answer)

@app.route("/post_ans",methods=["POST","GET"])  #提交答案
def post_ans():
    stu=request.values.get("stu")
    if stu is None:
        return str_to_json("error:stu")
    stu=str(stu)
    ans=request.values.get("ans")
    if ans is None:
        return str_to_json("error:ans")
    elif not ans in ["A","B","C","D"]:
        return str_to_json("error:ans must be A/B/C/D")
    try:
        db=sqlite3.connect(db_file)
        cur=db.cursor()
        cur.execute("select stu from stu_ans where stu='"+stu+"'")
        result=cur.fetchall()
        if len(result)==0:
            cur.execute("insert into stu_ans (stu,ans) values('"+stu+"','"+ans+"')")
        else:
            cur.execute("update stu_ans set ans='"+ans+"' where stu='"+stu+"'")
        db.commit()
        return str_to_json("success:")
    except Exception as e:
        return str_to_json("error:"+str(e))
    finally:
        cur.close()
        db.close()

@app.route("/get_stu_ans",methods=["POST","GET"])  #获取学生答案列表
def get_stu_ans():
    stu=request.values.get("stu")
    where_query=""
    if not stu is None:
        stu=str(stu)
        where_query=" where stu='"+stu+"'"
    try:
        db=sqlite3.connect(db_file)
        cur=db.cursor()
        cur.execute("select * from stu_ans "+where_query+" order by stu")
        result=cur.fetchall()
        results=[]
        fields=cur.description
        column_list=[]
        count=0        
        for f in fields:
            column_list.append(f[0])
        for r in result:
            res={}
            for c in range(len(column_list)):
                res[column_list[c]]=str(r[c])
            results.append(res)
            count=count+1
        rs={}
        rs["status"]="success"
        rs["data_length"]=count
        rs["data"]=results
        jsondata=json.dumps(rs,ensure_ascii=False)
        return jsondata
    except Exception as e:
        return str_to_json("error:"+str(e))
    finally:
        cur.close()
        db.close()      

@app.route("/get_ans_count",methods=["POST","GET"]) #获取答案统计
def get_ans_count():
    try:
        db=sqlite3.connect(db_file)
        cur=db.cursor()
        cur.execute("select ans from stu_ans")
        result=cur.fetchall()
        results={}
        results["A"]=0
        results["B"]=0
        results["C"]=0
        results["D"]=0
        for r in result:
            if r[0]=="A":
                results["A"]=results["A"]+1
            elif r[0]=="B":
                results["B"]=results["B"]+1
            elif r[0]=="C":
                results["C"]=results["C"]+1
            elif r[0]=="D":
                results["D"]=results["D"]+1
        rs={}
        rs["status"]="success"
        rs["total"]=len(result)
        rs["data"]=results
        jsondata=json.dumps(rs,ensure_ascii=False)
        return jsondata
    except Exception as e:
        return str_to_json("error:"+str(e))
    finally:
        cur.close()
        db.close()

@app.route("/clear_all_ans",methods=["POST","GET"]) #清空数据
def clear_all_ans():
    try:
        db=sqlite3.connect(db_file)
        cur=db.cursor()
        cur.execute("delete from stu_ans")
        db.commit()
        return str_to_json("success:")
    except Exception as e:
        return str_to_json("error:"+str(e))
    finally:
        cur.close()
        db.close()

if __name__=="__main__":
    app.run(host="0.0.0.0",port=8080,threaded=True)
