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


public class CommentCreateAction extends Action {
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

	int spamIndex = -1;
	String comment = nullToEmpty((String)values.get("comment"));
	String busname = nullToEmpty((String)values.get("busname"));
	String username = nullToEmpty((String)values.get("username"));
	String busid = nullToEmpty((String)values.get("busid"));
	String email = nullToEmpty((String)values.get("email"));

	String choosenstate = nullToEmpty((String)values.get("choosenstate"));
	request.setAttribute("choosenstate",choosenstate);

	spamIndex = comment.indexOf("http://");

	String insertCommentStmt = "INSERT INTO comment (email,name,comment,busid,busname,approved,createdttm) VALUES (?,?,?,?,?,?,now())";

		try{

			if(spamIndex < 0){
				pstmt = conn.prepareStatement(insertCommentStmt);
				pstmt.setString(1, email);
				pstmt.setString(2, username);
				pstmt.setString(3, comment);
				pstmt.setString(4, busid);
				pstmt.setString(5, busname);
				pstmt.setString(6, "N");

				int count = pstmt.executeUpdate();
			}


			request.setAttribute("busid", busid);

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
        	//request.setAttribute("action", "");
        	if(busname.length() > 0 ){
        		request.setAttribute("submitmsg", "Thank you for submitting a comment concerning " + busname +"!");
			}else{
				request.setAttribute("submitmsg", "Thank you for submitting a comment!");
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
