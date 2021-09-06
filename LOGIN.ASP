<% strHeader = "HeaderEuro2021.jpg" %>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Acceso a la quiniela</title>
<link rel="shortcut icon" href="favicon.ico" >
</head>

<SCRIPT LANGUAGE="JavaScript">
function validate()
{
  sLogin = document.frmLogin.login.value
  sPass  = document.frmLogin.password.value
  if ((sLogin.length < 1)||(sPass.length < 1))
  {
    alert("Por favor introduzca su login y password")
    return false
  }
  else
  {
    return true
  }
}
</script>

<body topMargin="0">
<table border="0" cellspacing="0" cellpadding="0">
<tr><!--#include file="includes/header.asp"--></tr>
<tr>
  <td><center><font color="#FF0000"><b>
<%
Dim strLogin,strPassword
Dim rsLogin
Dim strDBProfile, strDBPassword

strLogin = lcase(Request.Form("login"))
strPassword = Request.Form("password")
If strLogin <> "" Then
%>
  <!--#include file="includes/opendb.inc"-->
<%
  Set rsLogin = Server.CreateObject("ADODB.Recordset")
  sql = "SELECT * FROM users WHERE (alias='" & strLogin &"')"
  rsLogin.Open sql,cntDB,3,3

  If rsLogin.EOF Then
    response.Write("Login o password inválido")
  Else
    strDBProfile = rsLogin("profile")
    strDBPassword = rsLogin("password")
    If strDBPassword = strPassword Then
      rsLogin.Close
      cntDB.Close
      Session.Timeout = 20
      Session("userid") = strLogin
      response.redirect("main.asp")
    Else
      response.Write("Login o password inválido")
    End If
  End If

  rsLogin.Close
  cntDB.Close

  Set rsLogin = nothing
  Set cntDB = nothing
Else
  response.Write("&nbsp;")
End If
%>
  </b></font></center></td>
</tr>
<tr>
  <font face="Verdana">
  <form name="frmLogin" method="POST" action="login.asp" onsubmit="return validate()">
  <table border="0">
    <tr>
      <td width="13%" bgcolor="#C0C0C0"><b>&nbsp;Login</b></td>
      <td width="41%" bgcolor="#C0C0C0">
<% If request.Form("login") <> "" Then %>
        <input name="login" size="26" value="<%=lcase(request.Form("login"))%>" style="font-family: Verdana; background-color: #EEEDEA">
<% Else %>
        <input name="login" size="26" style="font-family: Verdana; background-color: #EEEDEA">
<%End If %>
      </td>
      <td width="46%" bgcolor="#FFFF80"><font size="1">Su identificador es el alias registrado</font></td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0"><b>&nbsp;Clave</b></td>
      <td bgcolor="#C0C0C0"><input type="password" name="password" size="26" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Clave de acceso o password</font></td>
    </tr>
  </table>
  <input type="submit" value="Ingresar" name="ingresar">
  <input type="reset" value="Limpiar" name="limpiar">
  <font size="1">
<%If now() < #15-Jun-2021# Then%>
  <p style="line-height: 150%">Si no está registrado puede hacerlo <a href="register.asp">aquí</a><br><b>Recuerde que puede seguir utilizando el mismo login de las quiniela del pasado</b></p>
<%End If%>
<!--
   <p style="line-height: 0%">Sitio en mantenimiento</p>
-->
  </font>
  </form>
  </font>
</tr>
<tr>
  <img border="0" src="images/FooterEuro2021.jpg">
</tr>
</table>
</body>

</html>
