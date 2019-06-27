<!--#include file="JSON_2.0.4.asp"-->
<%
'Dim a(1,1)
'a(0,0) = "zero - zero"
'a(0,1) = "zero - one"
'a(1,0) = "one - zero"
'a(1,1) = "one - one"
'Response.Write toJSON(a)
Dim s(3)
s(0)="2"
s(1)="µçÄÔ"
s(2)="µçÊÓ"
s(3)="ÍøÂç"
Response.Write toJSON(s)
%>