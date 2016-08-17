<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>

<link rel="stylesheet" href="../../resources/css/display.css" type="text/css" media="screen, print" />

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
<% if(cust_email.length() > 0 && cust_email.equalsIgnoreCase("jayathena@gmail.com")){%>
	<table width="100%"><tr><td bgcolor="#99CCFF"><b>Comments</b></td></tr><tr><td>&nbsp;</td></tr></table>
	<display:table name="requestScope.results.rows" id="table1" class="its" sort="list" requestURI="/commentsearchsubmit.do" pagesize="900" decorator="com.onbirthday.decorator.DisplayWrapper">
		<display:column property="createdttm" title="Created" sortable="true"/>
		<display:column property="email" title="Email"  sortable="true"/>
		<display:column property="comment" title="Comment" sortable="true"/>
		<display:column property="busname" title="BusName" sortable="true"/>
		<display:column property="busid" title="ID" sortable="true"/>
		<display:column property="admin3" title="Actions" />
	</display:table>
<%}%>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />