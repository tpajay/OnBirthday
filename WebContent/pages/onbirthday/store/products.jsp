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
		//var qty = document.forms[0].qty.value;
		var varURL = "/addtocart.do?sku="+sku+"&price="+price+"&description="+description+"&qty=1";
	   	location.href = varURL;
	}
</script>

<table width="100%"><tr><td style="background-color:#def"><b>Product List</b></td></tr><tr><td>&nbsp;</td></tr></table>

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
			//String imagelinklarge = (String)dbean.get("imagelinklarge");
			String orderlink = (String)dbean.get("orderlink");
			String category = (String)dbean.get("category");
			String shortdetails = (String)dbean.get("shortdetails");
			String description = (String)dbean.get("description");
			String details = (String)dbean.get("details");
	%>
		<table width=100%>
			<tr>
				<td valign="center" align="left" width="15%">
					<%if(orderlink !=null && orderlink.length() > 0){%>
						<a href="<%=orderlink%>">
							<img src="<%=imagelink%>" border="0" alt="product" />
						</a>
					<%}else{%>
						<a href="/productdetail.do?sku=<%=sku%>">
							<img src="<%=imagelink%>" border="0" alt="product" />
						</a>
					<%}%>
				</td>
				<td align="left" width="65%">
					<a href="/productdetail.do?sku=<%=sku%>"><%=description%></a><br>
					<%if(listprice !=null && listprice.length() > 0){%>
						<b>List Price:</b>&nbsp;<strike>$<%=listprice%></strike><br/>
					<%}%>
					<b>Actual Price:</b>&nbsp;$<%=price%>
					<br/><br/>
					<%=shortdetails%>
				</td>
				<td valign="center" align="right" width="20%">
					<a href="javascript:AddToCart('<%=sku%>','<%=price%>','<%=description%>')">Add to Cart</a>
				</td>
			</tr>
		</table>
		<input type="hidden" name="qty" value="1" />
		<hr size=1 width=100% color=dcdcdc />
	<%}%>
	</form>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />