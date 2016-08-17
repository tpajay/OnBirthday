<%
  String submitmsg = (String)request.getAttribute("submitmsg");
  if(submitmsg == null) submitmsg="";

  String busid = (String)request.getAttribute("busid");
  if(busid == null) busid="";

  String choosenstate = (String)request.getAttribute("choosenstate");
  if(choosenstate == null) choosenstate="";
%>

<table>
	<tr>
		<td valign="top">
			<br><br>
			<font size="2" FACE="Verdana, Arial, Helvetica">

				<%if(submitmsg !=null && submitmsg.length() > 0){%>
					<b><font color="FF6600"><%=submitmsg%></font></b><br/><br/>
				<%}%>

				<br/><br/>

				<%if(busid.length() > 1){%>
					<a href="/searchdetails.do?id=<%=busid%>&choosenstate=<%=choosenstate%>" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;&laquo;&nbsp;go back to deal</a>
					<br/><br/>
				<%}%>

				<%if(choosenstate.length() > 1){%>
					<a href="/searchsubmit.do?state=<%=choosenstate%>" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;&laquo;&nbsp;go back to deals list</a>
				<%}else{%>
					<a href="/home.do" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;&laquo;&nbsp;go to homepage</a>
				<%}%>

			</font>
		</td>
	<tr>
</table>

