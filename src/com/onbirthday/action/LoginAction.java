package com.onbirthday.action;

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


public class LoginAction extends Action
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
	boolean loggedin = false;

	String email = nullToEmpty((String)values.get("email"));
    String password = nullToEmpty((String)values.get("password"));
	String fname = "";
	String lname = "";
	String company = "";
	String address1 = "";
	String address2 = "";
	String city = "";
	String state = "";
	String zipcode = "";
	String phone = "";

	Customer customer = new Customer();

	Connection conn = null;
	DataSource ds = null;
	PreparedStatement pstmt = null;
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

	String selectCustomerStmt = "SELECT * FROM customers WHERE email = ? AND password = ?";

		try{

			pstmt = conn.prepareStatement(selectCustomerStmt);
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();

		    while (rs.next()){
				email = (String)rs.getString("email");
				password = (String)rs.getString("password");
				fname = (String)rs.getString("fname");
				lname = (String)rs.getString("lname");
				company = (String)rs.getString("company");
				address1 = (String)rs.getString("address1");
				address2 = (String)rs.getString("address2");
				city = (String)rs.getString("city");
				state = (String)rs.getString("state");
				zipcode = (String)rs.getString("zipcode");
				phone = (String)rs.getString("phone1");
			}

			if((email != null && email.length() > 0) && (password != null && password.length() > 0)){
				loggedin = true;
			}else{
				request.setAttribute("submitmsg","Username/Password not valid.");
			}

			if(loggedin){
				customer.setEmail(email);
        		customer.setPassword(password);
				customer.setFname(fname);
				customer.setLname(lname);
				customer.setCompany(company);
				customer.setAddress1(address1);
				customer.setAddress2(address2);
				customer.setCity(city);
				customer.setState(state);
				customer.setZipcode(zipcode);
				customer.setPhone(phone);
				session.setAttribute("customer", customer);
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
            try { pstmt.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
        }

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }

		if(loggedin){
			//return (mapping.findForward("billinginfo"));
			return (mapping.findForward("success"));
		}else{
			return (mapping.findForward("failure"));
		}
	}

	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

}
