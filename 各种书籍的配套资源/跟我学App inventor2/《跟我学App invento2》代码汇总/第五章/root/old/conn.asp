<%
Dim mdb,conn,StrSQL
Sub openconn()
	mdb="reg.mdb"
	set conn=server.createobject("ADODB.Connection")
	StrSQL="DBQ="&server.mappath(mdb)&";DRIVER={Microsoft Access Driver (*.mdb)};"
	'On Error Resume Next
	conn.open StrSQL
end sub

Sub closeconn()
	'If Err Then
	'Err.clear
	conn.close
	Set conn = Nothing
End sub
%>