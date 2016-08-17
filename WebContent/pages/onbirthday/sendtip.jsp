<%
  String submitmsg = (String)request.getAttribute("submitmsg");
  if(submitmsg == null) submitmsg="";
%>

<%if(submitmsg !=null && submitmsg.length() > 0){%>
	<b><font color="FF6600"><%=submitmsg%></font></b><br/><br/>
<%}%>

<script language="JavaScript" type="text/javascript">
function validateFields(){
	var message = "";
	var busname = document.forms[0].busname.value;
	var details = document.forms[0].details.value;

	if(busname == "" && busname.length < 1){
	    message = message + "<font color='#FF0000'><li>Business Name is a required field.</li></font>";
  	}
  	if(details == "" && details.length < 1){
	    message = message + "<font color='#FF0000'><li>Details is a required field.</li></font>";
  	}
	if(message != ""){
		message = "<br/>" + message;
	  document.getElementById("errorlist").innerHTML = message;
	  return false;
	}else{
	  return true;
	}
}
</script>

<table width="100%" cellpadding="6">
<tr><td>
	<form method="post" action="/createtip.do" onSubmit="return validateFields();" >
	<table cellpadding="10" style="border:dashed 1px;background-color:#9cf">
		<tr><td>
			<font size="1">
			<b><i>Submitting a birthday "deal" basics:</i></b><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;Deals are not limited to meals (breakfast, lunch, dinner, dessert)<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;Deals are not limited to only free offers<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;Deals are special offers/bargains someone can get on his or her birthday<br/>
			<br/>
			<b><i>Examples of a birthday "deal":</i></b><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;What about a free/discounted car wash?<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;What about free/discounted admission into club, movie, show?<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;What about a free/discounted hair cut, style, nails, facial, etc?<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&raquo;&nbsp;We just want to know where to get the deals!  Let us know!<br/>
			</font>
		</td></tr>
	</table>
	<div id="errorlist"></div>
	<table>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td><b>Your Information:</b></td>
			<td><b>(optional)</b></td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="sendername" size="30" maxlength="50" /></td>
		</tr>
		<tr>
			<td>Email:</td>
			<td><input type="text" name="senderemail" size="30" maxlength="50" /></td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td><b>About the Deal:</b></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Business Name:</td>
			<td><input type="text" name="busname" size="30" maxlength="50" /></td>
		</tr>
	</table>
	<table>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td valign="top">
				Details (Please provide as much detail as possible):
				<br/>
				<textarea name="details" rows="5" cols="50" maxlength="1000"></textarea>
			</td>
		</tr>
		<tr>
			<td valign="top"><br/><input type="submit" name="submit" value="Send Deal!" /></td>
		</tr>
	</table>
	</form>
	<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
</td></tr>
</table>

<script>
	document.forms[0].sendername.focus();
</script>
