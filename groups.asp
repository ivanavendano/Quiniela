<!--#include file="includes/securitycheck.inc"-->
<%
If strProfile = "ADMIN" Then
  isAdmin = 1
Else
  isAdmin = 0
End If
strHeader = "HeaderEuro2021.jpg"
%>
<html>

<head>
<title>
<%
Dim rsGroups
groupID = request.QueryString("group")

cntDB.Open dsn
Set rsGroups = Server.CreateObject("ADODB.Recordset")
sql = "SELECT name from groups WHERE idgroup='" & groupID & "'"
rsGroups.Open sql,cntDB,3,3
If rsGroups.EOF Then
  response.redirect("noautorizado.asp")
Else
  strGroup = rsGroups.Fields("name")
  response.write("La quiniela Cantv.net: " & strGroup)
End If
rsGroups.Close
cntDB.Close
%>
<link rel="shortcut icon" href="favicon.ico" >
</title>
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
      Dim rsGroupsTeams
      
      Set rsGroupsTeams = Server.CreateObject("ADODB.Recordset")
	  sql = "SELECT t.flagbig,tg.idteam,t.country,tg.wins+tg.draws+tg.loses as games,tg.wins,tg.loses,tg.draws,tg.wins*3+tg.draws as points,tg.goalsfor,tg.goalsagainst,tg.position FROM teams t,teamsgroups tg,groups g WHERE t.idteam=tg.idteam AND g.idgroup=tg.idgroup AND g.idgroup='" & groupID & "' ORDER BY (tg.wins*3+tg.draws)*-1 ,position, t.country"
	  rsGroupsTeams.Open sql,cntDB,3,3
%>
<table border="0" cellspacing="0" cellpadding="1" width=75%>
<tr><td bgcolor="#3366CC"><font face="Verdana" size="3" color="#FFFFFF"><center><b><%=strGroup%></b></center></font></td></tr>
<tr>
<table border="0" cellspacing="0" cellpadding="1" width=75%>
<% If isAdmin = 1 Then %>
  <form name="frmActGrupos" method="POST" action="savegroups.asp">
<% End If %>
<tr>
  <td bgcolor="#3366CC" width=30%><font face="Verdana" size="2" color="#FFFFFF"><center><b>Equipo</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>J</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>G</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>E</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>P</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>Pts</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>GF</b></center></font></td>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>GC</b></center></font></td>
<% If isAdmin = 1 Then %>
  <td bgcolor="#3366CC" width=10%><font face="Verdana" size="2" color="#FFFFFF"><center><b>Pos</b></center></font></td>
<% End If %>
</tr>
<%
      nCounter = 0
      Do while not rsGroupsTeams.EOF
        nCounter = nCounter + 1
%>
<tr>
  <td><table><tr>
      <td><font face="Verdana" size="2"><a href="/quiniela/teams.asp?team=<%=rsGroupsTeams.Fields("idteam")%>"><img border="1" src=<%=rsGroupsTeams.Fields("flagbig")%>></a></font></td>
      <td><font face="Verdana" size="2"><a href="/quiniela/teams.asp?team=<%=rsGroupsTeams.Fields("idteam")%>"><%=rsGroupsTeams.Fields("country")%></a></font></td>
  </tr></table></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("games")%></center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("wins")%></center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("draws")%></center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("loses")%></center></font></td>
  <td><font face="Verdana" size="2"><center><b><%=rsGroupsTeams.Fields("points")%></b></center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("goalsfor")%></center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupsTeams.Fields("goalsagainst")%></center></font></td>
<% If isAdmin = 1 Then %>
  <td><font face="Verdana" size="2"><p align="center">
    <input name="<%="pos" & nCounter %>" value="<%=rsGroupsTeams.Fields("position")%>" size="2" style="text-align: Center">
    <input type="hidden" name="<%="idteam" & nCounter%>" value="<%=rsGroupsTeams.Fields("idteam")%>">
    <input type="hidden" name="<%="idgroup" & nCounter%>" value="<%=groupID%>">
  </p></font></td>
<% End If %>
</tr>
<%
        rsGroupsTeams.MoveNext
      loop
      rsGroupsTeams.Close
%>
<% If isAdmin = 1 Then %>
  <tr><td colspan="9"><center><input type="submit" value="Actualizar Posiciones" name="actualizar" style="font-family: Verdana"></center></td></tr>
</form>
<% End If %>
</table></tr>
<tr><td><table  border="0" cellspacing="0" cellpadding="1" width=75%>
  <tr><td bgcolor="#3366CC"><font face="Verdana" size="3" color="#FFFFFF"><center><b>Juegos</b></center></font></td></tr>
  <table border="0" cellspacing="5" cellpadding="2" width=75%>
<%
      Dim rsGroupGames
      
      Set rsGroupGames = Server.CreateObject("ADODB.Recordset")
	  sql = "SELECT t1.idteam as idteam1,t1.country as country1,t2.idteam as idteam2,t2.country as country2,s.idstadium,s.name as stadium,c.city,gg.goalsteam1,gg.goalsteam2,Format(gg.localdate,'DD/MM-hh:nn') & ' ' & gg.localcountry & ' - ' & Format(gg.localdate+gg.venezuelandate/24,'hh:nn') & ' Vzla' as localdate FROM teams t1,teams t2,groupgames gg,stadiums s,cities c WHERE t1.idteam=gg.idteam1 AND t2.idteam=gg.idteam2 AND s.idstadium=gg.idstadium AND s.idcity=c.idcity AND gg.idgroup='" & groupID & "' ORDER BY gg.localdate"
	  'response.write sql
	  rsGroupGames.Open sql,cntDB,3,3
	  Do while not rsGroupGames.EOF
%>
<tr>
  <td><font face="Verdana" size="2"><%=rsGroupGames.Fields("localdate")%></font></td>
  <td><font face="Verdana" size="2"><p align="right"><a href="/quiniela/teams.asp?team=<%=rsGroupGames.Fields("idteam1")%>"><%=rsGroupGames.Fields("country1")%></a></p></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupGames.Fields("goalsteam1")%></center></font></td>
  <td><font face="Verdana" size="2"><center>-</center></font></td>
  <td><font face="Verdana" size="2"><center><%=rsGroupGames.Fields("goalsteam2")%></center></font></td>
  <td><font face="Verdana" size="2"><p align="left"><a href="/quiniela/teams.asp?team=<%=rsGroupGames.Fields("idteam2")%>"><%=rsGroupGames.Fields("country2")%></a></p></font></td>
  <td><font face="Verdana" size="2"><p align="right"><%=rsGroupGames.Fields("stadium")%> - <%=rsGroupGames.Fields("city")%></p></font></td>
</tr>  
<%
        rsGroupGames.MoveNext
      loop
      rsGroupGames.Close
%>
  </table>
</table></td></tr>
</table>


<!------------------------------------------------------------------------->

      </td>
      </table>
    </td>
  </table>
</tr>
<tr>
  <img border="0" align="top" src="/quiniela/images/FooterEuro2021.jpg">
</tr>
  
</table>

</body>

</html>
