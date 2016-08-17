package com.onbirthday.action.store;

import javax.servlet.http.*;
import java.util.*;
import java.math.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.util.*;
import com.onbirthday.store.*;


public class SubmitOrderAction extends Action
{
    public ActionForward execute(ActionMapping mapping,
                 ActionForm form,
                 HttpServletRequest request,
                 HttpServletResponse response)
    throws Exception {

    MessageResources messages = MessageResources.getMessageResources("resources.ApplicationResources");

	HttpSession session = request.getSession();

   	// Get parameters and put them in a hash map
	Map values=new HashMap();
	for(Enumeration en=request.getParameterNames();en.hasMoreElements();) {
		String key=(String)en.nextElement();
		values.put(key,request.getParameter(key));
	}

	String errormsg1 = "";
   	String errormsg2 = "";
   	String errormsg3 = "";
    boolean isError = false;

    Cart cartobject = (Cart)session.getAttribute("cart");
	HashMap cart = null;
	CartItem item = null;
	if(cartobject != null){
		cart = (HashMap)cartobject.getCart();
	}

    Customer customer = (Customer)session.getAttribute("customer");

	Connection conn = null;
	DataSource ds = null;
	Statement stmt = null;
	ResultSet rs = null;

	String conn_type = messages.getMessage("dbconnection");

	if(conn_type.equalsIgnoreCase("local")){
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection("jdbc:mysql://localhost/birthday?user=localdbuser&password=localdbpwd");
	}else{
		Context ctx = new InitialContext();
		if(ctx == null ) throw new Exception("Boom - No Context");
		ds = (DataSource)ctx.lookup("java:comp/env/jdbc/JSNDB");
		conn = ds.getConnection();
	}

		try{

			String orderno = "";

			StringBuffer sql = new StringBuffer();

			Iterator it = cart.keySet().iterator();
			BigDecimal totalprice = new BigDecimal(0);
			while (it.hasNext()){
				String skunum = (String)it.next();
		        item = (CartItem)cart.get(skunum);
	            String sku = item.getSku();
				String description = item.getDescription();
				String price = item.getPrice();
				int qty = item.getQty();

				//get total per item
				BigDecimal qtytmp = new BigDecimal(qty);
				BigDecimal extpricetmp = new BigDecimal(price);
				BigDecimal extprice = extpricetmp.multiply(qtytmp);

				//get subtotal price for all items
				totalprice = totalprice.add(extprice);

				// insert new row
				sql.append("insert into orders (email,orderno,sku,description,qty,price,extprice,cardtype,cardno,cardname,cardid,cardexpdate,createdttm values ");
				sql.append("('" + nullToEmpty(customer.getEmail()));
				sql.append("','");
				sql.append(nullToEmpty(orderno));
				sql.append("','");
				sql.append(nullToEmpty(skunum));
				sql.append("','");
				sql.append(nullToEmpty(description));
				sql.append("','");
				sql.append(nullToEmpty(""+qty));
				sql.append("','");
				sql.append(nullToEmpty(price));
				sql.append("','");
				sql.append(nullToEmpty(extprice.toString()));
				sql.append("','");
				sql.append(nullToEmpty((String)values.get("cardtype")));
				sql.append("','");
				sql.append(nullToEmpty((String)values.get("cardno")));
				sql.append("','");
				sql.append(nullToEmpty((String)values.get("cardname")));
				sql.append("','");
				sql.append(nullToEmpty((String)values.get("cardid")));
				sql.append("','");
				sql.append(nullToEmpty((String)values.get("cardexpdate")));
				sql.append("',");
				sql.append("now()");
				sql.append(")");

				stmt = conn.createStatement();
				stmt.executeUpdate(sql.toString());

			}

        }catch(SQLException ex){
        	isError = true;
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            errormsg1 = ex.getMessage();
            errormsg2 = ex.getSQLState();
            errormsg3 = ""+ex.getErrorCode();
        } finally {
            try { rs.close(); } catch (Exception e) {}
            try { stmt.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
        }

		customer.setEmail(nullToEmpty((String)values.get("email")));
		customer.setFname(nullToEmpty((String)values.get("fname")));
		customer.setLname(nullToEmpty((String)values.get("lname")));
		customer.setCompany(nullToEmpty((String)values.get("company")));
		customer.setAddress1(nullToEmpty((String)values.get("address1")));
		customer.setAddress2(nullToEmpty((String)values.get("address2")));
		customer.setCity(nullToEmpty((String)values.get("city")));
		customer.setState(nullToEmpty((String)values.get("state")));
		customer.setZipcode(nullToEmpty((String)values.get("zipcode")));
		customer.setPhone(nullToEmpty((String)values.get("phone")));

		session.setAttribute("customer", customer);

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }else{
			return (mapping.findForward("billinginfo"));
		}

	}

	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

    /**
     * Replaces "&" with "&amp;" Replaces "'" with "&apos;" Replaces """ with "&quot;" Replaces "<" with "&lt;"
     * Replaces ">" with "&gt;"
     */
    public static String replaceString(String s, String replaceText, String replacement) {

        if (s == null || s.length() == 0) {
            return s;
        }
        StringBuffer newString = new StringBuffer();
        int idx = 0;
        while ((idx = s.indexOf(replaceText)) != -1) {
            newString.append(s.substring(0, idx)).append(replacement);
            if (s.length() > idx + replaceText.length()) {
                s = s.substring(idx + replaceText.length());
            } else {
                s = "";
                break;
            }
        }
        newString.append(s);
        return newString.toString();
    }

}

