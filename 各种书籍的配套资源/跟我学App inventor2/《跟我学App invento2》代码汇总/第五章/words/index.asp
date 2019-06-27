<!--#include file="conn.asp"-->
<%

id=CLng(request("id"))
Set rs=conn.execute("select * from words where id="&id)
If rs.eof Then
	echo "Ã»ÓÐÕÒµ½£¡"
Else
	echo rs("words")
End If

%>