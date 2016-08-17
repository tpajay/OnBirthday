<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>

<link rel="stylesheet" href="../../resources/css/display.css" type="text/css" media="screen, print" />

<%
	//for testing only
	//RowSetDynaClass rc = (RowSetDynaClass)request.getAttribute("results");
	//List rowset = (List)rc.getRows();
	//DynaBean dbean = (DynaBean)rowset.get(1);
	//Object theid = (Object)dbean.get("busid");
%>
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
	<table width="100%"><tr><td bgcolor="#99CCFF"><b>Pending Businesses</b></td></tr><tr><td>&nbsp;</td></tr></table>
	<display:table name="requestScope.results.rows" id="row" class="its" sort="page" requestURI="/pendingtips.do" pagesize="25" decorator="com.onbirthday.decorator.DisplayWrapper">
		<display:column property="name" title="Business" sortable="true"/>
		<display:column property="city" title="City" sortable="true"/>
		<display:column property="state" title="State" sortable="true"/>
		<display:column property="category" title="Category" sortable="true"/>
		<display:column property="description" title="Description"/>
		<display:column property="admin1" title="Actions" />
	</display:table>
<%}%>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />