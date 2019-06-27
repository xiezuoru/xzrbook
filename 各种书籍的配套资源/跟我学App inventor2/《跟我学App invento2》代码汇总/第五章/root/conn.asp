<%
Dim mdb,conn,StrSQL
'连接数据库
Sub openconn()
	mdb="reg.mdb"
	set conn=server.createobject("ADODB.Connection")
	StrSQL="DBQ="&server.mappath(mdb)&";DRIVER={Microsoft Access Driver (*.mdb)};"
	conn.open StrSQL
end sub
'关闭数据库
Sub closeconn()
	conn.close
	Set conn = Nothing
End Sub
'定义一个SafeRequest函数，避免注入漏洞
Function SafeRequest(ParaName)
	Dim ParaValue
	ParaValue=Request(ParaName)
	ParaValue=replace(ParaValue,"'","")
	SafeRequest=ParaValue
End Function
%>