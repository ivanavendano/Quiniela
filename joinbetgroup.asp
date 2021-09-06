<!--#include file="includes/securitycheck1.inc"-->
<%
  strHeader = "HeaderEuro2021.jpg"
  betformatID   = request.QueryString("quiniela")
  groupalias    = request.QueryString("grpalias")
  grouppassword = request.QueryString("grppasswd")
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>La quiniela Cantv.net: Grupos personalizados</title>
<link rel="shortcut icon" href="favicon.ico" >
</head>

<SCRIPT LANGUAGE="JavaScript">
function validate()
{
  sAlias = document.frmJoinGrp.groupalias.value
  sPass  = document.frmNewGrp.password.value
  if ((sAlias.length < 1)||(sPass.length < 1))
  {
    alert("Debe llenar todos los campos")
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
  Dim rsValid

  betgroupID     = Request.Form("grplist")
  strPassword    = Request.Form("password")

	Set rsValid = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT password, groupalias FROM users_bets_groups WHERE idbetgroup=" & betgroupID
	rsValid.Open sql,cntDB,3,3
	
	If not rsValid.EOF Then
	  If rsValid.Fields("password") = strPassword Then
	    nBetCounter = Request.Form("nBetCounter")
	    rsValid.Close
	    For i = 1 to nBetCounter
	    	chk = Request.Form("chk" & i)
	    	If chk = "Si" Then
			    betID = request.Form("bet" & i)
				sql = "SELECT * FROM users_bets_groups_bets WHERE idbetgroup = " & betgroupID & " AND idbet = " & betID
				rsValid.Open sql,cntDB,3,3
				If rsValid.EOF Then	
				    sql = "INSERT INTO users_bets_groups_bets (idbetgroup,idbet) VALUES (" & betgroupID & "," & betID & ")"
				    cntDB.Execute sql
				End If
			    rsValid.Close
			End If
		Next
	    cntDB.Close
	    response.redirect("main.asp")
	  Else
	    rsValid.Close
	    strErrorMsg = "El password es incorrecto. Por favor revisa e intenta nuevamente"
	  End If
	Else
	  rsValid.Close
	  strErrorMsg = "El grupo seleccionado no existe. Por favor revisa e intenta nuevamente"
	End IF
Else 
  strErrorMsg = "&nbsp"
End If
%>


<table border="0" cellspacing="0" cellpadding="0" width = "652">
<tr>
  <tr><td bgcolor="#FFCC66" align="center">
    <font face = "Verdana">Para unirte a un grupo selecciona su alias (identificador) y escribe su password. Luego selecciona la(s) quiniela(s) que quieres unir al grupo. Una quiniela puede estar en todos los grupos que quieras<br><br>
    </font>
  </td></tr>
  <tr><td><font color="#FF0000" face="Verdana"><b><%=strErrorMsg%></b><br></font></td></tr>
  <tr>
  <form name="frmJoinGrp" method="POST" action="joinbetgroup.asp?quiniela=<%=betformatID%>" onsubmit="return validate()">
  <table border="0" width="75%">
    <tr>
      <td width="25%" bgcolor="#808080"><font face="Verdana"><b>&nbsp;Alias</b></font></td>
      <td width="35%" bgcolor="#808080">
        <!--<input name="groupalias" size="30%" value="<%=request.Form("groupalias")%>" style="font-family: Verdana; background-color: #EEEDEA">-->
        <select name="grplist">
<%
Dim rsBetsGroups

Set rsBetsGroups = Server.CreateObject("ADODB.Recordset")
sql = "SELECT alias,groupalias,description,idbetgroup FROM users_bets_groups ORDER BY 1"
rsBetsGroups.Open sql,cntDB,3,3
nGroupCounter = 0
Do while not rsBetsGroups.EOF
  nGroupCounter = nGroupCounter + 1
%>
          <option value="<%=rsBetsGroups.Fields("idbetgroup")%>" <%If rsBetsGroups.Fields("groupalias") = groupalias Then%> selected="selected"<%End If%>><%=rsBetsGroups.Fields("groupalias") & " (creado por " & rsBetsGroups.Fields("alias") & ")"%></option>
<%
  rsBetsGroups.MoveNext
loop
rsBetsGroups.Close
%>
        </select>
      </td>
      <td width="40%" bgcolor="#FFFF80"><font size="1" face="Verdana">El identificador del grupo informado por quien lo creó</font></td>
    </tr>
    <tr>
      <td bgcolor="#808080"><font face="Verdana"><b>&nbsp;Clave de Ingreso</b></font></td>
      <td bgcolor="#808080"><input name="password" size="30%" value="<%=grouppassword%>"style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1" face="Verdana">Clave de acceso o password enviado por quien creó el grupo</font></td>
    </tr>
    <tr>
      <td bgcolor="#808080"><font face="Verdana"><b>Quinielas a incluir en el grupo</b></font></td>
      <td bgcolor="#E0E0E0"><font face="Verdana">
<%
Dim rsBets

Set rsBets = Server.CreateObject("ADODB.Recordset")
sql = "SELECT ub.idbet,ub.betalias FROM users_bets ub WHERE ub.idbetformat=" & betformatID & " AND ub.paydate is not null AND alias='" & Session("userid") & "' ORDER BY 2"


rsBets.Open sql,cntDB,3,3
nBetCounter = 0
Do while not rsBets.EOF
  nBetCounter = nBetCounter + 1
%>
		<input type="hidden" name="<%="bet" & nBetCounter%>" value="<%=rsBets.Fields("idbet")%>">
        <input type="checkbox" name="<%="chk" & nBetCounter%>" value="Si"><%=rsBets.Fields("betalias")%><br>
<%
  rsBets.MoveNext
loop
rsBets.Close
cntDB.Close
%>      
      </font></td>
      <td bgcolor="#FFFF80"><font size="1" face="Verdana">Selecciona la(s) quiniela(s) a incluir en el grupo</font></td>
    </tr>
  </table>
  <input type="submit" value="Unirme al grupo" name="register">
  <input type="hidden" value="1" name="flag">
  <input type="hidden" value="<%=nBetCounter%>" name="nBetCounter">
  </form>
  </tr>
</tr>
</table>
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
