<!--#include file="includes/securitycheck1.inc"-->
<%
If strProfile <> "ADMIN" Then
  response.Redirect("noautorizado.asp")
End If
%>
<%
  Dim rsAdmins
  
  Set rsAdmins = Server.CreateObject("ADODB.Recordset")
  If Request.QueryString("action") = "IN" Then
	sql = "UPDATE users SET profile='ADMIN' WHERE alias='" & Request.QueryString("usr") & "'"
  Else
    sql = "UPDATE users SET profile='NORMAL' WHERE alias='" & Request.QueryString("usr") & "'"
  End If
  cntDB.Open dsn
  cntDB.Execute sql
  cntDB.Close
  response.Redirect("administrator.asp")
%>