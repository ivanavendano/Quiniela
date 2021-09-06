<!--#include file="includes/securitycheck.inc"-->
<%
  strHeader = request.QueryString("encabezado")
  strFooter = request.QueryString("pie")
  betformatID = request.QueryString("quiniela")
  betgroupID = request.QueryString("grpqnl")
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>La quiniela Cantv.net: Detalle de todas las quinielas</title>
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
<!------------------------------------------------------------------------------->      
<table width="652">
<!--
<font face="Verdana" size="2" color="#000000">  
<table border="0" cellspacing="1" cellpadding="0" width="680">
  <tr><td colspan="3"><center>
Las quinielas marcadas en rojo están identificadas como <font color="#FF0000" size="3"><b>traidores a la patria</b></font> por colocar perdiendo a La Vinitinto en algún partido
<br><br>
  </center></td></tr>
  <tr>
    <td bgcolor="#FF0000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Traidor a la patria avanzado: La Vinotinto pierde los 3 juegos</td>
    <td rowspan="3">
      <img border="0" align="top" src="/quiniela/images/palante.jpg" width="85" height="62">
      <img border="0" align="top" src="/quiniela/images/caceroleando.jpg" width="70" height="74">
    <td>
  </tr>
  <tr><td bgcolor="#FF9999">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Traidor a la patria medio: La Vinotinto pierde 2 juegos</td></tr>
  <tr><td bgcolor="#FFFF00">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Traidor a la patria principiante: La Vinotinto pierde 1 juego</td></tr>
</table>
</font>
-->
<%
		If betgroupID > 0 Then
		  Set rsInfo = Server.CreateObject("ADODB.Recordset")
		  sql = "SELECT ubg.alias, ubg.groupalias, ubg.description, u.name, u.lastname FROM users_bets_groups ubg, users u WHERE ubg.alias = u.alias AND ubg.idbetgroup = " & betgroupID
		  rsInfo.Open sql,cntDB,3,3
%>

<font face="Verdana" size="2" color="#000000"> 
  <b>Grupo:</b>&nbsp;<%=rsInfo.Fields("groupalias")%><br>
  <b>Descripción:</b>&nbsp;<%=rsInfo.Fields("description")%><br>
  <b>Administrador:</b>&nbsp;<%=rsInfo.Fields("name")%>&nbsp;<%=rsInfo.Fields("lastname")%>&nbsp;(<%=rsInfo.Fields("alias")%>)<br>
</font>
<%
		  rsInfo.Close
		End If
%>

  <tr><td><table border="0" cellspacing="1" cellpadding="0">
    <tr>
      <td bgcolor="#3366CC"><font face="Verdana" size="1" color="#FFFFFF"><center>Pos</center></font></td>
      <td bgcolor="#3366CC"><font face="Verdana" size="1" color="#FFFFFF"><center>Participante</center></font></td>
      <td bgcolor="#3366CC"><font face="Verdana" size="1" color="#FFFFFF">&nbsp;Ptos&nbsp;</font></td>
<%
	      Dim rsBets
	      Dim rsUserGames
	      Dim rsTitle
	      
		  Set rsTitle = Server.CreateObject("ADODB.Recordset")
		  sql = "SELECT t1.short as ts1, t2.short as ts2, gg.goalsteam1 as g1, gg.goalsteam2 as g2, gg.updated, gg.idgame FROM betformats_games bg, groupgames gg, teams t1, teams t2 WHERE bg.idgame=gg.idgame AND gg.idteam1 = t1.idteam AND gg.idteam2 = t2.idteam AND bg.idbetformat = " & betformatID & " AND gg.display=1 ORDER BY gg.localdate, gg.idgame"
		  rsTitle.Open sql,cntDB,3,3
		  i = 0
		  VzlaGames = ""
		  nNextGame = 0
		  Do while not rsTitle.EOF
		    i = i + 1
		    If (i mod 2)=1 Then
		      bc = "#B7CBFF" '"#3366CC"
		      fc = "#000000" '"#FFFFFF"
		    Else
		      bc = "#3366CC"
		      fc = "#FFFFFF" '"#000000"
		    End If
		    If not rsTitle.Fields("updated") and nNextGame = 0Then
		      nNextGame = rsTitle.Fields("idgame")
		    End If
%>
      <td bgcolor="<%=bc%>" width="40"><font face="Verdana" size="1" color="<%=fc%>"><center>&nbsp;<%=rsTitle.Fields("ts1")%>&nbsp;<br>&nbsp;<%=rsTitle.Fields("ts2")%>&nbsp;</center></font></td>
      <td bgcolor="<%=bc%>" width="10"></td>
<%		  
		    rsTitle.MoveNext
		  loop
%>
    </tr>
    <tr><td bgcolor="#3366CC"></td><td bgcolor="#3366CC"></td><td bgcolor="#3366CC"></td>
<%
          rsTitle.MoveFirst
          i = 0
		  Do while not rsTitle.EOF
		    i = i + 1
		    If (i mod 2)=1 Then
		      bc = "#B7CBFF" '"#3366CC"
		      fc = "#000000" '"#FFFFFF"
		    Else
		      bc = "#3366CC"
		      fc = "#FFFFFF" '"#000000"
		    End If
%>
      <td bgcolor="<%=bc%>" colspan="2"><font face="Verdana" size="1" color="<%=fc%>"><center><%=rsTitle.Fields("g1")%>-<%=rsTitle.Fields("g2")%></center></font></td>
<%		  
		    rsTitle.MoveNext
		  loop
		  rsTitle.Close
%>
    </tr>
<%		   
	      Set rsBets = Server.CreateObject("ADODB.Recordset")
	      Set rsUserGames = Server.CreateObject("ADODB.Recordset")
	      'Set rsTraidores = Server.CreateObject("ADODB.Recordset")
	      If betgroupID > 0 Then
	        sql = "SELECT ub.idbet, ub.betalias, u.name, u.lastname, u.alias, sum(ubr.points) as pts FROM users_bets ub, users_bets_results ubr, users u, users_bets_groups_bets ubgb WHERE ub.idbet = ubr.idbet AND ub.alias = u.alias AND ub.idbetformat=" & betformatID & " AND ub.idbet = ubgb.idbet AND ubgb.idbetgroup = " & betgroupID & "AND ub.paydate is  null GROUP BY ub.idbet, ub.betalias, u.name, u.lastname, u.alias ORDER BY 6 desc,3,4"
	      Else
		    sql = "SELECT ub.idbet, ub.betalias, u.name, u.lastname, u.alias, sum(ubr.points) as pts FROM users_bets ub, users_bets_results ubr, users u WHERE ub.idbet = ubr.idbet AND ub.alias = u.alias AND ub.idbetformat=" & betformatID & " AND ub.paydate is  null GROUP BY ub.idbet, ub.betalias, u.name, u.lastname, u.alias ORDER BY 6 desc,3,4"
		  End If
		  rsBets.Open sql,cntDB,3,3
		  i = 0
		  pos = 0
		  prevPts = -1
		  Do while not rsBets.EOF
'		      sql = "SELECT count(*) as cnt FROM users_bets_results ubr WHERE ubr.idbet = " & rsBets.Fields("idbet") & " AND ((idteam1 = 20 and ubr.goalsteam1 < ubr.goalsteam2) OR (idteam2 = 20 and ubr.goalsteam2 < ubr.goalsteam1))"
'		      rsTraidores.Open sql, cntDB,3,3
		      i = i + 1
'		      traidor = rsTraidores.Fields("cnt")
'		      If traidor > 0 Then
'		        If traidor > 2 Then
'		          bc = "#FF0000"
'		        Else
'		          If traidor > 1 Then
'		            bc = "#FF9999"
'		          Else
'		            bc = "#FFFF00"
'		          End If
'		        End If
'		      Else
		        If ((i mod 2)=0) then
		          bc = "#C0C0C0"
		        Else
		          bc = "#FF9933" '"#C0C0C0"
		        End If
'		      End If
'		      rsTraidores.Close
		      If rsBets.Fields("alias")=Session("userid") Then
		        setbold = "<b>"
		        endbold = "</b>"
		      Else
		        setbold = ""
		        endbold = ""
		      End If
  		      If rsBets.Fields("pts") <> prevPts Then
		        pos = i
		      End If
		      prevPts = rsBets.Fields("pts")
		      
%>	
    <tr>
      <td bgcolor="<%=bc%>" nowrap><font face="Verdana" size="1" color="#000000"><center><%=setbold%><%=pos%><%=endbold%></center></font></td>
      <td bgcolor="<%=bc%>" nowrap><font face="Verdana" size="1" color="#000000"><%=setbold%><%=left(rsBets.Fields("name"),1)%>.&nbsp;<%=rsBets.Fields("lastname")%>,&nbsp;<%=rsBets.Fields("betalias")%><%=endbold%></font></td>
      <td bgcolor="<%=bc%>"><font face="Verdana" size="1" color="#000000"><center><b><%=rsBets.Fields("pts")%></b></center></font></td>
<%
  		    sql = "SELECT ubr.goalsteam1 as g1, ubr.goalsteam2 as g2, ubr.points, gg.idgame FROM users_bets_results ubr, groupgames gg WHERE ubr.idgame = gg.idgame AND idbet = " & rsBets.Fields("idbet") & " ORDER BY gg.localdate, gg.idgame"
		    rsUserGames.Open sql,cntDB,3,3
		    j = 0
		    Do while not rsUserGames.EOF
		      j = j + 1
		      If ((j mod 2)=1) then
		        fc = "#000000"
		        If ((i mod 2)=0) then
		          bc = "#E2E2E2"
		        Else
		          bc = "#FFCC66" '"#C0C0C0"
		        End If
		      Else
		        fc = "#000000"
		        If ((i mod 2)=0) then
		          bc = "#C0C0C0"
		        Else
		          bc = "#FF9933" '"#C0C0C0"	
		        End If	      
		      End If
		      If rsUserGames.Fields("idgame") = nNextGame Then
		        setgamediv = "<b>"
		        endgamediv = "</b>"
		      Else
		        setgamediv = ""
		        endgamediv = ""
		      End If
'		      If traidor > 0 Then
'		        If traidor > 2 Then
'		          bc = "#FF0000"
'		        Else
'		          If traidor > 1 Then
'		            bc = "#FF9999"
'		          Else
'		            bc = "#FFFF00"
'		          End If
'		        End If
'		      End If
%>
      <td bgcolor="<%=bc%>"><font face="Verdana" size="1" color="<%=fc%>"><center><%=setbold%><%=setgamediv%><%=rsUserGames.Fields("g1")%>-<%=rsUserGames.Fields("g2")%><%=endgamediv%><%=endbold%></center></font></td>
      <td bgcolor="<%=bc%>"><font face="Verdana" size="1" color="<%=fc%>"><center><%=setbold%><%=setgamediv%><%=rsUserGames.Fields("points")%><%=endgamediv%><%=endbold%></center></font></td>
<%
		      rsUserGames.MoveNext
		    loop
		    rsUserGames.Close
%>      
    </tr>
<%    
	        rsBets.MoveNext
	      loop
	      rsBets.Close
	      cntDB.Close	
%>
  </table></td></tr>
	
</table>
<!------------------------------------------------------------------------------->      
      </td>
      </table>
    </td>
  </table>
</tr>
<tr>
  <img border="0" align="top" src="/quiniela/images/footerAmerica2016.jpg">
</tr>
</table>
</body>

</html>
