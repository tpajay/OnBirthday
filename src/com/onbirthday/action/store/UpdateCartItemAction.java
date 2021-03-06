package com.onbirthday.action.store;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.util.*;
import com.onbirthday.store.*;


public class UpdateCartItemAction extends Action
{
    public ActionForward execute(ActionMapping mapping,
                 ActionForm form,
                 HttpServletRequest request,
                 HttpServletResponse response)
    throws Exception {

	    HttpSession session = request.getSession(true);

	    MessageResources messages = MessageResources.getMessageResources("resources.ApplicationResources");

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

		String sku = nullToEmpty((String)values.get("sku"));
		int qty = Integer.parseInt((String)values.get("qty"));
		if(qty < 1) qty=1;

		CartItem item;
		HashMap elcart;

		try{

			// does the shopping cart exist in the session already?
			Cart cart = (Cart)session.getAttribute("cart");

			if(cart != null){
				elcart = (HashMap)cart.getCart();
				item = (CartItem)elcart.get(sku);

				//update item
			    item.setQty(qty);

				//add item to cart
				cart.addItem(sku,item);

				//put cart in session
				session.setAttribute("cart",cart);
			}

		}catch(Exception ex) {
        	isError = true;
            System.out.println("Exception: " + ex.getMessage());
            errormsg1 = ex.getMessage();
        }

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", "");
            request.setAttribute("errormsg3", "");
            return (mapping.findForward("failure"));
        }else{
        	return (mapping.findForward("shoppingcart"));
        }
	}


	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

}//end class.
