<!--#include file="conn.asp"-->
<!--#include file="json.inc"-->
<%
'地址：http://www.wzms.cn/tot/words/post.asp
'参数：共2个参数words和pub，数值为文本。words为要听写的词语，用空格分隔，pub为发布人的名称。
'URL范例：http://www.wzms.cn/tot/words/post.asp?words=高兴 愉快&pub=谢老师
'数据格式：第一组信息为数字，0表示错误，1以上表示发布的任务ID。第二组数据为状态信息，如“发布成功，任务编号为：**”。
Dim id,count,s1,s2
words=request("words")
pub=saferequest("pub",0)
If words<>"" And pub<>"" Then
	application.lock
	Application("sql")="Select * from words where id=0"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open Application("sql"),conn,1,3
	rs.addnew
	rs("words")=words
	rs("publisher")=pub
	rs("addtime")=now()
	id=rs("id")
	rs.update
	rs.close
	Set conn=Nothing
	application.unlock
	s1=id:s2="发布成功，任务编号为："&id
Else
	s1="0":	s2="内容或者发布人不能为空！"
End If
dim json,jsonStr
set json=new Aien_Json			'定义主json对象
json.JsonType="object"			'json数据结构为对象
json.addData "count",s1			'添加数据
json.addData "words",s2
jsonStr=json.getJson(json)		'获取最后生成的json字符串
Response.write jsonStr          '输出
set json=nothing
%>