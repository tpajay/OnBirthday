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


public class RegistrationAction extends Action
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

    Customer customer = new Customer();
	String email = nullToEmpty((String)values.get("email"));
	String password = nullToEmpty((String)values.get("password"));
	String fname = nullToEmpty((String)values.get("fname"));
	String lname = nullToEmpty((String)values.get("lname"));
	String company = nullToEmpty((String)values.get("company"));
	String address1 = nullToEmpty((String)values.get("address1"));
	String address2 = nullToEmpty((String)values.get("address2"));
	String city = nullToEmpty((String)values.get("city"));
	String state = nullToEmpty((String)values.get("state"));
	String zipcode = nullToEmpty((String)values.get("zipcode"));
	String phone = nullToEmpty((String)values.get("phone"));
	String spam = nullToEmpty((String)values.get("spam"));


	String selectCustomerStmt = "SELECT * FROM customers WHERE email = ?";
	String insertNewCustomerStmt =
		"INSERT INTO customers (email,password,fname,lname,company,address1,address2,city," +
		"state,zipcode,phone1,spam,createdttm) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,now())";

		try{

			pstmt = conn.prepareStatement(selectCustomerStmt);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if(rs.next()){
				customer.setEmail(email);
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
				request.setAttribute("submitmsg","Email Address already exists.  Please try another.");
				return (mapping.findForward("failure"));
			}

			pstmt = conn.prepareStatement(insertNewCustomerStmt);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			pstmt.setString(3, fname);
			pstmt.setString(4, lname);
			pstmt.setString(5, company);
			pstmt.setString(6, address1);
			pstmt.setString(7, address2);
			pstmt.setString(8, city);
			pstmt.setString(9, state);
			pstmt.setString(10, zipcode);
			pstmt.setString(11, phone);
			pstmt.setString(12, spam);

			int count = pstmt.executeUpdate();

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

        customer.setEmail(email);
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
}
