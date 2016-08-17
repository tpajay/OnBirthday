<%@ page import="java.util.*" %>
<form method="post" action="/approvetips.do" >
<%
	String id = (String)request.getAttribute("id") == null ? "" : (String)request.getAttribute("id");
	String name = (String)request.getAttribute("name") == null ? "" : (String)request.getAttribute("name");
	String address1 = (String)request.getAttribute("address1") == null ? "" : (String)request.getAttribute("address1");
	String address2 = (String)request.getAttribute("address2") == null ? "" : (String)request.getAttribute("address2");
	String city = (String)request.getAttribute("city") == null ? "" : (String)request.getAttribute("city");
	String state = (String)request.getAttribute("state") == null ? "" : (String)request.getAttribute("state");
	String zipcode = (String)request.getAttribute("zipcode") == null ? "" : (String)request.getAttribute("zipcode");
	String phone1 = (String)request.getAttribute("phone1") == null ? "" : (String)request.getAttribute("phone1");
	String phone2 = (String)request.getAttribute("phone2") == null ? "" : (String)request.getAttribute("phone2");
	String http = (String)request.getAttribute("http") == null ? "" : (String)request.getAttribute("http");
	String details = (String)request.getAttribute("details") == null ? "" : (String)request.getAttribute("details");
	String freemeal = (String)request.getAttribute("freemeal") == null ? "" : (String)request.getAttribute("freemeal");
	String forkids = (String)request.getAttribute("forkids") == null ? "" : (String)request.getAttribute("forkids");
	String category = (String)request.getAttribute("category") == null ? "" : (String)request.getAttribute("category");
	String expiresdttm = (String)request.getAttribute("expiresdttm") == null ? "" : (String)request.getAttribute("expiresdttm");
	String approved = (String)request.getAttribute("approved") == null ? "" : (String)request.getAttribute("approved");
	String paid = (String)request.getAttribute("paid") == null ? "" : (String)request.getAttribute("paid");
	String nationwide = (String)request.getAttribute("nationwide") == null ? "" : (String)request.getAttribute("nationwide");
	String nonstate = (String)request.getAttribute("nonstate") == null ? "" : (String)request.getAttribute("nonstate");
	ArrayList stateslist = (ArrayList)request.getAttribute("stateslist");

	//2004-01-01, 01/12/2004
	if(expiresdttm !=null && expiresdttm.length() > 0){
		String expdttm_year= expiresdttm.substring(0,4);
		String expdttm_month= expiresdttm.substring(5,7);
		String expdttm_day= expiresdttm.substring(8,10);
		expiresdttm = expdttm_month + "/" + expdttm_day + "/" + expdttm_year;
	}

	String frompage = (String)request.getParameter("frompage");
	if(frompage == null) frompage="pendingtips";
%>

<SCRIPT LANGUAGE="JavaScript">
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

<table>
	<tr>
		<td>ID:</td>
		<td><%=id%><input type="hidden" name="id" value="<%=id%>" /></td>
	</tr>
	<tr>
		<td>Business Name:</td>
		<td><input type="text" name="name" size="30" value="<%=name%>" maxlength="50"/></td>
	</tr>
	<tr>
		<td>Address(line1):</td>
		<td><input type="text" name="address1" value="<%=address1%>"  size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>Address(line2):</td>
		<td><input type="text" name="address2" value="<%=address2%>"  size="30" maxlength="100" /></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="city" value="<%=city%>"  size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>State:</td>
		<td><input type="text" name="state" value="<%=state%>"  size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td>Zipcode:</td>
		<td><input type="text" name="zipcode" value="<%=zipcode%>"  size="30" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="phone1" value="<%=phone1%>"  size="30" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Fax/Other:</td>
		<td><input type="text" name="phone2" value="<%=phone2%>"  size="30" maxlength="15" /></td>
	</tr>
	<tr>
		<td>Web Address:</td>
		<td><input type="text" name="http" value="<%=http%>"  size="30" maxlength="250" /></td>
	</tr>
	<tr>
		<td>Completely Free Meal?:</td>
		<td><input type="text" name="freemeal" value="<%=freemeal%>"  size="1" maxlength="1" /></td>
	</tr>
	<tr>
		<td>For Kids Only?:</td>
		<td><input type="text" name="forkids" value="<%=forkids%>"  size="1" maxlength="1" /></td>
	</tr>
	<tr>
		<td>Approved?:</td>
		<td><input type="text" name="approved" value="<%=approved%>"  size="1" maxlength="1" /></td>
	</tr>
	<tr>
		<td>Paid?:</td>
		<td><input type="text" name="paid" value="<%=paid%>"  size="1" maxlength="1" /></td>
	</tr>
	<tr>
		<td>Category:</td>
		<td><input type="text" name="category" value="<%=category%>"  size="50" maxlength="50" /></td>
	</tr>
	<tr>
		<td>Exp Date:</td>
		<td><input type="text" name="expiresdttm" value="<%=expiresdttm%>"  size="50" maxlength="10" /></td>
	</tr>
</table>
<table>
	<tr>
		<td>Non-State Business?&nbsp;
			<input type="text" name="nonstate" value="<%=nonstate%>"  size="1" maxlength="1" />
		</td>
	</tr>
	<tr>
		<td>Same deal for all locations?&nbsp;
			<input type="text" name="nationwide" value="<%=nationwide%>"  size="1" maxlength="1" />
		</td>
	</tr>
	<tr>
		<td>
			<%if(stateslist !=null){
				String[] stateArray =
					{"AL","AK","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"};

				int n = stateslist.size();
				String ittext = "";
				boolean exists=false;
				for (int y=0; y < stateArray.length;y++){
					exists=false;
					for(int i=0; i<n ; i++){
						ittext = (String)stateslist.get(i);
						if (stateArray[y].equalsIgnoreCase(ittext)){
							exists = true;%>
							<input type="checkbox" name="states" value="<%=stateArray[y]%>" checked /><%=stateArray[y]%>&nbsp; &nbsp;
						<%}
					}

					if(!exists){%>
						<input type="checkbox" name="states" value="<%=stateArray[y]%>" /><%=stateArray[y]%>&nbsp; &nbsp;
					<%}
				}
			}%>
			<br><input type=button value="Check All" onClick="this.value=check(this.form.states)">
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td valign="top">Details:<br/><textarea name="details" rows="5" cols="50" ><%=details%></textarea></td>
	</tr>
	<tr>
		<td valign="top">
			<input type="submit" name="submit" value="Submit" />
		</td>
	</tr>
</table>
<input type="hidden" name="frompage" value="<%=frompage%>" />
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />