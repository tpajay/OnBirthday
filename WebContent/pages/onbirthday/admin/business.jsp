<script language="JavaScript" type="text/javascript">
function validateFields(){
	var message = "";
	//var name = document.forms[0].name.value;
	//var state = document.forms[0].state.selectedIndex;

	//if(name == "" && name.length < 1){
	//    message = message + "<font color='#FF0000'><li>Name is a required field.</li></font>";
  	//}

	//if(message != ""){
	//	message = "<br/>" + message;
	//	document.getElementById("errorlist").innerHTML = message;
	//	return false;
	//}else{
	//  return true;
	//}
	return true;
}

var checkflag = "false";
function check(field) {
	if (checkflag == "false") {
		for (i = 0; i < field.length; i++) {
			field[i].checked = true;
		}
		checkflag = "true";
		return "Uncheck All";
	}else{
		for (i = 0; i < field.length; i++) {
			field[i].checked = false;
		}
	checkflag = "false";
	return "Check All";
	}
}
</script>

<form method="post" action="/businesssubmit.do" onSubmit="return validateFields();" >
<table>
	<tr>
		<td>
			Create a Business.
			<br/>* marks required fields.
		</td>
	</tr>
</table>
<div id="errorlist"></div>
<table>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>Business Name:</td>
		<td><input type="text" name="name" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>Address(line1):</td>
		<td><input type="text" name="address1" size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>Address(line2):</td>
		<td><input type="text" name="address2" size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="city" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>State:</td>
		<td>
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
		<td><input type="text" name="zipcode" size="30" value="" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="phone1" size="30" value="" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Fax/Other:</td>
		<td><input type="text" name="phone2" size="30" value="" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Web Address:</td>
		<td><input type="text" name="http" size="30" value="http://" maxlength="250" /></td>
	</tr>
	<tr>
		<td>Completely Free Meal?:</td>
		<td>
			<select name="freemeal" size="1">
				<option name="N">N</option>
				<option name="Y">Y</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>For Kids Only??:</td>
		<td>
			<select name="forkids" size="1">
				<option name="N">N</option>
				<option name="Y">Y</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>Category:</td>
		<td>
			<select name="category" size="1">
				<option name="Other">Other</option>
				<option name="American">American</option>
				<option name="Bakery/Bagels">Bakery/Bagels</option>
				<option name="Barbecue">Barbecue</option>
				<option name="Brew Pub">Brew Pub</option>
				<option name="Burgers">Burgers</option>
				<option name="Cajun">Cajun</option>
				<option name="Caribbean">Caribbean</option>
				<option name="Chinese">Chinese</option>
				<option name="Deli">Deli</option>
				<option name="Diner">Diner</option>
				<option name="Ethnic">Ethnic</option>
				<option name="French">French</option>
				<option name="German">German</option>
				<option name="Indian">Indian</option>
				<option name="Italian">Italian</option>
				<option name="Japanese">Japanese</option>
				<option name="Korean">Korean</option>
				<option name="Mexican">Mexican</option>
				<option name="Mid-East">Mid-East</option>
				<option name="Pasta">Pasta</option>
				<option name="Pizza">Pizza</option>
				<option name="Sandwiches">Sandwiches</option>
				<option name="Salads">Salads</option>
				<option name="Seafood">Seafood</option>
				<option name="Southwest">Southwest</option>
				<option name="Steak">Steak</option>
				<option name="Thai">Thai</option>
				<option name="Vietnamese">Vietnamese</option>
				<option name="Variety">Variety</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>if expires, Date(mm/dd/yyyy):</td>
		<td><input type="text" name="expiresdttm" size="30" maxlength="10" /></td>
	</tr>
</table>
<table>
	<tr>
		<td>Same deal for all locations?&nbsp;
			<select name="nationwide" size="1">
				<option name="D">Not Sure</option>
				<option name="N">N</option>
				<option name="Y">Y</option>
			</select>(if multiple states this should be Y)
		</td>
	</tr>
	<tr>
		<td>Non-State related Business, e.g.internet site?&nbsp;
			<select name="nonstate" size="1">
				<option name="N">N</option>
				<option name="Y">Y</option>
			</select>
		</td>
	</tr>
	<tr><td>Select all State locations:</td></tr>
	<tr>
		<td>
			<input type="checkbox" name="states" value="AL" />AL&nbsp;&nbsp;
			<input type="checkbox" name="states" value="AK" />AK&nbsp;&nbsp;
			<input type="checkbox" name="states" value="AR" />AR&nbsp;&nbsp;
			<input type="checkbox" name="states" value="AZ" />AZ&nbsp;&nbsp;
			<input type="checkbox" name="states" value="CA" />CA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="CO" />CO&nbsp;&nbsp;
			<input type="checkbox" name="states" value="CT" />CT&nbsp;&nbsp;
			<input type="checkbox" name="states" value="DC" />DC&nbsp;&nbsp;
			<input type="checkbox" name="states" value="DE" />DE&nbsp;&nbsp;
			<input type="checkbox" name="states" value="FL" />FL&nbsp;&nbsp;
			<input type="checkbox" name="states" value="GA" />GA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="HI" />HI&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="states" value="IA" />IA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="ID" />ID&nbsp;&nbsp;
			<input type="checkbox" name="states" value="IL" />IL&nbsp;&nbsp;
			<input type="checkbox" name="states" value="IN" />IN&nbsp;&nbsp;
			<input type="checkbox" name="states" value="KS" />KS&nbsp;&nbsp;
			<input type="checkbox" name="states" value="KY" />KY&nbsp;&nbsp;
			<input type="checkbox" name="states" value="LA" />LA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MA" />MA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MD" />MD&nbsp;&nbsp;
			<input type="checkbox" name="states" value="ME" />ME&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MI" />MI&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MN" />MN&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MO" />MO&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="states" value="MS" />MS&nbsp;&nbsp;
			<input type="checkbox" name="states" value="MT" />MT&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NC" />NC&nbsp;&nbsp;
			<input type="checkbox" name="states" value="ND" />ND&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NE" />NE&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NH" />NH&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NJ" />NJ&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NM" />NM&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NV" />NV&nbsp;&nbsp;
			<input type="checkbox" name="states" value="NY" />NY&nbsp;&nbsp;
			<input type="checkbox" name="states" value="OH" />OH&nbsp;&nbsp;
			<input type="checkbox" name="states" value="OK" />OK&nbsp;&nbsp;
			<input type="checkbox" name="states" value="OR" />OR&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="states" value="PA" />PA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="PR" />PA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="RI" />RI&nbsp;&nbsp;
			<input type="checkbox" name="states" value="SC" />SC&nbsp;&nbsp;
			<input type="checkbox" name="states" value="SD" />SD&nbsp;&nbsp;
			<input type="checkbox" name="states" value="TN" />TN&nbsp;&nbsp;
			<input type="checkbox" name="states" value="TX" />TX&nbsp;&nbsp;
			<input type="checkbox" name="states" value="UT" />UT&nbsp;&nbsp;
			<input type="checkbox" name="states" value="VT" />VT&nbsp;&nbsp;
			<input type="checkbox" name="states" value="VA" />VA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="WA" />WA&nbsp;&nbsp;
			<input type="checkbox" name="states" value="WI" />WI&nbsp;&nbsp;
			<input type="checkbox" name="states" value="WV" />WV&nbsp;&nbsp;
			<input type="checkbox" name="states" value="WY" />WY&nbsp;&nbsp;
		</td>
	</tr>
	<tr><td><input type=button value="Check All" onClick="this.value=check(this.form.states)"></td></tr>
	<tr>
		<td valign="top">Details:<br/><textarea name="details" rows="5" cols="50" maxlength="1000"></textarea></td>
	</tr>
	<tr>
		<td valign="top"><input type="submit" name="submit" value="Submit" /></td>
	</tr>
</table>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
