<%
  String submitmsg = (String)request.getAttribute("submitmsg");
  if(submitmsg == null) submitmsg="";
%>

<script language="JavaScript" type="text/javascript">
function validateFields(){
	var message = "";
	var name = document.forms[0].name.value;
	var password = document.forms[0].password.value;

	if(name == "" && name.length < 1){
  		message = message + "<font color='#FF0000'><li>Username is a required field.</li></font>";
  	}
	if(password == "" && password.length < 1){
  		message = message + "<font color='#FF0000'><li>Password is a required field.</li></font>";
  	}

	if(message != ""){
		message = "<br/>" + message + "<br/>";
		document.getElementById("errorlist").innerHTML = message;
		return false;
	}else{
	  return true;
	}
}
</script>

<form method="post" action="/loginsubmit.do" onSubmit="return validateFields();" >

<div id="errorlist"></div>
<%if(submitmsg !=null && submitmsg.length() > 0){%>
	<b><font color="FF6600"><%=submitmsg%></font></b><br/><br/>
<%}%>
<table width="70%">
	<tr>
		<td valign="top" width="200px" >
			<table width="100%">
				<tr><td style="background-color:#def"><b><u>New Here?</u></b></td></tr>
				<tr>
					<td>
						<table>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td>
									<a href="/register.do">Register</a>
								</td>
							</tr>
							<tr>
								<td>
									<!--<a href="/register.do">Continue without Registering</a>-->
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td width="1px" bgcolor="dcdcdc" >&nbsp;</td>
		<td valign="top" width="200px">
			<table width="100%">
				<tr><td style="background-color:#def"><b><u>Sign In</u></b></td></tr>
					<tr>
						<td>
							<table>
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td valign="middle">Email Address:</td>
									<td valign="middle"><input type="text" name="email" size="25" maxlength="50" /></td>
								</tr>
								<tr>
									<td valign="middle">Password:</td>
									<td valign="middle"><input type="password" name="password" size="25" maxlength="50" /></td>
								</tr>
								<tr>
									<td valign="middle">&nbsp;</td>
									<td valign="middle"><input type="submit" name="submit" value="Login" /></td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
		</td>
</table>
</form>

<script>
	document.forms[0].email.focus();
</script>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
