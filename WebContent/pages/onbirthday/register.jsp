<%
  String submitmsg = (String)request.getAttribute("submitmsg");
  if(submitmsg == null) submitmsg="";
%>

<%if(submitmsg !=null && submitmsg.length() > 0){%>
	<b><font color="FF6600"><%=submitmsg%></font></b><br/><br/>
<%}%>

<script language="JavaScript" type="text/javascript">
function validateFields(){
//	var message = "";
	//var busname = document.forms[0].busname.value;

	//if(busname == "" && busname.length < 1){
	//    message = message + "<font color='#FF0000'><li>Business Name is a required field.</li></font>";
  	//}

//	if(message != ""){
//		message = "<br/>" + message;
//	  document.getElementById("errorlist").innerHTML = message;
//	  return false;
//	}else{
//	  return true;
//	}
}
</script>

<form method="post" action="/submitregistration.do" onSubmit="return validateFields();" >
<table width="100%"><tr><td style="background-color:#def"><b>Customer Registration: Billing Information</b></td></tr><tr><td>&nbsp;</td></tr></table>
<div id="errorlist"></div>
<table>
	<tr>
		<td>Email Address:</td>
		<td><input type="text" name="email" size="40" maxlength="100" /></td>
	</tr>
	<tr>
		<td>Password:</td>
		<td><input type="password" name="password" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<td>Confirm Password:</td>
		<td><input type="password" name="password2" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td><input type="text" name="fname" size="40" maxlength="50" />
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><input type="text" name="lname" size="40" maxlength="50" />
	</tr>

	<tr>
		<td>Company:</td>
		<td><input type="text" name="company" size="40" maxlength="100" />
	</tr>
	<tr>
		<td>Billing Address:</td>
		<td><input type="text" name="address1" size="40" maxlength="200" />
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="text" name="address2" size="40" maxlength="200" />
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="city" size="40" maxlength="100" />
	</tr>
	<tr>
		<td valign="top">State:</td>
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
		<td>Zipcode:</td>
		<td><input type="text" name="zipcode" size="40" maxlength="15" />
	</tr>
	<tr>
		<td>Phone Number:</td>
		<td><input type="text" name="phone" size="40" maxlength="15" />
	</tr>
</table>
<table>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="middle"><input type="submit" name="submit" value="Register Me!" /></td>
	</tr>
</table>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
