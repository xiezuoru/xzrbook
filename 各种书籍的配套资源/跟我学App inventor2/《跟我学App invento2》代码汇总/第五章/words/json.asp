<!--#include file="conn.asp"-->
<!--#include file="json.inc"-->
<%
'访问地址：http://www.wzms.cn/tot/words/json.asp
'参数：仅一个参数id，数值为数字，如1。
'URL范例：http://www.wzms.cn/tot/words/json.asp?id=1
'数据格式：第一组信息为数字，0表示错误，1以上表示要词语数量。第二组信息为要听写的词语（单词），第三组信息表示“发布人”，如某某老师。第四组信息是任务发布的时间。如果参数有错误，第二组数据为错误信息。
Dim id,count,s1,s2
id=saferequest("id",1)
If id<>"" then
	Set rs=conn.execute("select * from words where id="&id)
	If rs.eof Then
		count="0"
		mystr="请检查编号"
	Else
		'因为使用空格分隔
		mystr=split(rs("words")," ")
		count=UBound(mystr)+1
		s1=rs("publisher")
		s2=rs("addtime")
	End If
	rs.close
	Set conn=nothing
Else
	count="0"
	mystr="编号不能为空"
End If
dim json,jsonStr
set json=new Aien_Json			'定义主json对象
json.JsonType="object"			'json数据结构为对象
json.addData "count",count			'添加数据
json.addData "words",mystr
json.addData "pub",s1
json.addData "addtime",s2
jsonStr=json.getJson(json)		'获取最后生成的json字符串
Response.write jsonStr          '输出
set json=nothing
%>