<!--#include file="includes/securitycheck1.inc"-->
<%
If strProfile <> "ADMIN" Then
  response.Redirect("noautorizado.asp")
End If
strHeader = "headerEuro2021.jpg"
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>La quiniela Cantv.net: Administración</title>
<link rel="shortcut icon" href="favicon.ico" >
</head>

<body topMargin="0" leftMargin="1">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr><!--#include file="includes/header.asp"--></tr>
<tr>
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <td width="10%" valign="top"><!--#include file="includes/leftbar.asp"--></td>
    <td width="90%" valign="top" align="left">
      <table border="0" cellspacing="0" cellpadding="10" width="100%">
      <td>
<!------------------------------------------------------------------------->

<%
      Dim rsAdmins
      
      'cntDB.Open dsn
      Set rsAdmins = Server.CreateObject("ADODB.Recordset")
      sql = "SELECT email,name,lastname,alias,phone,mobile FROM users WHERE profile = 'ADMIN' ORDER BY name,lastname"
      rsAdmins.Open sql,cntDB,3,3
%>
<font face="Verdana" color="#0000FF">
<b>Administradores actuales (seleccione al administrador a desactivar): <%=rsAdmins.RecordCount%></b><br>
</font>      

<table border="1" cellspacing="0" cellpadding="2" width="75%">
<tr>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>alias</b></center></font></td>
  <td bgcolor="#3366CC" width="25%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>email</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Nombre</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Apellido</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Teléfono</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Celular</b></center></font></td>
</tr>
<%
      Do while not rsAdmins.EOF
%>
<tr>
  <td><font face="Verdana" size="1"><a href="/quiniela/inoutadmin.asp?usr=<%=rsAdmins.Fields("alias")%>&action=OUT"><%=rsAdmins.Fields("alias")%></a></font></td>
  <td><font face="Verdana" size="1"><a href="mailto:<%=rsAdmins.Fields("email")%>"><%=rsAdmins.Fields("email")%></a></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("name")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("lastname")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("phone")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("mobile")%></font></td>
</tr>
<%
        rsAdmins.MoveNext
      loop
      rsAdmins.Close
%>
</table>
<br>
<%
      
      sql = "SELECT email,name,lastname,alias,phone,mobile FROM users WHERE profile <> 'ADMIN' ORDER BY name,lastname"
      rsAdmins.Open sql,cntDB,3,3
%>
<font face="Verdana" color="#0000FF">
<b>Usuarios que no son administradores (seleccione el usuario que desea añadir): <%=rsAdmins.RecordCount%></b><br>
</font>
<table border="1" cellspacing="0" cellpadding="2" width="75%">
<tr>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>alias</b></center></font></td>
  <td bgcolor="#3366CC" width="25%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>email</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Nombre</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Apellido</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Teléfono</b></center></font></td>
  <td bgcolor="#3366CC" width="15%"><font face="Verdana" size="1" color="#FFFFFF"><center><b>Celular</b></center></font></td>
</tr>
<%
      Do while not rsAdmins.EOF
%>
<tr>
  <td><font face="Verdana" size="1"><a href="/quiniela/inoutadmin.asp?usr=<%=rsAdmins.Fields("alias")%>&action=IN"><%=rsAdmins.Fields("alias")%></a></font></td>
  <td><font face="Verdana" size="1"><a href="mailto:<%=rsAdmins.Fields("email")%>"><%=rsAdmins.Fields("email")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("name")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("lastname")%></font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("phone")%>&nbsp</font></td>
  <td><font face="Verdana" size="1"><%=rsAdmins.Fields("mobile")%>&nbsp</font></td>
</tr>
<%
        rsAdmins.MoveNext
      loop
      rsAdmins.Close
       sql = "UPDATE ROUNDRANGEDATES SET FECHAINICIO=DATE() WHERE IDRONDA=4"
      'RESPONSE.WRITE sql
      cntDB.Execute sql
      cntDB.Close
      
     
    %>
</table>

<!------------------------------------------------------------------------->

      </td>
      </table>
    </td>
  </table>
</tr>  
<tr>
  <img border="0" align="top" src="/quiniela/images/footerEuro2021.jpg">
</tr>

</table>

</body>

</html>
