package com.onbirthday.action.admin;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.util.*;


public class AdminTasksAction extends Action
{
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

    String action	= (String)values.get("action");
	String frompage	= (String)values.get("frompage");
	String id		= (String)values.get("id");
	String sql 		= null;

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

	HttpSession session = request.getSession();

		try{

			// Pending Tips Admin Tasks //
			if(frompage.equalsIgnoreCase("pendingtips")){
				if(action.equalsIgnoreCase("delete")){
					sql = "delete from restaurants where busid = '" + id + "'";
				}
			}
			// Businesss Admin Tasks //
			if(frompage.equalsIgnoreCase("rest")){
				if(action.equalsIgnoreCase("delete")){
					sql = "delete from restaurants where busid = '" + id + "'";
				}
			}
			// All Businessses Admin Tasks //
			if(frompage.equalsIgnoreCase("allrest")){
				if(action.equalsIgnoreCase("delete")){
					sql = "delete from restaurants where busid = '" + id + "'";
				}
			}
			// Comment Admin Tasks //
			if(frompage.equalsIgnoreCase("comments")){
				if(action.equalsIgnoreCase("delete")){
					sql = "delete from comment where id = '" + id + "'";
				}
			}

			if(sql != null){
				stmt = conn.createStatement();
			    stmt.executeUpdate(sql);
			    conn.close();
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

		request.setAttribute("id",id);

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }else{

        	if(frompage.equalsIgnoreCase("pendingtips")){
        		if(action.equalsIgnoreCase("edit")){
        			return (mapping.findForward("editbusiness"));
				}else{
					return (mapping.findForward("pendingtips"));
				}
        	}

        	if(frompage.equalsIgnoreCase("rest")){
        		if(action.equalsIgnoreCase("edit")){
        			return (mapping.findForward("editbusiness"));
				}else{
					return (mapping.findForward("success"));
				}
        	}

        	if(frompage.equalsIgnoreCase("comments")){
        		return (mapping.findForward("elcomments"));
        	}else{
        		return (mapping.findForward("success"));
        	}
        }
	}

	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

}