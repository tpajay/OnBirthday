<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<%
	String busid = (String)request.getAttribute("busid") == null ? "" : (String)request.getAttribute("busid");
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
	String category = (String)request.getAttribute("category") == null ? "" : (String)request.getAttribute("category");
	String nationwide = (String)request.getAttribute("nationwide") == null ? "" : (String)request.getAttribute("nationwide");
	String nonstate = (String)request.getAttribute("nonstate") == null ? "" : (String)request.getAttribute("nonstate");

	//String http_map_link = "window.open('http://www.mapquest.com/maps/map.adp?city=" + city + "&state=" + state + "&address=" + address1 + "&zip=" + zipcode + "&country=us&zoom=7','MapLink')";
	String http_map_link = "window.open('http://maps.google.com/maps?f=q&hl=en&q=" + address1 + "+" + city + "+" + state + "+" + zipcode + "&om=1','MapLink')";

	//checking to see if it is a web based business
	String webname = "";
	int index = name.indexOf(".");
	if(index > 0){webname = name.substring(index);}

	ArrayList blogs_array = (ArrayList)request.getAttribute("blogs_array");
	if(blogs_array == null) blogs_array = new ArrayList();
	HashMap blogs_hm = new HashMap();

	String choosenstate = (String)request.getAttribute("choosenstate");
	if(choosenstate==null)choosenstate="";

%>

<style>

.header
{
    display: inline;
    border-left: 1px solid #C3BEBA;
    border-top: 1px solid #C3BEBA;
    border-right: 1px solid #C3BEBA;
    font-weight: bold;
    padding: 1px 3px 3px 3px;
    color: #000000;
    background-color: #F4F3F0;
}

.headerline
{
    border-top: 1px solid #C3BEBA;
    margin-top: 3px;
    margin-bottom: 15px;
    position:relative;
}

</style>

<script language="JavaScript" type="text/javascript">
function showMsgDiv(){
	var content = document.getElementById("sendmsg").innerHTML;
	document.getElementById("sendmsg1").innerHTML = content;
	var sendmsg = document.getElementById("sendmsg");
	//sendmsg.style.visibility='visible';
}

function ValidateMsgFields(){
	var message = "";
	var comment = document.forms[0].comment.value;

	if(comment == "" && comment.length < 1){
	    message = message + "<font color='#FF0000'><li>Comment is a required field.</li></font><br/>";
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
	<table width="100%">
		<tr>
			<td style="background-color:#def">
				<font size='3' FACE='Verdana, Arial, Helvetica'><b style="line-height: 18pt"><%=name%></b></font>
			</td>
		</tr>
		<tr>
			<td>
				<font size='2' FACE='Verdana, Arial, Helvetica'><a href="javascript://" onclick="window.open('<%=http%>','BusLink')"><%=http%></a></font>
			</td>
		</tr>
	</table>

	<table width="100%">
	<tr>
	<td width="65%">
		<%if(nationwide.equalsIgnoreCase("N")){%>
		<table width="60%">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					<div class="header"><b><font size="2">Contact Information</font></b></div>
					<div class="headerline"></div>
					<font size="2">
					<%=address1%><br/>
					<%=city%>,<%=state%>&nbsp;<%=zipcode%>&nbsp;&nbsp;<a href="javascript://" onclick="<%=http_map_link%>">Map it!</a><br/>
					<%if(phone1 !=null && phone1.length() > 0){%>
						<br/><%=phone1%>
					<%}%>
					<%if(phone2 !=null && phone2.length() > 0){%>
						<br/><%=phone2%>
					<%}%>
					</font>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
		</table>
		<table width="60%">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					<div class="header"><b><font size="2">Details</font></b></div>
					<div class="headerline"></div>
					<font size="2">
					<%=details%><br/>
					</font>
				</td>
			</tr>
		</table>
		<%}else if((webname.equals(".com")) || (nonstate.equalsIgnoreCase("Y"))){%>
		<table width="60%">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					<div class="header"><b><font size="2">Details</font></b></div>
					<div class="headerline"></div>
					<font size="2">
					<%=details%><br/>
					</font>
				</td>
			</tr>
		</table>
	<%}else{%>
		<table width="60%">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					* This Business has multiple locations.  Click the web link above and use the businesses website to find the location nearest to you.
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					<div class="header"><b><font size="2">Contact Number</font></b></div>
					<div class="headerline"></div>
					<font size="2">
					<%if(phone1 !=null && phone1.length() > 0){%>
						<%=phone1%>
					<%}%>
					<%if(phone2 !=null && phone2.length() > 0){%>
						<br/><%=phone2%>
					<%}%>
					</font>
				</td>
			</tr>
		</table>
		<table width="60%">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>
					<div class="header"><b><font size="2">Details</font></b></div>
					<div class="headerline"></div>
					<font size="2">
					<%=details%><br/>
					</font>
				</td>
			</tr>
		</table>
	<%}%>

	<table width="60%">
		<tr><td>
			<br/><br/><br/><br/>
			<a href="/searchsubmit.do?state=<%=choosenstate%>">&laquo;&nbsp;go back to deals list</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript://" onclick="showMsgDiv()">add blog about this deal</a>
			<br/><br/><br/>
			<div id="sendmsg1" name="sendmsg1"></div>
			<font size="3" color="orange"><b style="line-height: 18pt">Blogs about this deal</b></font>
			<hr width="100%" align="left">
			<%
			String createdttm = "";
			String comment = "";
			String username = "";
			String approved = "";
			for(int i = 0; i < blogs_array.size(); i++){
				blogs_hm = (HashMap)blogs_array.get(i);
				createdttm = (String)blogs_hm.get("createdttm");
				username = (String)blogs_hm.get("username");
				comment = (String)blogs_hm.get("comment");
				approved = (String)blogs_hm.get("approved");

				if(approved.equalsIgnoreCase("Y")){
			%>

				<b style="line-height: 18pt"><%=createdttm%>&nbsp;by&nbsp;<%=username%></b>
				<br/>
				<%=comment%>
				<br/>
				<hr width="100%" align="left">
				<p>

			<%
				}

			}%>
			<%if(blogs_array.size() < 1){%>
				None.
			<%}%>
			</td></tr>
			</table>
		</td>
		</tr>
	</table>
</td>
<td align="center" valign="top">
	<center>
		<script type="text/javascript"><!--
		google_ad_client = "pub-7043300296150118";
		google_ad_width = 300;
		google_ad_height = 250;
		google_ad_format = "300x250_as";
		google_ad_type = "image";
		google_ad_channel = "";
		google_ui_features = "rc:6";
		//-->
		</script>
		<script type="text/javascript"
		  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
	</center>
</td></tr>
</table>

<div id="sendmsg" name="sendmsg" style="visibility:hidden">
		<div id="errorlist" name="errorlist"></div>
		<table cellpadding="10px" style="border-color: lightgrey;border-style: dashed"><tr><td>
		Please enter a comment concerning this deal and click the Send button<br/>
		<form method="post" action="/commentcreate.do" onSubmit="return ValidateMsgFields();" >
			<input type="hidden" name="busid" value="<%=busid%>" />
			<input type="hidden" name="busname" value="<%=name%>" />
			<input type="hidden" name="choosenstate" value="<%=choosenstate%>" />
			<br/>
			Name:&nbsp;&nbsp;<input type="text" name="username" maxlength="20" /> (Optional)
			<br/><br/>
			Comment:<br/>
			<textarea name="comment" rows="4" cols="50" maxlength="250"></textarea>
			<br/><br/>
			<input type="submit" name="submit" value="Send" />
		</form>
		</td></tr></table>
		<br/><br/>
	</div>

<br/><br/>
