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

//RSS Feeder stuff
import java.net.URL;
import java.io.InputStreamReader;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;



public class FeedLoadAction extends Action
{
    public ActionForward execute(ActionMapping mapping,
                 ActionForm form,
                 HttpServletRequest request,
                 HttpServletResponse response)
    throws Exception {

/*
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

	Connection conn;
	DataSource ds;
	Statement stmt;
	ResultSet rs;

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

			stmt = conn.createStatement();
		    rs = stmt.executeQuery("SELECT * FROM users");

		    String userid="";
		    String password="";

		    while (rs.next()) {
				userid = (String)rs.getString("userid");
				password = (String)rs.getString("password");
			}

			conn.close();

			request.setAttribute("userid", userid);
			request.setAttribute("password", password);

        }catch(SQLException ex){
        	isError = true;
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            errormsg1 = ex.getMessage();
            errormsg2 = ex.getSQLState();
            errormsg3 = ""+ex.getErrorCode();
        }finally{
			try{
				conn.close();
			}catch(Exception ex){}
		}

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }else{
        	return (mapping.findForward("success"));
        }
*/

		String feed = request.getParameter("feed");
		if(feed==null) feed="";

		//need code to validate http address

		if(feed.length() > 7){
			//URL dncfeedUrl = new URL("http://localhost/resources/css/top-15-coupons.xml");
			URL dncfeedUrl = new URL(feed);
			SyndFeedInput input = new SyndFeedInput();
			SyndFeed thefeed = input.build(new XmlReader(dncfeedUrl));
			request.setAttribute("thefeed", thefeed);
			request.setAttribute("feedurl", feed);
		}

		return (mapping.findForward("success"));

	}

}
