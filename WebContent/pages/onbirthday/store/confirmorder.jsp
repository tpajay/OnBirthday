<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.onbirthday.store.*" %>

<link rel="stylesheet" href="../../resources/css/display.css" type="text/css" media="screen, print" />

<script language="JavaScript" type="text/javascript">
	function UpdateCartItem(sku,lineitem){
		var qty;
		if(document.forms[0].qty.length == null){
			qty = document.forms[0].qty.value;
		}else{
			qty = document.forms[0].qty[lineitem].value;
		}
		var varURL = "/updatecart.do?sku="+sku+"&qty=" + qty;
	   	location.href = varURL;
	}
</script>

<%
	Customer customer = (Customer)session.getAttribute("customer");
	String email	= customer.getEmail() == null ? "" : customer.getEmail();
	String password	= customer.getPassword() == null ? "" : customer.getPassword();
	String fname	= customer.getFname() == null ? "" : customer.getFname();
	String lname	= customer.getLname() == null ? "" : customer.getLname();
	String company	= customer.getCompany() == null ? "" : customer.getCompany();
	String address1	= customer.getAddress1() == null ? "" : customer.getAddress1();
	String address2	= customer.getAddress2() == null ? "" : customer.getAddress2();
	String city		= customer.getCity() == null ? "" : customer.getCity();
	String state	= customer.getState() == null ? "" : customer.getState();
	String zipcode	= customer.getZipcode() == null ? "" : customer.getZipcode();
	String phone	= customer.getPhone() == null ? "" : customer.getPhone();

	Cart cartobject = (Cart)session.getAttribute("cart");
	HashMap cart = null;
	CartItem item = null;
	if(cartobject != null){
		cart = (HashMap)cartobject.getCart();
	}
%>
<table width="100%"><tr><td style="background-color:#def"><b>Confirm Order</b></td></tr><tr><td>&nbsp;</td></tr></table>
<form method="post">
<table width=100%>
		<tr>
			<td><b>Shipping and Billing Information:</b></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<%=fname%>&nbsp;<%=lname%><br/>
				<%=address1%><br/>
				<%if(address2 !=null && address2.length() > 0){%>
					<%=address2%><br/>
				<%}%>
				<%=city%>,&nbsp;<%=state%>&nbsp;<%=zipcode%><br/>
				<%=phone%>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<table width=100%>
		<tr><td><b>Order Details:</b></td></tr>
	</table>
	<%if(cartobject != null){%>
		<table border=1 width=100%>
			<th>SKU</th>
			<th>Qty</th>
			<th>Description</th>
			<th>Unit Price</th>
			<th>Ext Price</th>

			<%
				Iterator it = cart.keySet().iterator();
				int lineitem = 0;
				int totalqty = 0;
				BigDecimal totalprice = new BigDecimal(0);
			    while (it.hasNext()) {
			        String skunum = (String)it.next();
			        item = (CartItem)cart.get(skunum);
		            String sku = item.getSku();
					String description = item.getDescription();
					String price = item.getPrice();
					int qty = item.getQty();
					totalqty = totalqty + qty;

					//get total per item
					BigDecimal qtytmp = new BigDecimal(qty);
					BigDecimal extpricetmp = new BigDecimal(price);
					BigDecimal extprice = extpricetmp.multiply(qtytmp);

					//get subtotal price for all items
					totalprice = totalprice.add(extprice);
			%>
			<tr>
				<td>
					<%=sku%>
				</td>
				<td>
					<%=qty%>
				</td>
				<td>
					<a href="/productdetail.do?sku=<%=sku%>"><%=description%></a>
				</td>
				<td>
					<%=price%>
				</td>
				<td>
					<%=extprice.toString()%>
				</td>
			</tr>

		    <%
		    lineitem++;
		    }
		    %>
		</table>
		<%if(lineitem < 1){%>
		   	<table width=100%><tr><td>Shopping Cart is Empty.</td></tr></table>
		<%}%>
		<%
			BigDecimal totalqtytmp = new BigDecimal(totalqty);
		%>
		<table width=100%>
			<tr><td align="right" width="85%">&nbsp;</td><td width="15%">&nbsp;</td></tr>
			<tr><td align="right" width="85%">SubTotal:&nbsp;</td><td width="15%">$<%=totalprice.toString()%></td></tr>
			<tr><td align="right" width="85%">Sales Tax:&nbsp;</td><td width="15%">$0</td></tr>
			<tr><td align="right" width="85%">Shipping/Handling:&nbsp;</td><td width="15%">$</td></tr>
			<tr><td align="right" width="85%">Total:&nbsp;</td><td width="15%">$</td></tr>
		</table>
		<table width=100%>
		<tr><td>&nbsp;</td></tr>
		<tr><td><hr size=1 width=100% color=dcdcdc /></td></tr>
		<tr>
			<td align="center">
				<a href="/submitorder.do">Submit Order</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;
				<a href="/products.do">Continue Shopping</a>
			</td>
		</tr>
	</table>
	<%}%>
</form>
<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />