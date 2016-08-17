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


public class SearchAction extends Action
{
    public ActionForward execute(ActionMapping mapping,
                 ActionForm form,
                 HttpServletRequest request,
                 HttpServletResponse response)
    throws Exception {

    MessageResources messages =
    	MessageResources.getMessageResources("resources.ApplicationResources");

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

	HttpSession session = request.getSession();
	String state = nullToEmpty((String)values.get("state"));
	request.setAttribute("choosenstate",state);

	String selectSearchStmt =
		"SELECT *,CONCAT(TRIM(SUBSTRING(details,1,100)), \"...\") AS summary, " +
		"(case state when '' then '?' else state end) as elstate FROM restaurants where " +
		"approved='Y' and states like '%?%' and paid='Y' ORDER BY name";

		try{

			RowSetDynaClass resultSet = null;
			rs = null;
			resultSet = null;

			pstmt = conn.prepareStatement(selectSearchStmt);
			pstmt.setString(1, state);
			pstmt.setString(2, state);

			rs = pstmt.executeQuery();
			resultSet = new RowSetDynaClass(rs,false);

			if(resultSet != null){
				List rows = resultSet.getRows();
			}

			conn.close();

			request.setAttribute("results", resultSet);

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
        }else{
			return (mapping.findForward("success"));
		}

	}

	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

}
