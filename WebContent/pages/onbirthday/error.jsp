<%
	String error1 = (String)request.getAttribute("errormsg1");
	if(error1 == null) error1="";
	String error2 = (String)request.getAttribute("errormsg2");
	if(error2 == null) error2="";
	String error3 = (String)request.getAttribute("errormsg3");
	if(error3 == null) error3="";
%>
<table>
	<tr>
		<td valign="top">
				ERROR:<br/>
				<%=error1%><br/><br/>
				<%=error2%><br/><br/>
				<%=error3%><br/><br/>
		</td>
	<tr>
</table>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/>
<table width="100%">
	<tr><td align="center">---------------</td></tr>
</table>
