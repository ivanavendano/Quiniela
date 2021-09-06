<!--#include file="includes/securitycheck.inc"-->
<%
If strProfile = "ADMIN" then
  strPar = "?alias=" & Session("userid")
Else
  strPar = ""
End If
%>
<base target="_top">
<html>
<!-- Sección de Inicio -->
<font face="Verdana">
<table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">
  <tr>
    <td width="100%" bgcolor="#E2E2E2"><font size="1">
      <p style="margin: 0">
        <a href="/quiniela/main.asp">Inicio</a><br>
        <a href="/quiniela/chgpasswd.asp<%=strPar%>"">Actualizar Datos</a><br>
	    <a href="/quiniela/foro.htm">Foro</a><br>
	    <!--<a href="/quiniela/chat.htm">Chat</a>-->
      </p>
    </font></td>
  </tr>
</table>

<!-- Sección mis quinielas -->
<p style="margin: 5"></p>
<font face="Verdana">
<table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">
  <tr>
    <td width="100%" bgcolor="#CCCCCC">
      <p align="left"> <font size="1"><b>Mis Quinielas</b></font></p></td>
  </tr>
  <tr>
    <td width="100%"><font size="1">
      <%If now() < #11-Jun-2021# Then%>
        <a href="newbet.asp?quiniela=13"><b>Crear nueva</b></a>
      <%End If%>
<%
Dim rsBetsLB

cntDB.Open dsn

Set rsBetsLB = Server.CreateObject("ADODB.Recordset")
sql = "SELECT ub.idbet,ub.betalias,sum(ubr.points) as pts FROM users_bets ub, users_bets_results ubr, betformats bf WHERE ub.idbet=ubr.idbet AND ub.idbetformat=bf.idbetformat AND bf.display=1 AND alias='" & Session("userid") & "' GROUP BY bf.duedate,ub.idbet,ub.betalias ORDER BY 3"
rsBetsLB.Open sql,cntDB,3,3
i = 0
Do while not rsBetsLB.EOF
  If i > 0 or date() < #11-Jun-2021# Then
%>
  <br>
<%
  End If
%>
  <a href="modbet.asp?idb=<%=rsBetsLB.Fields("idbet")%>"><%=rsBetsLB.Fields("betalias")%></a>&nbsp(<%=rsBetsLB.Fields("pts")%>)
<%
  i = i + 1
  rsBetsLB.MoveNext
loop
rsBetsLB.Close
%>
    </font></td>
  </tr>
</table>

<!-- Sección Mis Grupos -->
<p style="margin: 5"></p>
<font face="Verdana">
<table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">
  <tr>
    <td width="100%" bgcolor="#CCCCCC">
      <p align="left"> <font size="1"><b>Mis Grupos</b></font></p></td>
  </tr>
  <tr>
    <td width="100%"><font size="1">
        <a href="newbetgroup.asp"><b>Crear nuevo</b></a><br>
        <a href="joinbetgroup.asp?quiniela=11"><b>Unirme a grupo</b></a>
<%
Dim rsBetGroupsLB

Set rsBetGroupsLB = Server.CreateObject("ADODB.Recordset")
sql = "SELECT distinct ubg.groupalias, ubg.idbetgroup FROM users_bets ub, users_bets_groups ubg, users_bets_groups_bets ubgb WHERE ub.idbet = ubgb.idbet AND ubgb.idbetgroup=ubg.idbetgroup AND ub.alias='" & Session("userid") & "' ORDER BY 1"
rsBetGroupsLB.Open sql,cntDB,3,3
Do while not rsBetGroupsLB.EOF
%>
  <br><a href="detail.asp?quiniela=6&encabezado=header.bmp&pie=footer.bmp&grpqnl=<%=rsBetGroupsLB.Fields("idbetgroup")%>">
    <%=rsBetGroupsLB.Fields("groupalias")%>
  </a>
<%
  rsBetGroupsLB.MoveNext
loop
rsBetGroupsLB.Close
%>
    </font></td>
  </tr>
</table>

<!--
<!-- Sección de Resultado de Quinielas Anteriores
<p style="margin: 5"></p>
<table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">
  <tr>
    <td width="100%" bgcolor="#CCCCCC">
      <p align="left"> <font size="1"><b>Resultados Anteriores</b></font></p>
    </td>
  </tr>
  <tr>
    <td width="100%"><font size="1">
      <a href="detail.asp?quiniela=13&encabezado=headerEuro2021.jpg&pie=footerEuro2021.jpg">Euroamérica 2021</a>
    </font></td>
  </tr>
</table>
-->    
<!-- Sección de Grupos y Equipos -->
<p style="margin: 5"></p>

<font face="Verdana">
<table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">

<%
Dim rsGroupsLB
Dim rsTeamsLB

Set rsGroupsLB = Server.CreateObject("ADODB.Recordset")
sql = "SELECT idgroup,name FROM groups WHERE display=1"
rsGroupsLB.Open sql,cntDB,3,3

Set rsTeamsLB = Server.CreateObject("ADODB.Recordset")

Do while not rsGroupsLB.EOF
%>
  <tr>
    <td width="100%" bgcolor="#CCCCCC">
      <p align="left"> <font size="1"><b>
      <a href="/quiniela/groups.asp?group=<%=rsGroupsLB.Fields("idgroup")%>"><%=rsGroupsLB.Fields("name")%></a>
      </b></font></p>
    </td>
  </tr>
  <tr>
    <td width="100%"><font size="1">
<%
  sql = "SELECT t.idteam,t.country,t.flagsmall FROM teams t,teamsgroups tg WHERE tg.idteam=t.idteam AND tg.idgroup = '" & rsGroupsLB.Fields("idgroup") &"' ORDER BY tg.position,t.country"
  rsTeamsLB.Open sql,cntDB,3,3
  Do while not rsTeamsLB.EOF
%>
      <table border="0" cellspacing="1" cellpadding="0" ><tr>
      <td><font size="1"><a href="/quiniela/teams.asp?team=<%=rsTeamsLB.Fields("idteam")%>"><img border="0" src=<%=rsTeamsLB.Fields("flagsmall")%>></a></font></td>
      <td><font size="1"><a href="/quiniela/teams.asp?team=<%=rsTeamsLB.Fields("idteam")%>"><%=rsTeamsLB.Fields("country")%></a></font></td>
      </tr></table>
<%
      rsTeamsLB.MoveNext
  loop
  rsTeamsLB.Close
  rsGroupsLB.MoveNext
%>  
    </font></td>
  </tr>
<%
loop
rsGroupsLB.Close
%>
</table>

<!-- Sección de Administración -->
<%
If strProfile = "ADMIN" Then
%>
  <p style="margin: 5"></p>
  <table border="1" width="100%" cellspacing="0" cellpadding="2" bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#000000">
    <tr>
      <td width="100%" bgcolor="#CCCCCC">
        <p align="left"> <font size="1"><b>Administración</b></font></td>
    </tr>
    <tr>
      <td width="100%"><font size="1">

        <p style="margin: 0"><a href="updategamesmenu.asp">Actualizar Juegos</a></p>
        <%If now() < #11-Jun-2021# Then%>
             <p style="margin: 0"><a href="registerpayments.asp?quiniela=13">Registrar Pago</a></p>
        <%End If%>     
        <p style="margin: 0"><a href="administrator.asp">Administradores</a></p>
  		<p style="margin: 0"><a href="check.asp">Chequeo</a></p>
      </font></td>
    </tr>
  </table>
<%  
End If
%>

</font>

</html>
