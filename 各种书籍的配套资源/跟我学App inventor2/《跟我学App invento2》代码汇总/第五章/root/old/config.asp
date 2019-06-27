<%
Function SafeRequest(ParaName,ParaType)
Dim ParaValue
ParaValue=Request(ParaName)
if ParaValue<>"" then
If ParaType=1 then
If not isNumeric(ParaValue) then
Response.write "no，参数" & ParaName & "必须为数字型！"
Response.end
End if
Else
ParaValue=replace(ParaValue,"'","''")
ParaValue=replace(ParaValue,";","")
ParaValue=replace(ParaValue," ","")
End if
SafeRequest=ParaValue
else
SafeRequest=""
end if
End function

sub mygoto(str,url)
zjcss.mygoto str,url
response.end
end sub

'''''''''显示错误
Sub chkErr(Err) 
If Err Then
echo "<style>body{margin:8;border:none;overflow:hidden;background-color:buttonface;}</style>"
echo "<br/><font size=2><li>错误: " & Err.Description & "</li><li>错误源: " & Err.Source & "</li><br/>"
Err.Clear
Response.End
End If
End Sub

'''''''''输出
Sub echo(str)
Response.Write(str)
End Sub

sub copyright()
zjcss.copyright()
end sub

'**************************************************
'过程名：showpage
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'**************************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table align='center'><tr><td>"
	if ShowTotal=true then 
		strTemp=strTemp & "共 <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "首页 上一页&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=1'>首页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>上一页</a>&nbsp;"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "下一页 尾页"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>下一页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & n & "'>尾页</a>"
  	end if
   	strTemp=strTemp & "&nbsp;页次：<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/页"
	if ShowAllPages=True then
		strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange=""javascript:window.location='" & strUrl & "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">第" & i & "页</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub
'**************************************************
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
'**************************************************
function JoinChar(Urlstr)
if Urlstr="" then
	JoinChar=""
	exit function
end if
if InStr(Urlstr,"?")<len(Urlstr) then 
	if InStr(Urlstr,"?")>1 then
		if InStr(Urlstr,"&")<len(Urlstr) then 
			JoinChar = Urlstr & "&"
		else
			JoinChar = Urlstr
		end if
	else
		JoinChar = Urlstr & "?"
	end if
else
	JoinChar = Urlstr
end if
end function

'防止SQL注入,处理批量的id
Function FilterIDs(byval strIDs)
	Dim arrIDs,i,strReturn
	strIDs=Trim(strIDs)
	If Len(strIDs)=0  Then Exit Function
	arrIDs=Split(strIDs,",")
	For i=0 To Ubound(arrIds)
		If IsNumeric(arrIDs(i)) Then
			strReturn=strReturn & "," & Int(arrIDs(i))
		End If
	Next
	If Left(strReturn,1)="," Then strReturn=Right(strReturn,Len(strReturn)-1)
	FilterIDs=strReturn
End Function

'''判断某变量是否存在于某字符串中
'参数说明：id:变量，str:字符串，fg:分隔符
Function iscunzai(id,str,fg)
mystr=split(str,fg)
iscunzai=0
for i=0 to UBound(mystr)   
   if trim(mystr(i))=cstr(id) then
   iscunzai=1
   exit for
   end if   
next
End Function
%>