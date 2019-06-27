<!--#include file=conn.asp -->
<!--#include file="json.inc"-->
<%
Dim regname,regpass,action,s1,s2
regname=SafeRequest("u")
regpass=SafeRequest("p")
action=Request("a")
Call openconn()
If action="1" Then '注册
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where regname='" & regname & "'"
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			rs.addnew
			rs("regname")=regname
			rs("regpass")=regpass
			rs("regtime")=now()
			rs("count")=0
			rs.update
			s1="1":s2="注册成功！"
		Else
			s1="0":s2="注册失败,用户名已经存在！"
		End If
		rs.close
	Else
		s1="0":s2="注册失败,用户名或者密码不能为空！"
	End if
Elseif action="2" Then '登陆
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "')"
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If Not (rs.eof Or rs.bof) Then
			rs("count")=rs("count")+1
			rs("logintime")=now()
			rs.update
			s1="1":s2="登录成功,登录次数:"& rs("count")
		Else
			s1="0":s2="登录失败!"
		End If
		rs.close
	Else
		s1="1":s2="登陆失败，用户名或者密码不能为空!"
	End If
Else
	s1="0":s2="缺少必要的参数!"
End If
Call closeconn()

dim json,jsonStr
set json=new Aien_Json			'定义主json对象
json.JsonType="object"			'json数据结构为对象
json.addData "errNum",s1		'添加数据
json.addData "errMsg",s2
jsonStr=json.getJson(json)		'获取最后生成的json字符串
Response.write jsonStr          '输出
set json=nothing
%>