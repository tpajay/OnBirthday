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


public class BusinessCreateAction extends Action
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

	String states[]=request.getParameterValues("states");
	String stateslist = "";

	if(states != null){

		if(states.length == 1){
				stateslist = states[0];
		}
		else if(states.length > 1){
			for(int i=0;i < states.length;i++){
				stateslist = stateslist + "," + states[i];
			}
		}
	}

	String errormsg1 = "";
   	String errormsg2 = "";
   	String errormsg3 = "";
    boolean isError = false;

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

			String name = nullToEmpty((String)values.get("name"));
			String details = nullToEmpty((String)values.get("details"));
			name = replaceString(name, "\'", "&#39;");
			name = replaceString(name, "\"", "&quot;");
			details = replaceString(details, "\'", "&#39;");
			details = replaceString(details, "\"", "&quot;");

			// insert new row to initialized blob column
			StringBuffer sql = new StringBuffer();
			sql.append("insert into restaurants (name,address1,address2,city,state,zipcode,phone1,phone2,http,details,freemeal,forkids,nationwide,category,approved,states,expiresdttm,createdttm) values ");
			sql.append("('" + name);
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("address1")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("address2")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("city")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("state")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("zipcode")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("phone1")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("phone2")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("http")));
			sql.append("','");
			sql.append(details);
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("freemeal")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("forkids")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("nationwide")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("category")));
			sql.append("','");
			sql.append("Y");
			sql.append("','");
			sql.append(stateslist);
			sql.append("','");
			sql.append(nullToEmpty(expdttm_tmp));
			sql.append("',");
			sql.append("now()");
			sql.append(")");

			stmt = conn.createStatement();
			stmt.executeUpdate(sql.toString());

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

    /**
     * Replaces "&" with "&amp;" Replaces "'" with "&apos;" Replaces """ with "&quot;" Replaces "<" with "&lt;"
     * Replaces ">" with "&gt;"
     */
    public static String replaceString(String s, String replaceText, String replacement) {

        if (s == null || s.length() == 0) {
            return s;
        }
        StringBuffer newString = new StringBuffer();
        int idx = 0;
        while ((idx = s.indexOf(replaceText)) != -1) {
            newString.append(s.substring(0, idx)).append(replacement);
            if (s.length() > idx + replaceText.length()) {
                s = s.substring(idx + replaceText.length());
            } else {
                s = "";
                break;
            }
        }
        newString.append(s);
        return newString.toString();
    }
}

