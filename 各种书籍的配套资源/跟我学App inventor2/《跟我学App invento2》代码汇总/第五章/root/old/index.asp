<!--#include file=conn.asp -->
<!--#include file=config.asp -->
<%
'接口
'appid为应用程序的名称,action分为六种:查询1,登陆2,添加3,修改4,更新分数5,总体查询6
'输出信息（前两个字符）:ok或者no,后面则为具体的信息。
'查询格式:index.asp?appid=1&regname=xzr&action=1
'如果存在顺便输出分数
'登陆格式:index.asp?appid=1&regname=xzr&regpass=123&action=2
'添加格式:index.asp?appid=1&regname=xzr&regpass=123&action=3
'修改格式:index.asp?appid=1&regname=xzr&regpass=123&newregpass=321&action=4
'更新分数格式（返回统计情况）:index.asp?appid=1&regname=xzr&score=99&action=5
'查询格式（返回注册用户和分数情况）:index.asp?appid=1&action=6
'注册用户:*;有效分数（大于0）:*;平均分数:*;最高分:*;最低分:*;

Dim appid,regname,regpass,action
appid=SafeRequest("appid",1)
regname=SafeRequest("regname",0)
regpass=SafeRequest("regpass",0)
action=Request("action")
If appid<>"" Then 
Call openconn()
'查询
If action="1" Then
	If regname<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		'echo sql
		Set rs=conn.execute(sql)
		If Not(rs.eof or rs.bof) Then
			echo "ok,分数:"& rs("score")
		Else
			echo "no,用户不存在！"
		End If
		rs.close
	Else
		echo "no,用户名不能为空！"
	End if
End If
'登陆
If action="2" Then
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If Not (rs.eof Or rs.bof) Then
			'sql="update reg set count=count+1,logintime='" & now() &"' where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
			'conn.execute(sql)
			rs("count")=rs("count")+1
			rs("logintime")=now()
			rs.update
			echo "ok,登陆成功！"
		Else
			echo "no,登陆失败！"
		End If
		rs.close
	Else
		echo "no,用户名或者密码不能为空！"
	End if
End If
'注册
If action="3" Then
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			'conn.execute("insert into reg (regname,regpass,appid) values ('" & regname & "','" & regpass & "'," & appid &")")
			rs.addnew
			rs("regname")=regname
			rs("regpass")=regpass
			rs("appid")=appid
			rs.update
			echo "ok,注册成功！"
		Else
			echo "no,注册失败！"
		End If
		rs.close
	Else
		echo "no,用户名或者密码不能为空！"
	End if
End If
'修改
If action="4" Then
	If regname<>"" and regpass<>"" Then
		newregpass=SafeRequest("newregpass",0)
		If newregpass<>"" then
			sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
			Set rs= Server.CreateObject("ADODB.Recordset")
			rs.open sql,conn,1,3
			If Not (rs.eof Or rs.bof) Then
				'sql="update reg set regpass='"& newregpass &"',logintime='" & now() &"' where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
				rs("regpass")=newregpass
				rs("logintime")=now()
				rs.update
				echo "ok,密码修改成功！"
			Else
				echo "no,密码修改失败,请检查用户名和原密码！"
			End If
		Else
			echo "no,新密码不能为空！"		
		End if
		rs.close
	Else
		echo "no,用户名或者密码不能为空！"
	End If
End If
'更新分数,返回总情况
If action="5" Then
score=SafeRequest("score",1)
	If regname<>"" And score<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			'如果用户不存在，就添加
			rs.addnew
			rs("regname")=regname
			rs("regpass")="123456"
			rs("appid")=appid
		End If
		'sql="update reg set score="& score &" where regname='" & regname & "' and appid="&appid
		rs("score")=score
		rs.update
		rs.close
		Set rs=conn.execute("select count(regid) as c0 from reg where score>" & score &" and appid="& appid)
		c=rs(0)+1
		Set rs=conn.execute("select count(regid) as c1,max(score) as c2 ,min(score) as c3,avg(score) as c4  from reg where score>0 and appid="& appid)
		echo "ok,更新成功！名次:"& c &";有效分数:"& rs(0) &";最高:"& rs(1) &";最低:"& rs(2) &";平均:"& rs(3)
		rs.close
	Else
		echo "no,用户名或者参数不能为空！"
	End if
End If
'综合查询（appid）
'注册用户:*;有效分数（大于0）:*;平均分数:*;最高分:*;最低分:*;
If action="6" Then
	sql="Select count(*) as c from reg where appid="&appid
	Set rs=conn.execute(sql)
	c=rs(0)
	Set rs=conn.execute("select count(regid) as c1,max(score) as c2 ,min(score) as c3,avg(score) as c4  from reg where score>0 and appid="& appid)
	echo "ok,注册人数:"& c &";有效分数:"& rs(0) &";最高:"& rs(1) &";最低:"& rs(2) &";平均:"& rs(3)
	rs.close
End If

Call closeconn()
else
	'response.redirect("index.htm")
	echo "no,Appid不能为空！"
End if
%>
