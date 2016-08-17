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
import org.apache.commons.beanutils.RowSetDynaClass;


public class TipsPendingDetailAction extends Action
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

	String id = "";
	String name = "";
	String address1 = "";
	String address2 = "";
	String city = "";
	String state = "";
	String zipcode = "";
	String phone1 = "";
	String phone2 = "";
	String http = "";
	String details = "";
	String freemeal = "";
	String forkids = "";
	String category = "";
	String nationwide = "";
	String nonstate = "";
	String expiresdttm = "";
	String states = "";
	String approved = "";
	String paid = "";
	ArrayList stateslist = new ArrayList();

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

			id = nullToEmpty((String)values.get("id"));
			if(id == null || id.length() < 1){
				id = (String)request.getAttribute("id");
			}
			if(id == null) id="";

			if(id !=null && id.length() > 0){
				id = padZeros(id, 5);
			}

			String qry = "SELECT * FROM restaurants where busid = '" + id + "'";

			stmt = conn.createStatement();
		    rs = stmt.executeQuery(qry);

		    while (rs.next()) {
				id = (String)rs.getString("busid");
				name = (String)rs.getString("name");
				address1 = (String)rs.getString("address1");
				address2 = (String)rs.getString("address2");
				city = (String)rs.getString("city");
				state = (String)rs.getString("state");
				zipcode = (String)rs.getString("zipcode");
				phone1 = (String)rs.getString("phone1");
				phone2 = (String)rs.getString("phone2");
				http = (String)rs.getString("http");
				details = (String)rs.getString("details");
				freemeal = (String)rs.getString("freemeal");
				forkids = (String)rs.getString("forkids");
				approved = (String)rs.getString("approved");
				paid = (String)rs.getString("paid");
				category = (String)rs.getString("category");
				nationwide = (String)rs.getString("nationwide");
				nonstate = (String)rs.getString("nonstate");
				expiresdttm = (String)rs.getString("expiresdttm");
				states = (String)rs.getString("states");
			}

			String elstate = "";
			StringTokenizer tkn = new StringTokenizer(states,",");
			while (tkn.hasMoreTokens()){
				String token = (String)tkn.nextToken();
				elstate = token;
				stateslist.add(token);
			}

			request.setAttribute("id",id);
			request.setAttribute("name",name);
			request.setAttribute("address1",address1);
			request.setAttribute("address2",address2);
			request.setAttribute("city",city);
			request.setAttribute("state",state);
			request.setAttribute("zipcode",zipcode);
			request.setAttribute("phone1",phone1);
			request.setAttribute("phone2",phone2);
			request.setAttribute("http",http);
			request.setAttribute("details",details);
			request.setAttribute("freemeal",freemeal);
			request.setAttribute("forkids",forkids);
			request.setAttribute("approved",approved);
			request.setAttribute("paid",paid);
			request.setAttribute("category",category);
			request.setAttribute("nationwide",nationwide);
			request.setAttribute("nonstate",nonstate);
			request.setAttribute("expiresdttm",expiresdttm);
			request.setAttribute("stateslist", stateslist);

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

        if(isError){
        	request.setAttribute("errormsg1", errormsg1);
            request.setAttribute("errormsg2", errormsg2);
            request.setAttribute("errormsg3", errormsg3);
            return (mapping.findForward("failure"));
        }else{
        	//request.setAttribute("action", "");
			return (mapping.findForward("success"));
		}

	}

	/* Utility methods */
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

    public static String padZeros(String s, int size){
        if (s == null) {
            s = "";
        }
        int numZeros = size - s.length();
        if (numZeros <= 0) {
            return s;
        } else {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < numZeros; i++) {
                sb.append("0");
            }
            sb.append(s);
            return sb.toString();
        }
    }

}
