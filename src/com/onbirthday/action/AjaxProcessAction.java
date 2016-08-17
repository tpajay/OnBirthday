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
import org.apache.commons.beanutils.RowSetDynaClass;

public class AjaxProcessAction extends Action {

  public ActionForward execute(ActionMapping mapping, ActionForm inForm,
  	HttpServletRequest request, HttpServletResponse response) throws Exception {

/*
	String action = "";

	action = (String)request.getParameter("action"); if(action==null) action="";

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

		String qry = "SELECT * FROM restaurants where busid='" + nullToEmpty((String)values.get("id")) + "'";

		stmt = conn.createStatement();
		rs = stmt.executeQuery(qry);

		while (rs.next()) {
			name = (String)rs.getString("name");
		}

		conn.close();

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
*/

	//forward to success page
	return (mapping.findForward("content1"));

  } // End execute()


} // End class
