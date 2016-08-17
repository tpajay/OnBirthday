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


public class TipCreateAction extends Action
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

	String sendername = nullToEmpty((String)values.get("sendername"));
	String senderemail = nullToEmpty((String)values.get("senderemail"));
	String busname = nullToEmpty((String)values.get("busname"));
	String http = nullToEmpty((String)values.get("http"));
	String phone = nullToEmpty((String)values.get("phone"));
	String city = nullToEmpty((String)values.get("city"));
	String state = nullToEmpty((String)values.get("state"));
	String zipcode = nullToEmpty((String)values.get("zipcode"));
	String details = nullToEmpty((String)values.get("details"));
	String freemeal = nullToEmpty((String)values.get("freemeal"));
	String forkids = nullToEmpty((String)values.get("forkids"));
	String nationwide = nullToEmpty((String)values.get("nationwide"));
	String category = nullToEmpty((String)values.get("category"));
	String nonstate = nullToEmpty((String)values.get("nonstate"));

	String insertTipStmt =
		"INSERT INTO restaurants (sendername,senderemail,name,http,phone1,city,state,zipcode," +
		"details,freemeal,forkids,nationwide,states,category,approved,expiresdttm,createdttm,nonstate) " +
		"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)";

		try{

			//Expire Date
			SimpleDateFormat expdttm_formatter = new SimpleDateFormat("yyyy/dd/MM");
			java.util.Date expdttmTime = null;
			Calendar c = null;

			String expdttm_tmp = (String)values.get("expiresdttm");
			if(expdttm_tmp !=null && expdttm_tmp.length() > 0){
				String expdttm_month= expdttm_tmp.substring(0,2);
				String expdttm_day= expdttm_tmp.substring(3,5);
				String expdttm_year= expdttm_tmp.substring(6,10);
				expdttmTime = new java.util.Date(Integer.parseInt(expdttm_year)-1900, Integer.parseInt(expdttm_month)-1,
					Integer.parseInt(expdttm_day), 0, 0, 0);
				c = Calendar.getInstance();
				c.setTime(expdttmTime);
				expdttm_tmp = expdttm_formatter.format(c.getTime());
			}
			String expdttm_tmp2 = nullToEmpty((String)values.get("expdttm_tmp"));

			pstmt = conn.prepareStatement(insertTipStmt);
			pstmt.setString(1, sendername);
			pstmt.setString(2, senderemail);
			pstmt.setString(3, busname);
			pstmt.setString(4, http);
			pstmt.setString(5, phone);
			pstmt.setString(6, city);
			pstmt.setString(7, state);
			pstmt.setString(8, zipcode);
			pstmt.setString(9, details);
			pstmt.setString(10, freemeal);
			pstmt.setString(11, forkids);
			pstmt.setString(12, nationwide);
			pstmt.setString(13, state);
			pstmt.setString(14, category);
			pstmt.setString(15, "N");
			pstmt.setString(16, expdttm_tmp2);
			pstmt.setString(17, nonstate);

			int count = pstmt.executeUpdate();

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
        	request.setAttribute("submitmsg", "Thank you!  Your deal will be added within 24 hours.");
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
