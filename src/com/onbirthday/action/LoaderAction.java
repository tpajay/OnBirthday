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


public class LoaderAction extends Action {
    public ActionForward execute(ActionMapping mapping,
                 ActionForm form,
                 HttpServletRequest request,
                 HttpServletResponse response)
    throws Exception {

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

	String remoteip = nullToEmpty((String)request.getRemoteAddr());
	String referrer = nullToEmpty((String)request.getHeader("Referer"));
	String host = nullToEmpty((String)request.getHeader("Host"));

	String sitename = "";
	if(host.indexOf("thecakemuse") > 0){
		sitename = "tcm_siteaccess";
	}else{
		sitename = "siteaccess";
	}

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

	String loaderStmt = "INSERT INTO " + sitename + " (ipaddress,host,referrer,createdttm) VALUES (?,?,?,now())";

		try{

			pstmt = conn.prepareStatement(loaderStmt);
			pstmt.setString(1, remoteip);
			pstmt.setString(2, host);
			pstmt.setString(3, referrer);

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

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }else{
        	//if(host.indexOf("gooddaytampabay") > 0){
        	//	return (mapping.findForward("gdtb_success"));
        	//}else{
        	//	return (mapping.findForward("success"));
        	//}

        	if(host.indexOf("thecakemuse") > 0){
        		return (mapping.findForward("tcm_success"));
        	}

			// some of the search sites have the link to onbirtday.com/sendtip.do, etc
			// so I want to send them to the homepage.
			if(referrer == null) referrer = "";
			if(referrer.length() > 0){
				return (mapping.findForward("redirecttohome"));
			}

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
