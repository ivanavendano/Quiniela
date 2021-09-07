<!--#include file="includes/securitycheck.inc"-->

<SCRIPT LANGUAGE="JavaScript">
validnumber = /^[0-9]{0,}$/
invalidn    = /[^0-9]/
function validatenumber(nObj)
{
   if (validnumber.test(nObj.value)) {return true}
   else {
	   alert("Debe introducir números solamente")
	   str = nObj.value
	   nObj.value = str.replace(invalidn,"")
	   return false
   }
}

function validatelen(nObj)
{
	if (nObj.value.length < 1) { nObj.value = 0}
	return true
}
</script>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title> Modificar Apuesta </title>
<%
Dim rsBets
Dim nIdBetFormat
Dim strBet,strWinPts,strResultPts,strDueDate,strPrice,strFinalDate

nIdBetFormat = cInt(request.QueryString("idb"))

cntDB.Open dsn
Set rsBets = Server.CreateObject("ADODB.Recordset")
sql = "SELECT betformatname,win_points,result_points,Format(duedate,'DD/MM/YYYY') as due_date,Format(price,'###,###') as price1,Format(finaldate,'DD/MM/YYYY') as final_date, duedate as dd FROM betformats WHERE idbetformat=(SELECT idbetformat FROM users_bets WHERE idbet=" & nIdBetFormat & ")"


rsBets.Open sql,cntDB,3,3
If rsBets.EOF Then
  response.redirect("noautorizado.asp")
Else
  strBet       = rsBets.Fields("betformatname")
  strWinPts    = rsBets.Fields("win_points")
  strResultPts = rsBets.Fields("result_points")
  strDueDate   = rsBets.Fields("due_date")
  strPrice     = rsBets.Fields("price1")
  strFinalDate = rsBets.Fields("final_date")
  dDueDate     = rsBets.Fields("dd")
  
End If
rsBets.Close
cntDB.Close
strHeader = "headerEuro2021.jpg"
%>
</title>
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
<form name="frmActJuegos" method="POST" action="updtuserbet.asp">
<font face="Verdana" color="#0000FF">
  <b>Quiniela "<%=strBet%>": Complete los resultados de todos los juegos listados</b><br><br>
  <font size="1">
    <b>Reglas por las que se regirá la quiniela <%=strBet%>:</b><br><br>
    <b>Se juega una sola QUINIELA, se debe predecir los resultados tanto de la Copa América como la Eurocopas. Es decir, 2 Torneos corresponden a una sola quiniela<%=strBet%>:</b><br><br>
      <% If cInt(strWinPts) > 1 Then%>
      1. Se asignarán <%=strWinPts%> puntos al acertar el ganador de un juego (o empate)<br>
    <%Else%>
      1. Se asignará <%=strWinPts%> punto al acertar el ganador de un juego (o empate)<br>
    <%End If%>
    <% If cInt(strResultPts) > 1 Then%>
      2. Se asignarán <%=strResultPts%> puntos adicionales por acertar el resultado exacto de un juego<br>
    <%Else%>
      2. Se asignará <%=strResultPts%> punto adicional por acertar el resultado exacto de un juego<br>
    <%End If%>
    3. Podrán modificarse los resultados de la Fase de Grupos hasta el <%=strDueDate%><br>
    <%
      
      If now() > #14-Jun-2018# Then
        strModif = "disabled" 
    %>
      <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;En este momento no pueden modificarse los resultados por haber pasado la fecha tope</b><br>
    <%
      Else
        strModif = ""
      End If
    %>
     4. Una vez finalizada la Fase de Grupos se activarán los Juegos de las Rondas de Knockout o de Eliminación Directa <br> &nbsp;&nbsp;&nbsp; a medida que se conozcan TODOS los clasificados y los cruces respectivos<br>
    5. Los cruces a considerar para las Rondas de Knockout corresponderán fielmente a los cruces tanto de la Copa América 2021 como la Eurocopa 2021. <br> &nbsp;&nbsp;&nbsp; Es decir, se participa en todos los juegos, hay oportunidad de seguir en juego y alcanzar las posiciones a premiar.<br>
    6. En la Ronda de Knockout cada quiniela seguirá acumulando puntos, es decir se suman las puntuaciones obtenidas en <br> &nbsp;&nbsp;&nbsp; la Fase de Grupos y en la Ronda de Knockout <br>
    7. En la Ronda de Knockout solo contará el resultado de los 90 minutos reglamentarios de juego más los hipotéticos <br> &nbsp;&nbsp;&nbsp; 30 minutos adicionales en caso de existir empate. No cuentan los resultados de los PENALTIES <br>
    8. De lo anterior se desprende que un empate es un resultado valido en la Ronda de Knock Out.<br>
    9. Los juegos cuyo resultado no haya sido incluido serán considerados con el resultado cero a cero<br>
    10. El precio de la quiniela es de Bs.<%=strPrice%> que deben ser cancelados antes del <%=strDueDate%>, de lo contrario no tendrá validez<br>
    11. En caso de empate el pote asignado se distribuirá equitativamente entre los participantes que participen del empate<br>
    12. Luego de culminada la fase de inscripción y llenado de la quiniela, se publicará una encuesta para decidir cuantas posiciones premiar y con cual porcentaje del pote <br>
    13. Una vez creada tu quiniela podrás cancelarla a las siguientes personas: <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.- Iván Avendaño - Cortijos 3 Piso 1 <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.- Luis Cordero - Edificio NEA <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c.- Pueden ubicarme escribiendo un correo a ivanf.avendano@gmail.com para enviarles los datos de mi cuenta de ahorros y hacer transferencia <br>
 
    14. Los ganadores de la quiniela serán anunciados formalmente el <%=strFinalDate%><br><br>
    </font>
    <%
      Dim rsGames
      Dim nGameCounter
      
      Set rsGames = Server.CreateObject("ADODB.Recordset")
      sql =       "SELECT ubr.idgame as id, t1.country as t1, t2.country as t2, ubr.idteam1 as idt1, ubr.idteam2 as idt2, ubr.goalsteam1 as g1, ubr.goalsteam2 as g2, ub.betalias as ba, ubr.points, (SELECT goalsteam1 FROM groupgames WHERE idgame=ubr.idgame) as updated,t1.flagsmall as flagsmall1,t2.flagsmall as flagsmall2,rrd.idronda,rrd.roundtype,rrd.fechainicio, DATE()-rrd.fechainicio as diferencia , gg.localdate"
      sql = sql & " FROM users_bets_results ubr, teams t1, teams t2, users_bets ub,groupgames gg, betformats_games bg, roundrangedates rrd "
      sql = sql & "WHERE ubr.idteam1=t1.idteam AND ubr.idteam2=t2.idteam AND ub.idbet=ubr.idbet AND ub.idbet=" & nIdBetFormat & " AND ub.alias='" & Session("userid") & "' AND ubr.idgame=gg.idgame AND gg.idgame=bg.idgame AND bg.display=1  AND gg.idronda=rrd.idronda " ' and DATE()+time()-rrd.fechainicio < 0 "
      sql = sql & "ORDER BY gg.localdate+(gg.venezuelandate+1+60/60)/24 "

      'response.write sql
      rsGames.Open sql,cntDB,3,3
      
%>

  <table width="75%" border="0">
    <tr>
      <td width="25%" bgcolor="#C0C0C0"><b>Alias de la Quiniela</b></td>
      <td bgcolor="#C0C0C0"><input name="alias" disabled value="<%=rsGames.Fields("ba")%>" size="26" style="font-family: Verdana; background-color: #EEEDEA"></td>
      <td bgcolor="#FFFF80"><font size="1">Nombre de referencia para identificar su quiniela. Le será útil en caso de participar con más de una quiniela</font></td>
    </tr>
  </table>
</font>
<table border="1" cellspacing="0" cellpadding="2" width="75%">
<tr>
  <td width="15%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><p align="right"><b>Tipo de Ronda</b></p></font></td>
  <td width="40%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><p align="right"><b>Equipo</b></p></font></td>
  <td width="10%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><center><b>Goles</b></center></font></td>
  <td width="10%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><center><b>Goles</b></center></font></td>
  <td width="40%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><p align="left"><b>Equipo</b></p></font></td>
  <% If strModif = "disabled" Then %>
    <td width="10%" bgcolor="#3366CC"><font face="Verdana" size="2" color="#FFFFFF"><center><b>Puntos</b></center></font></td>
  <% End If %>
</tr>
<%
      nGameCounter = 0
      Do while not rsGames.EOF
        nGameCounter = nGameCounter + 1
        If rsGames.Fields("diferencia") < 0 Then  
           strModif = "enabled"
        Else
           strModif = "disabled"
        End If      
        'response.write "Diferencia " & rsGames.Fields("diferencia")
%>
<input type="hidden" value="<%=rsGames.Fields("id")%>" name="<%="IdGame" & nGameCounter%>">
<input type="hidden" value="<%=rsGames.Fields("diferencia")%>" name="<%="Diff" & nGameCounter%>">

<tr>
    <td><font face="Verdana" size="2"><p align="right"><%=rsGames.Fields("RoundType")%> </p></font></td>
    <td><font face="Verdana" size="2"><p align="right"><%=rsGames.Fields("t1")%>  <img border="0" src=<%=rsGames.Fields("flagsmall1")%>></p></font></td>
        <input type="hidden" name="<%="idt1" & nGameCounter%>" value="<%=rsGames.Fields("idt1")%>">
    <td><font face="Verdana" size="2"><p align="center">
        <input name="<%="g1" & nGameCounter%>" <%=strModif%> value="<%=rsGames.Fields("g1")%>" size="2" style="text-align: Center" onkeyup="return validatenumber(document.frmActJuegos.g1<%=nGameCounter%>)" onblur="return validatelen(document.frmActJuegos.g1<%=nGameCounter%>)">
            </p></font></td>
    <td><font face="Verdana" size="2"><p align="center">
        <input name="<%="g2" & nGameCounter%>" <%=strModif%> value="<%=rsGames.Fields("g2")%>" size="2" style="text-align: Center" onkeyup="return validatenumber(document.frmActJuegos.g2<%=nGameCounter%>)" onblur="return validatelen(document.frmActJuegos.g2<%=nGameCounter%>)">
           </p></font></td>
    <td><font face="Verdana" size="2"><p align="left"><img border="0" src=<%=rsGames.Fields("flagsmall2")%>>  <%=rsGames.Fields("t2")%></p></font></td>
        <input type="hidden" name="<%="idt2" & nGameCounter%>" value="<%=rsGames.Fields("idt2")%>">
  <% If strModif = "disabled" Then %>
    <td><font face="Verdana" size="2"><center><% If rsGames.Fields("updated") >= 0 Then response.write(rsGames.Fields("points")) Else response.write("&nbsp") End If%></center></font></td>
  <% Else %>  
    <td> <%response.write("&nbsp") %></td>
  <% End If %>
</tr>
<%
        rsGames.MoveNext
      loop
      rsGames.Close
      cntDB.Close
    %>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="2" width="80%">
  <td><center><input type="submit" value="Acepto las reglas y actualizo mi quiniela" <%=strModif%> name="guardar" style="font-family: Verdana"></center></td>
</table>
<input type="hidden" value="<%=nGameCounter%>" name="nGameCounter">
<input type="hidden" value="<%=nIdBetFormat%>" name="nIdBetFormat">
</form>  
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
