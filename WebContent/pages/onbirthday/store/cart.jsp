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

	function submitMe(){
		document.shoppingcart.submit();
	}
</script>

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

	Cart cartobject = (Cart)session.getAttribute("cart");
	HashMap cart = null;
	CartItem item = null;
	if(cartobject != null){
		cart = (HashMap)cartobject.getCart();
	}

	boolean cartempty = false;
%>
<table width="100%"><tr><td bgcolor="#E5F3FF"><b>Your Shopping Cart</b></td></tr><tr><td>&nbsp;</td></tr></table>

<form name="shoppingcart" action="https://www.paypal.com/cgi-bin/webscr" method="post">

<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="jayathena@paypal.com">
<input type="hidden" name="image_url" value="http://www.onbirthday.com/resources/images/logo_lrg.gif">
<input type="hidden" name="page_style" value="onBirthday">

	<%if(cartobject != null){%>
		<table border=1 width=100%>
			<th>SKU</th>
			<th>Qty</th>
			<th>Description</th>
			<th>Unit Price</th>
			<th>Ext Price</th>
			<th>&nbsp;</th>
			<%
				Iterator it = cart.keySet().iterator();
				int lineitem = 0;
				int paypal_item_no = 1;
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
					<input type="text" size="1" name="qty" value="<%=qty%>" />
				</td>
				<td>
					<a href="/productdetail.do?sku=<%=sku%>"><%=description%></a>
				</td>
				<td>
					<%=price%>
				</td>
				<td>
					<%=extprice.toString()%>
					<input type="hidden" name="item_name_<%=paypal_item_no%>" value="<%=description%>">
					<input type="hidden" name="item_number_<%=paypal_item_no%>" value="<%=skunum%>">
					<input type="hidden" name="amount_<%=paypal_item_no%>" value="<%=price%>">
					<input type="hidden" name="quantity_<%=paypal_item_no%>" value="<%=qty%>">

					<!--
					<input type="hidden" name="xxxx_shipping_" value="">
					<input type="hidden" name="xxxx_handling_" value="">
					-->
				</td>
				<td>
					<a href="/deletefromcart.do?sku=<%=sku%>">Delete</a>
					<a href="javascript:UpdateCartItem('<%=sku%>','<%=lineitem%>')">Update</a>
				</td>
			</tr>

		    <%
		    lineitem++;
		    paypal_item_no++;
		    }
		    %>
		</table>
		<%if(lineitem < 1){
			cartempty=true;%>
		   	<table width=100%><tr><td><br/>Shopping Cart is Empty.</td></tr></table>
		<%}%>
		<%
			int shippinghandlingtmp = 0;
			int totalprice_int = totalprice.intValue();

			if(totalprice_int <= 50){ shippinghandlingtmp = 10; }
			if(totalprice_int > 50 && totalprice_int <= 100){ shippinghandlingtmp = 15; }
			if(totalprice_int > 100 && totalprice_int <= 150){ shippinghandlingtmp = 20; }
			if(totalprice_int > 150 && totalprice_int <= 200){ shippinghandlingtmp = 25; }
			if(totalprice_int > 200 && totalprice_int <= 250){ shippinghandlingtmp = 30; }
			if(totalprice_int > 250 && totalprice_int <= 300){ shippinghandlingtmp = 30; }
			if(totalprice_int > 300 && totalprice_int <= 350){ shippinghandlingtmp = 35; }
			if(totalprice_int > 350 && totalprice_int <= 400){ shippinghandlingtmp = 40; }
			if(totalprice_int > 400){ shippinghandlingtmp = 50; }

			BigDecimal shippinghandling = new BigDecimal(shippinghandlingtmp);
			BigDecimal actualtotalprice = totalprice.add(shippinghandling);
		%>
		<table width=100%>
			<tr><td align="right" width="85%">&nbsp;</td><td width="15%">&nbsp;<input type="hidden" name="handling_cart" value="<%=shippinghandling.toString()%>"></td></tr>
			<tr><td align="right" width="85%">SubTotal:&nbsp;</td><td width="15%">$<%=totalprice.toString()%></td></tr>
			<tr><td align="right" width="85%">Sales Tax:&nbsp;</td><td width="15%">$0</td></tr>
			<tr><td align="right" width="85%">Shipping/Handling:&nbsp;</td><td width="15%">$<%=shippinghandling.toString() + ".00"%></td></tr>
			<tr><td align="right" width="85%">Total:&nbsp;</td><td width="15%">$<%=actualtotalprice.toString()%></td></tr>
		</table>
	<%}else{
		cartempty=true;%>
		<br/>Shopping Cart is Empty.
	<%}%>
	<table width=100%>
		<tr><td>&nbsp;</td></tr>
		<tr><td><hr size=1 width=100% color=dcdcdc /></td></tr>
		<tr>
			<td align="center">
				<%if(!cartempty){%>
					<%if(customer == null){%>
						<!--<a href="/orderlogin.do">Make Purchase</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;-->
						<a href="javascript:submitMe()">Make Purchase</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;
					<%}else{%>
						<!--<a href="/billinginfo.do">Make Purchase</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;-->
						<a href="javascript:submitMe()">Make Purchase</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;
					<%}%>
					<a href="/products.do">Continue Shopping</a>&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;&nbsp;
					<a href="/deletefromcart.do?action=clearcart">Clear Shopping Cart</a>&nbsp;&nbsp;&nbsp;
				<%}else{%>
					<a href="/products.do">Continue Shopping</a>
				<%}%>
			</td>
		</tr>
	</table>
</form>

<jsp:include page="/pages/onbirthday/layouts/goback.jsp" flush="false" />