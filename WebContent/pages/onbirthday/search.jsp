<script language="JavaScript" type="text/javascript">
function validateFields(){
	var message = "";
	var state = document.forms[0].state.selectedIndex;

	if(state == "0"){
		message = "<font color='#FF0000'><li>Please select a state.</li></font>";
	}


	if(message != ""){
		message = message + "<br/>";
		document.getElementById("errorlist").innerHTML = message;
		return false;
	}else{
	  return true;
	}
}
</script>

<table width="100%"><tr><td style="background-color:#def"><b>Search for a Deal</b></td></tr><tr><td>&nbsp;</td></tr></table>
<form method="post" action="/searchsubmit.do" onSubmit="return validateFields();" >

<div id="errorlist"></div>
<table>
	<tr>
		<td valign="top"><font size="2" FACE="Verdana, Arial, Helvetica">Please select your state:</font></td>
		<td valign="top">
			<select name="state" size="1">
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
		<td valign="top"><input type="submit" name="submit" value="Search" /></td>
		<td>&nbsp</td>
	</tr>
</table>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
