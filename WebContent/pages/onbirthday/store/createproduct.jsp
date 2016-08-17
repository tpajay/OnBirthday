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

<form method="post" action="/submitproduct.do" onSubmit="return validateFields();" >
<table>
	<tr>
		<td>
			<b><u>Create a new product.</u></b>
		</td>
	</tr>
</table>
<div id="errorlist"></div>
<table>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>Product ID/SKU:</td>
		<td><input type="text" name="sku" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>List Price:</td>
		<td><input type="text" name="listprice" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>Actual Price:</td>
		<td><input type="text" name="price" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>Quantity in Stock:</td>
		<td><input type="text" name="stock" size="30" maxlength="50" />
	</tr>
	<tr>
		<td>Small Image Link:</td>
		<td><input type="text" name="imagelink" value="http://" size="30" maxlength="250" />
	</tr>
	<tr>
		<td>Large Image Link:</td>
		<td><input type="text" name="imagelinklarge" value="http://" size="30" maxlength="250" />
	</tr>
	<tr>
		<td>Order Link:</td>
		<td><input type="text" name="orderlink" value="http://" size="30" maxlength="250" />
	</tr>
	<tr>
		<td>Category:</td>
		<td>
			<select name="category" size="1">
				<option name="Other">Other</option>
				<option name="Automotive">Automotive</option>
				<option name="Beauty & Fragrances">Beauty & Fragrances</option>
				<option name="Books & Magazines">Books & Magazines</option>
				<option name="Clothing & Accessories">Clothing & Accessories</option>
				<option name="Computers">Computers</option>
				<option name="Electronics">Electronics</option>
				<option name="Video Games">Video Games</option>
				<option name="Flowers & Gifts">Flowers & Gifts</option>
				<option name="Health & Personal Care">Health & Personal Care</option>
				<option name="Home & Garden">Home & Garden</option>
				<option name="Jewelry & Watches">Jewelry & Watches</option>
				<option name="Movies & DVD">Movies & DVD</option>
				<option name="Music">Music</option>
				<option name="Office Supplies">Office Supplies</option>
				<option name="Sports & Outdoors">Sports & Outdoors</option>
				<option name="Tools & Hardware">Tools & Hardware</option>
				<option name="Toys & Baby">Toys & Baby</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>Description:</td>
		<td><input type="text" name="description" size="50" maxlength="200" />
	</tr>
</table>
<table>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="top">Details:<br/><textarea name="details" rows="5" cols="50" maxlength="250"></textarea></td>
	</tr>
	<tr>
		<td valign="top"><input type="submit" name="submit" value="Submit" /></td>
	</tr>
</table>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
