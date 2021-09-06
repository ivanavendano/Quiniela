<!--
<%strHeader = "HeaderEuro2021.jpg"%>
<html>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<%If instr(strHeader,"\") > 0 Then%>
  <img border="0" align="top" src="/quiniela/<%=strHeader%>">
<%Else%>
  <img border="0" align="top" src="/quiniela/images/<%=strHeader%>">
<%End If%>
</tr>
<tr bgcolor="#000000">
<font face="Verdana" size="1" color="FFFFFF"><b>&nbsp;Usuario: <%=Session("userid")%></b></font>
</tr>
</table>
</html>
-->
<base target="_top">
<html>
<table border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="#00007F"><td><p align="right">
<font face="Verdana" size="1" color="FFFFFF">
<% If len(Session("userid")) > 0 Then %>
	<b>&nbsp;Estas conectado como <%=Session("userid")%></b> | <a href="/quiniela/logout.asp">Desconectarme</a>&nbsp;</font>
<% Else %>
	<b>&nbsp;</b>
<% End If %>
</p></td></tr>
<tr><td>
<%If instr(strHeader,"\") > 0 Then%>
  <img border="0" align="top" src="/quiniela/<%=strHeader%>">
<%Else%>
  <img border="0" align="top" src="/quiniela/images/<%=strHeader%>">
<%End If%>
</td></tr>
<tr bgcolor="#00007F"><td><p align="right">
<font face="Verdana" size="1" color="FFFFFF">&nbsp;</font>
</p></td></tr>
</table>
</html>