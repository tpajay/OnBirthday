<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<link rel="stylesheet" href="../../resources/css/display.css" type="text/css" media="screen, print" />

<table>
	<tr>
		<td>
			Click heading label to sort by column.
		</td>
	</tr>
</table>

<br/>

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
%>
<%if(cust_email.length() > 0 && cust_email.equalsIgnoreCase("jayathena@gmail.com")){%>
	<display:table name="requestScope.results.rows" class="its" id="table1" sort="list" requestURI="/searchallsubmit.do" pagesize="25" decorator="com.onbirthday.decorator.DisplayWrapper">
		<display:column property="name" title="Business" href="/searchdetails.do" paramId="id" paramProperty="busid" sortable="true"/>
		<display:column property="city" title="City" sortable="true"/>
		<display:column property="elstate" title="State" sortable="true"/>
		<display:column property="approved" title="Approved?" sortable="true"/>
		<display:column property="paid" title="Paid?" sortable="true"/>
		<display:column property="category" title="Category" sortable="true"/>
		<display:column property="admin2" title="Actions" />
	</display:table>
<%}%>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />