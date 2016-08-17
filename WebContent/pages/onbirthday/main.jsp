<%
  String submitmsg = (String)request.getAttribute("submitmsg");
  if(submitmsg == null) submitmsg="";
%>
<script language="JavaScript" type="text/javascript">
	function validateFields(){
		var message = "";
		var state = document.forms[0].state.selectedIndex;
		if(state == "0"){
			message = "<br/><font color='#FF0000'><li>Please select a state.</li></font>";
		}
		if(message != ""){
			message = message + "<br/>";
			document.getElementById("errorlist").innerHTML = message;
			return false;
		}else{
		  return true;
		}
	}

	function hideFields(){
		document.getElementById("errorlist").innerHTML = "";
	}
</script>

<%if(submitmsg !=null && submitmsg.length() > 0){%>
	<b><font color="#FF6600"><%=submitmsg%></font></b><br/><br/>
<%}%>

<form method="post" action="/searchsubmit.do" onSubmit="return validateFields();" >

<table width="100%" cellpadding="6">
<tr><td>
	<table cellpadding="10" bgcolor="#66CCFF">
		<tr>
			<td align="left">
				<font size="2" FACE="Verdana, Arial, Helvetica" color="black">
					<b>Search for birthday deals in your state:</b>
				</font>
				<br/>
				<font size="1" FACE="Verdana, Arial, Helvetica" color="black">
					(all non-state businesses with deals will also be displayed. e.g. internet deals)
				</font>
			</td>
		</tr>
		<tr>
			<td align="left">
				<font size="2" FACE="Verdana, Arial, Helvetica">Please select a state:</font>
				&nbsp;&nbsp;
				<select name="state" size="1" onclick="hideFields()">
				<%String[] stateArray =
					{"","AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY"
					,"LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH"
					,"OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"};

					for (int i=0; i < stateArray.length;i++){%>
						<option name=<%=stateArray[i]%>><%=stateArray[i]%></option>
					<%}%>
				</select>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<input type="submit" name="submit" value="Search" />
				<div id="errorlist"></div>
			</td>
			<td>&nbsp</td>
		</tr>
	</table>
</td></tr>
</table>

<p>

<table width="100%" cellpadding="6">
<tr><td>Do you know a birthday deal?  click <a href="/sendtip.do">here</a> to let us know!</td></tr>
</table>