<!--#include file="includes/securitycheck1.inc"-->
<%
  strHeader = "HeaderEuro2021.jpg" 
  If strProfile = "NORMAL" then
    strModif = "disabled"
    strUserID = Session("userid")
  Else
    strModif = ""
    strUserID = request.QueryString("alias")
  End If
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>La quiniela Cantv.net: Cambio de password</title>
<link rel="shortcut icon" href="favicon.ico" >
</head>

<SCRIPT LANGUAGE="JavaScript">
function getuser()
{
	strUserID = prompt('Usuario:','')
	return strUserID
}

function validate()
{
  sAlias = document.frmCambiar.alias.value
  sPass  = document.frmCambiar.password.value
  sPass2 = document.frmCambiar.password2.value
  sEmail = document.frmCambiar.email.value
  sName  = document.frmCambiar.name.value
  sLName = document.frmCambiar.lastname.value
  if ((sAlias.length < 1)||(sPass.length < 1)||(sPass2.length < 1)||(sEmail.length < 1)||(sName.length < 1)||(sLName.length < 1))
  {
    alert("Debe llenar los valores obligatorios")
    return false
  }
  else
  {
    return true
  }
}
</script>

<body topMargin="0" leftMargin="1">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr><!--#include file="includes/header.asp"--></tr>
<tr>
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <td width="10%" valign="top"><!--#include file="includes/leftbar.asp"--></td>
    <td width="90%" valign="top" align="left">
      <table border="0" cellspacing="0" cellpadding="10" width="100%">
      <td>
<!------------------------------------------------------------------------------->      

<% 
If request.Form("flag") = "1" Then

  Dim rsValid, rsValid2

  strEmail     = lcase(Request.Form("email"))
  strPassword  = Request.Form("password")
  strPassword2 = Request.Form("password2")
  strAlias     = Request.Form("aliash")
  strUserID    = strAlias
  If strModif = "" Then
	  strName      = Request.Form("name")
	  strLastName  = Request.Form("lastname")
	  strPhone     = Request.Form("phone")
	  strMobile    = Request.Form("mobile")
  End If

  If strPassword = strPassword2 Then
    If strModif = "disabled" Then
    	sql = "UPDATE users SET password='" & strPassword & "' WHERE alias='" & strAlias & "'"
    Else
    	sql = "UPDATE users SET email='" & strEmail & "',password='" & strPassword & "',name='" & strName & "',lastname='" & strLastName & "',phone='" & strPhone & "',mobile='" & strMobile & "' WHERE alias='" & strAlias & "'"
    End If
    cntDB.Execute sql
    strErrorMsg = "Su clave ha sido actualizada"
  Else
    strErrorMsg = "Las claves no son iguales"
  End If
Else 
  strErrorMsg = "&nbsp"
End If
%>

<font color="#FF0000" face="Verdana" size="3"><b><%=strErrorMsg%></b></font><br>

<%
    Dim rsUser
    
    Set rsUser = Server.CreateObject("ADODB.Recordset")
    sql = "SELECT * FROM users WHERE (alias='" & strUserID &"')"
    rsUser.Open sql,cntDB,3,3

    If not rsUser.EOF Then
%>

  <font face="Verdana">
  <form name="frmCambiar" method="POST" action="chgpasswd.asp" onsubmit="return validate()">
  <table border="0" width="75%">
    <tr>
      <td width="25%" bgcolor="#C0C0C0"><b>&nbsp;Alias</b></font></td>
      <td width="35%" bgcolor="#C0C0C0">
        <input name="alias" disabled size="30%" value="<%=rsUser.Fields("alias")%>" style="font-family: Verdana; background-color: #EEEDEA">
        <input name="aliash" type="hidden" value="<%=rsUser.Fields("alias")%>">
      </td>
      <td width="40%" bgcolor="#FFFF80"><font size="1">El identificador para ingresar a la quiniela es este alias</font></td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Email</b></font></td>
      <td bgcolor="#C0C0C0"><input name="email" <%=strModif%> size="30%" value="<%=rsUser.Fields("email")%>" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Solo será utilizada para enviarle información importante acerca de las quinielas</font></td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Clave de Acceso</b></font></td>
      <td bgcolor="#C0C0C0"><input type="password" name="password" size="30%" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Clave de acceso o password a utilizar para ingresar a la quiniela</font></td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Repetir Clave</b></font></td>
      <td bgcolor="#C0C0C0"><input type="password" name="password2" size="30%" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Repita su clave de acceso para evitar errores</font></td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Nombre</b></font></td>
      <td bgcolor="#C0C0C0"><input name="name" <%=strModif%> size="30%" value="<%=rsUser.Fields("name")%>" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Se desplegará en la clasificación de las quinielas</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Apellido</b></font></td>
      <td bgcolor="#C0C0C0"><input name="lastname" <%=strModif%> size="30%" value="<%=rsUser.Fields("lastname")%>" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Se desplegará en la clasificación de las quinielas</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Teléfono de Contacto</b></td>
      <td bgcolor="#C0C0C0"><input name="phone" <%=strModif%> size="30%" value="<%=rsUser.Fields("phone")%>" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Para ser utilizado en caso de necesitar contactarlo</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Teléfono Celular</b></td>
      <td bgcolor="#C0C0C0"><input name="mobile" <%=strModif%> size="30%" value="<%=rsUser.Fields("mobile")%>" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Para ser utilizado en caso de necesitar contactarlo</td>
    </tr>
    
  </table>
  <input type="submit" value="Actualizar" name="update">
  <input type="hidden" value="1" name="flag">
  </form>
  </font>
<%        
    End If
%>    

<!------------------------------------------------------------------------------->      
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
