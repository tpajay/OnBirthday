package com.onbirthday.action.store;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.util.*;


public class ProductCreateAction extends Action
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

			/*
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			String createdttm = sdf.format(cal.getTime());

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
			*/

			String description = nullToEmpty((String)values.get("description"));
			String details = nullToEmpty((String)values.get("details"));
			description = replaceString(description, "\'", "&#39;");
			description = replaceString(description, "\"", "&quot;");
			details = replaceString(details, "\'", "&#39;");
			details = replaceString(details, "\"", "&quot;");

			// insert new row to initialized blob column
			StringBuffer sql = new StringBuffer();
			sql.append("insert into products (sku,description,details,listprice,price,stock,imagelink,imagelinklarge,orderlink,category) values ");
			sql.append("('" + nullToEmpty((String)values.get("sku")));
			sql.append("','");
			sql.append(description);
			sql.append("','");
			sql.append(details);
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("listprice")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("price")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("stock")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("imagelink")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("imagelinklarge")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("orderlink")));
			sql.append("','");
			sql.append(nullToEmpty((String)values.get("category")) + "')");

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
        	request.setAttribute("submitmsg", "Thank you for submitting a Product!");
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

