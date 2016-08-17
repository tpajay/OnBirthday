<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<link rel="stylesheet" href="../../resources/css/display.css" type="text/css" media="screen, print" />

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

<%
	RowSetDynaClass rc = (RowSetDynaClass)request.getAttribute("results");
	List list = (List)rc.getRows();
	org.apache.commons.beanutils.DynaBean data = (org.apache.commons.beanutils.DynaBean)list.get(0);

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

	String choosenstate = (String)request.getAttribute("choosenstate");
	if(choosenstate==null)choosenstate="";
%>

<%if(cust_email.length() > 0 && cust_email.equalsIgnoreCase("jayathena@gmail.com")){%>
	<table cellpadding="5" width="95%">
		<tr>
		<td width="90%">
			<display:table name="requestScope.results.rows" class="its" id="table1" sort="list" requestURI="/searchsubmit.do" pagesize="40" decorator="com.onbirthday.decorator.DisplayWrapper">
				<display:column class="w15" property="name" title="Business" href="/searchdetails.do" paramId="id" paramProperty="busid" sortable="true"/>
				<display:column class="w15" property="city" title="City" sortable="true"/>
				<display:column class="w5" property="elstate" title="State" sortable="true"/>
				<display:column class="w15" property="category" title="Category" sortable="true"/>
				<display:column class="w35,foo2" property="summary" title="Description"/>
				<display:column property="admin2" title="Actions" />
			</display:table>
		</td>
		</tr>
	</table>
<%}else{%>

	<table width="60%" cellpadding="6">
		<tr>
			<td valign=top width="20%">
				<div class="header"><b><font size="2">Recommended</font></b></div>
				<div class="headerline"></div>
				<br/><br/>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td valign=top width="60%">
				<div class="header"><b><font size="2">Business Listing</font></b></div>
				<div class="headerline"></div>
				<%
				Iterator iterator = list.iterator();
				while (iterator.hasNext()){
					DynaBean dbean = (DynaBean)iterator.next();
					String name = (String)dbean.get("name");
					String phone = (String)dbean.get("phone1");
					String category = (String)dbean.get("category");
					String forkids = (String)dbean.get("forkids");
					String summary = (String)dbean.get("summary");
					Object id = (Object)dbean.get("busid");
				%>

				<font size="2">
					<a href="/searchdetails.do?id=<%=id%>&choosenstate=<%=choosenstate%>" style="text-decoration:none" onMouseover="getDetails('<%=id%>','<%=choosenstate%>')"><b style="line-height: 18pt"><%=name%></b></a>
					<br/>
					<%=summary%>
					<br/><br/>
				</font>
				<%}%>
			</td>
		</tr>
	</table>
<%}%>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />
