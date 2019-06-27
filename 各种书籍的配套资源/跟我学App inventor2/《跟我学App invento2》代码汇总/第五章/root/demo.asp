<!--#include file="json.inc"-->
<%
mystr=split("a b c d e f"," ")

dim json,json1,json2,json3,jsonStr
set json=new Aien_Json				'定义主json对象
json.JsonType="object"				'json数据结构为对象
json.addData "name","anlige"		'添加数据
json.addData "isboy",true
json.addData "age",23
json.addData "luckyNumber",Array(34,31,42)
json.addData "words",mystr

set json2=new Aien_Json				'定义一个json子对象
json2.JsonType="object"				'数据结构为对象
json2.addData "wife","Tandy"		'添加数据
json2.addData "school","OUC"
	
set json3=new Aien_Json				'定义一个json子对象
json3.JsonType="object"				'数据结构为对象
json3.addData "chinese",85			'添加数据
json3.addData "english",90
		
set json1=new Aien_Json				'定义一个json子对象
json1.JsonType="array"				'数据结构为数组
json1.addData "color1","green"		'添加数据
json1.addData "color2","red"

json2.addData "classes",json3		'把json3添加到json2中，键名为classes	
json.addData "colors",json1			'把json1添加到json中，键名为colors
json.addData "others",json2			'把json2添加到json中，键名为others

jsonStr=json.getJson(json)			'获取最后生成的json字符串，本函数只有第一次调用有效
Response.write jsonStr
set json3=nothing
set json2=nothing
set json1=nothing
set json=nothing
%>
