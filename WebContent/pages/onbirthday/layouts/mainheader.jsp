<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>

<%
	Customer customer = (Customer)session.getAttribute("customer");
	if(customer==null) customer = new Customer();
	String cust_email	= customer.getEmail() == null ? "" : customer.getEmail();
	String cust_password	= customer.getPassword() == null ? "" : customer.getPassword();
	String cust_fname	= customer.getFname() == null ? "" : customer.getFname();
	String cust_lname	= customer.getLname() == null ? "" : customer.getLname();
	String cust_company	= customer.getCompany() == null ? "" : customer.getCompany();
	String cust_address1	= customer.getAddress1() == null ? "" : customer.getAddress1();
	String cust_address2	= customer.getAddress2() == null ? "" : customer.getAddress2();
	String cust_city		= customer.getCity() == null ? "" : customer.getCity();
	String cust_state	= customer.getState() == null ? "" : customer.getState();
	String cust_zipcode	= customer.getZipcode() == null ? "" : customer.getZipcode();
	String cust_phone	= customer.getPhone() == null ? "" : customer.getPhone();

	Calendar rightNow = Calendar.getInstance();
%>

<table width="100%" cellpadding="6px" cellspacing="0px" style="background-color:#99CCFF">
	<tr>
		<td width="5%" valign="top">
			<a href="/home.do"><img src="../../resources/images/logo2d.gif" border=0/></a>
		</td>
		<td valign="bottom" align="left">
			<b>
			<font size="1" FACE="Verdana, Arial, Helvetica">
				<FONT COLOR="#333399" size="1">|&nbsp;</font>
				<a href="/home.do" style="text-decoration: none"><FONT COLOR="#FF6600">search</font></a>
				<FONT COLOR="#333399">&nbsp;&nbsp;&#8226;&nbsp;&nbsp;</font>
				<a href="/sendtip.do" style="text-decoration: none"><FONT COLOR="#FF0000">send a deal</font></a>
				<FONT COLOR="#333399">&nbsp;&nbsp;&#8226;&nbsp;&nbsp;</font>
				<a href="/faq.do" style="text-decoration: none"><FONT COLOR="#FF6600">faq</font></a>
				<FONT COLOR="#333399">&nbsp;&nbsp;&#8226;&nbsp;&nbsp;</font>
				<a href="/contactus.do" style="text-decoration: none"><FONT COLOR="#FF6600">contact us</font></a>
				<FONT COLOR="#333399" size="1">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
			</font>
			</b>
		</td>
		<td valign="bottom" align="right">
			<!--<b>Last Updated:
			<%= (rightNow.get(Calendar.MONTH)<9?"0":"") + (rightNow.get(Calendar.MONTH)+1) + "/" + (rightNow.get(Calendar.DATE)<10?"0":"") + rightNow.get(Calendar.DATE) + "/" + rightNow.get(Calendar.YEAR)%>
			&nbsp;&nbsp;&nbsp;</b>-->
			<%if(cust_email.length() > 0){%>
				<b>Welcome,&nbsp;</b>&nbsp;<%=customer.getEmail()%>&nbsp;&nbsp;
			<%}%>
		</td>
	</tr>
</table>
<%if(cust_email.length() > 0 && cust_email.equalsIgnoreCase("jayathena@gmail.com")){%>
<table width="100%">
	<tr>
		<td valign="middle" style="background-color:#9cf" HEIGHT="20" >
			<font size="1" FACE="Verdana, Arial, Helvetica">
					&nbsp;&nbsp;
					<b>
					<a href="/commentsearchsubmit.do" style="text-decoration: none"><FONT COLOR="#FF9900">comments</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/pendingtips.do" style="text-decoration: none"><FONT COLOR="#FF9900">pending tips</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/searchallsubmit.do" style="text-decoration: none"><FONT COLOR="#FF9900">all businesses</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/businesscreate.do" style="text-decoration: none"><FONT COLOR="#FF9900">create business</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/createproduct.do" style="text-decoration: none"><FONT COLOR="#FF9900">create product</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/loadfeeds.do" style="text-decoration: none"><FONT COLOR="#FF9900">feed loader</font></a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/products.do?category=gifts" style="text-decoration: none">gifts</a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/products.do" style="text-decoration: none">all products</a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
					<a href="/cart.do" style="text-decoration: none">shopping cart</a>&nbsp;&nbsp;&#124&nbsp;&nbsp;&nbsp;
				</b>
			</font>
		</td>
	</tr>
</table>
<%}%>
