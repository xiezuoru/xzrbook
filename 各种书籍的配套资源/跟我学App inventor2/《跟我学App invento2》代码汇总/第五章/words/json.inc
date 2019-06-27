<%
'艾恩Asp生成Json数据类，谢作如修改版,2016.2
class Aien_Json
	private mCollection,mJsonType
	Public Property Get Collection()
		set Collection = mCollection
	End Property
	
 	Public Property Let JsonType(mData)
		if lcase(mData)="object" then
			mJsonType = true
		elseif lcase(mData)="array" then
			mJsonType = false
		end if
	End Property
	
 	Public Property Get JsonType()
			JsonType=mJsonType
	End Property
	
	Private Sub Class_Initialize()
		set mCollection=server.createobject("scripting.dictionary")
	End Sub

	Private Sub Class_Terminate()
		mCollection.removeAll()
		set mCollection=nothing
	End Sub
	
	public function addData(vars,values)
		if mCollection.exists(vars) then
			mCollection(vars)=mCollection(vars) & "," & values
		else
			mCollection.add vars,values
		end if
	end function
	
	Private function toJson(vars) 
		dim values
		if lcase(typename(vars))="aien_json" then
			set values=vars
		else
			values=vars
		end if
		dim aryStr
		dim vType:vType=lcase(typename(values))
		select case vType
			case "string"
				toJson="""" & jsEncode(values) & """"
			case "boolean"
				toJson="" & lcase(values) & ""
			case "date"
				toJson="""" & cstr(values) & """"
			case "empty"
				toJson="""Empty"""
			case "null"
				toJson="""Null"""
			case "nothing"
				toJson="""Nothing"""
			case "aien_json"
				toJson=getJson(values)
			case else
				if isnumeric(values) then
					toJson="" & cstr(values) & ""
				elseif isarray(values) then
					dim aStr:aStr="["
					for i=0 to ubound(values)
						aStr=aStr & toJson(values(i))
						if i<ubound(values) then aStr=aStr & ","
					next
					toJson="" & aStr & "]"
				else
					toJson="""" & cstr(values) & """"
				end if
		end select
	end function
	
	public function getJson(byval jsonObj)
		dim col:set col=jsonObj.Collection
		dim mJson
		if jsonObj.JsonType then mJson="{" else mJson="["
		for each vars in col
			if jsonObj.JsonType then 
				mJson=mJson & """" & vars & """"& ":" & toJson(col(vars))
			else
				mJson=mJson & toJson(col(vars))
			end if
			col.remove(vars)
			if col.count>0 then  mJson=mJson & ","
		next
		if jsonObj.JsonType then mJson=mJson & "}" else mJson=mJson & "]"
		getJson=mJson
	end function
	
	Private Function jsEncode(str)
		Dim i, j, aL1, aL2, c, p

		aL1 = Array(&h22, &h5C, &h2F, &h08, &h0C, &h0A, &h0D, &h09)
		aL2 = Array(&h22, &h5C, &h2F, &h62, &h66, &h6E, &h72, &h74)
		For i = 1 To Len(str)
			p = True
			c = Mid(str, i, 1)
			For j = 0 To 7
				If c = Chr(aL1(j)) Then
					jsEncode = jsEncode & "\" & Chr(aL2(j))
					p = False
					Exit For
				End If
			Next

			If p Then 
				Dim a
				a = AscW(c)
				If a > 31 And a < 127 Then
					jsEncode = jsEncode & c
				ElseIf a > -1 Or a < 65535 Then
					jsEncode = jsEncode & "\u" & String(4 - Len(Hex(a)), "0") & Hex(a)
				End If 
			End If
		Next
	End Function
end class
%>