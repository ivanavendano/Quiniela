<!--#include file="includes/securitycheck.inc"-->
<%
If strProfile <> "ADMIN" Then
  response.Redirect("noautorizado.asp")
End If
%>
Chequeo de modificaciones a las quinielas en comptencia:<br>
Los dos valores presentados deben ser iguales<br><br>
<!--#include file="includes/md5.asp"-->
<%
  Dim rsAdmins
  txt = ""
  cntDB.Open dsn
  Set rsAdmins = Server.CreateObject("ADODB.Recordset")
  sql = "SELECT ub.alias & '|' & ub.idbet & '|' & ubr.idgame & '|' & ubr.idteam1 & '|' & ubr.idteam2 & '|' & ubr.goalsteam1 & '|' & ubr.goalsteam2 as ln FROM users_bets_results ubr, users_bets ub WHERE ubr.idbet = ub.idbet AND ub.paydate is not null AND ub.idbetformat = 3 ORDER BY ub.alias, ub.idbet, ubr.idgame"
  rsAdmins.Open sql,cntDB,3,3
  Do while not rsAdmins.EOF
  	txt = txt & rsAdmins.Fields("ln") & "<br>"
  	rsAdmins.MoveNext
  loop
  rsAdmins.Close
  cntDB.Close
  
  response.Write("Esperado: facfa9f527ba91a3dd26e371ccd88e6f<br>")
  response.Write("Obtenido: " & md5(txt) & "<br><br>")
  
%>
Click <b><a href="main.asp">aqui</a></b> para continuar