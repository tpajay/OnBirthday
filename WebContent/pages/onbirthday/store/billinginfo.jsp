<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>

<%
	Customer customer = (Customer)session.getAttribute("customer");
	String email	= customer.getEmail() == null ? "" : customer.getEmail();
	String password	= customer.getPassword() == null ? "" : customer.getPassword();
	String fname	= customer.getFname() == null ? "" : customer.getFname();
	String lname	= customer.getLname() == null ? "" : customer.getLname();
	String company	= customer.getCompany() == null ? "" : customer.getCompany();
	String address1	= customer.getAddress1() == null ? "" : customer.getAddress1();
	String address2	= customer.getAddress2() == null ? "" : customer.getAddress2();
	String city		= customer.getCity() == null ? "" : customer.getCity();
	String state	= customer.getState() == null ? "" : customer.getState();
	String zipcode	= customer.getZipcode() == null ? "" : customer.getZipcode();
	String phone	= customer.getPhone() == null ? "" : customer.getPhone();
%>

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

<form method="post" action="/submitorderinfo.do" onSubmit="return validateFields();" >
<table width="100%"><tr><td style="background-color:#def"><b>Billing Information</b></td></tr><tr><td>&nbsp;</td></tr></table>
<div id="errorlist"></div>
<table>
	<tr>
		<td>Email Address:</td>
		<td><input type="text" name="email" size="40" value="<%=email%>" maxlength="100" /></td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td><input type="text" name="fname" size="40" value="<%=fname%>" maxlength="50" />
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><input type="text" name="lname" size="40" value="<%=lname%>" maxlength="50" />
	</tr>

	<tr>
		<td>Company:</td>
		<td><input type="text" name="company" size="40" value="<%=company%>" maxlength="100" />
	</tr>
	<tr>
		<td>Billing Address:</td>
		<td><input type="text" name="address1" size="40" value="<%=address1%>" maxlength="200" />
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="text" name="address2" size="40" value="<%=address2%>" maxlength="200" />
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="city" size="40" value="<%=city%>" maxlength="100" />
	</tr>
	<tr>
		<td>State:</td>
		<td><input type="text" name="state" size="40" value="<%=state%>" maxlength="20" />
	</tr>
	<tr>
		<td>Zipcode:</td>
		<td><input type="text" name="zipcode" size="40" value="<%=zipcode%>" maxlength="15" />
	</tr>
</table>
<table>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr>
		<td>Credit Card:</td>
		<td>
			<select name="CardType" size="1">
				<option value="" selected>Select Card</option>
				<option value="American Express">American Express</option>
				<option value="Discover">Discover</option>
				<option value="MasterCard">MasterCard</option>
				<option value="VISA">VISA</option>
			 </select>
		</td>
	</tr>
	<tr>
		<td>Name on Card:</td>
		<td><input type="text" name="cardname" size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>Card Number:</td>
		<td><input type="text" name="cardnumber" size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>Card Identification Number:</td>
		<td><input type="text" name="cardid" size="30" maxlength="10" /></td>
	</tr>
	<tr>
		<td>Expiration Date(MM/YY):</td>
		<td><input type="text" name="cardexpdate" size="30" maxlength="4" /></td>
	</tr>
</table>
<table>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="middle"><input type="submit" name="submit" value="Submit Order Information" /></td>
	</tr>
</table>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
