<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<%
	RowSetDynaClass rc = (RowSetDynaClass)request.getAttribute("results");
	List productlist = (List)rc.getRows();
%>

<%
	String userid = (String)session.getAttribute("userid");
	if(userid==null)userid="";
	String password = (String)session.getAttribute("password");
	if(password==null)password="";
%>

<script language="JavaScript" type="text/javascript">
	function AddToCart(sku,price,description){
		var qty = document.forms[0].qty.value;
		var varURL = "/addtocart.do?sku="+sku+"&price="+price+"&description="+description+"&qty=" + qty;
	   	location.href = varURL;
	}
</script>

<table width="100%"><tr><td style="background-color:#def"><b>Product Details</b></td></tr><tr><td>&nbsp;</td></tr></table>

<form>
	<%
		Iterator productiterator = productlist.iterator();
		while (productiterator.hasNext()){
			DynaBean dbean = (DynaBean)productiterator.next();
			String sku = (String)dbean.get("sku");
			String listprice = (String)dbean.get("listprice");
			String price = (String)dbean.get("price");
			String stock = (String)dbean.get("stock");
			String imagelink = (String)dbean.get("imagelink");
			String imagelinklarge = (String)dbean.get("imagelinklarge");
			String category = (String)dbean.get("category");
			String shortdetails = (String)dbean.get("shortdetails");
			String description = (String)dbean.get("description");
			String details = (String)dbean.get("details");
	%>
		<table width=100% cellpadding="10px">
			<tr>
				<td valign="top" align="left" width="15%">
					<img src="<%=imagelinklarge%>" border="0" alt="product" />
				</td>
				<td align="left" valign="top" width="65%">
					<%if(listprice !=null && listprice.length() > 0){%>
						<b>List Price:</b>&nbsp;<strike>$<%=listprice%></strike><br/>
					<%}%>
					<b>Actual Price:</b>&nbsp;$<%=price%>
					<br/><br/>
					<%=details%>
					<br/></br>
					<b>Quantity:</b>&nbsp;<input type="text" name="qty" size="1" value="1" />
					<br/><br/>
					<a href="javascript:AddToCart('<%=sku%>','<%=price%>','<%=description%>')">Add to Cart</a>
				</td>
			</tr>
		</table>
		<hr size=1 width=100% color=dcdcdc />
	<%}%>
</form>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />