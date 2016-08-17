package com.onbirthday.images;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;
import java.sql.*;
import java.text.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.util.*;
import java.net.*;

import com.sun.jimi.core.*;
import com.sun.jimi.core.util.*;
import com.sun.jimi.core.JimiException;
import java.awt.*;
import java.lang.*;

import org.apache.struts.action.*;
import org.apache.struts.util.*;
import com.onbirthday.store.*;
import com.onbirthday.images.*;

//for ftp pfd link stuff
//import cz.dhl.io.*;
//import cz.dhl.ftp.*;

//import java.awt.*;
//import java.awt.event.*;

public class ImagesServlet extends HttpServlet {

/*
    public ImagesServlet()
    {
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        context = servletconfig.getServletContext();
        //separator = System.getProperty("file.separator");
        NEWLINE = System.getProperty("line.separator");
        //configs = new Hashtable();
        //forLock = new Object();
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {

		HttpSession session = httpservletrequest.getSession();

		String email = (String)session.getAttribute("email"); if(email==null) email="";
		String fname = (String)session.getAttribute("fname"); if(fname==null) fname="";
		String lname = (String)session.getAttribute("lname"); if(lname==null) lname="";
		String ipaddress = (String)session.getAttribute("ipaddress"); if(ipaddress==null) ipaddress="";
		String approved = (String)session.getAttribute("approved"); if(approved==null) approved="";

		//check if ADMIN
		Customer admin = (Customer)session.getAttribute("customer");
		if(admin==null) admin = new Customer();
		String cust_email = (String)admin.getEmail();
		if(cust_email==null) cust_email="";
		if(cust_email.length() > 0){
			approved = "Y";
			email = cust_email;
		}

		MessageResources messages = MessageResources.getMessageResources("resources.ApplicationResources");
		String conn_type = messages.getMessage("dbconnection");

		Connection conn = null;
		DataSource ds = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			if(conn_type.equalsIgnoreCase("local")){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection("jdbc:mysql://localhost/birthday?user=localdbuser&password=localdbpwd");
			}else{
				Context ctx = new InitialContext();
				if(ctx == null ) throw new Exception("Boom - No Context");
				ds = (DataSource)ctx.lookup("java:comp/env/jdbc/JSNDB");
				conn = ds.getConnection();
			}
		} catch (Exception e) {
			throw new ServletException(e);
    	}

		try{

			String load_sql = "select * from patsy_config";

			stmt = conn.createStatement();
			rs = stmt.executeQuery(load_sql);

			while(rs.next()){
				dir = nullToEmpty((String)rs.getString("dir"));
				outputdirectorypath = nullToEmpty((String)rs.getString("outputdirectorypath"));
				title = nullToEmpty((String)rs.getString("title"));
				header = nullToEmpty((String)rs.getString("header"));
				footer = nullToEmpty((String)rs.getString("footer"));
				bgcolor = nullToEmpty((String)rs.getString("bgcolor"));
				fgcolor = nullToEmpty((String)rs.getString("fgcolor"));
				fontface = nullToEmpty((String)rs.getString("fontface"));
				fontsize = nullToEmpty((String)rs.getString("fontsize"));
				columns = nullToEmpty((String)rs.getString("cols"));
				space = nullToEmpty((String)rs.getString("space"));
				width = nullToEmpty((String)rs.getString("width"));
				height = nullToEmpty((String)rs.getString("height"));
				border = nullToEmpty((String)rs.getString("border"));
				names = nullToEmpty((String)rs.getString("names"));
				target = nullToEmpty((String)rs.getString("target"));
			}

			rs = null;
			stmt = null;

			String filenames_sql = "select filenames from patsy_config where gallery='1'";
		    stmt = conn.createStatement();
			rs = stmt.executeQuery(filenames_sql);
			while(rs.next()){
				filenames = nullToEmpty((String)rs.getString("filenames"));
			}

			rs.close();
			stmt.close();
			rs = null;
			stmt = null;
            conn.close();

        }catch(SQLException ex){
        	isError = true;
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            errormsg1 = ex.getMessage();
            errormsg2 = ex.getSQLState();
            errormsg3 = ""+ex.getErrorCode();
        }

        PrintWriter printwriter = null;

		if((approved.equalsIgnoreCase("Y")) && (email.length() > 0)){

			String s = "";
			String s2 = "";
			String s4 = "";
			String fromimgsrc = "";
			String showtruetmp = "";
			boolean showlarge = false;

			s = HttpUtils.getRequestURL(httpservletrequest).toString();
			int i;
			if((i = s.indexOf("?")) > 0)
				s = s.substring(0, i);
			String s1;
			if((s1 = httpservletrequest.getQueryString()) == null)
				s1 = "";
			Hashtable hashtable = new Hashtable();
			hashtable = readConfig();
			s4 = (String)httpservletrequest.getParameter("show"); if(s4==null) s4="";
			fromimgsrc = (String)httpservletrequest.getParameter("fromimgsrc"); if(fromimgsrc==null) fromimgsrc="";
			showtruetmp = (String)httpservletrequest.getParameter("showtrue");
			if(showtruetmp==null){
				showlarge = false;
			}else{
				showlarge = true;
			}
			if(s4.length() == 0) {
				printwriter = httpservletresponse.getWriter();
				httpservletresponse.setContentType("text/html");
				printwriter.println("<html>");
				printwriter.println(showDirectory(hashtable, s2, s));
				printwriter.println("</html>");
				hashtable = null;
				printwriter = null;
			} else {
				s4 = URLDecoder.decode(s4);
				s4 = URLEncoder.encode(s4).replaceAll("\\+","%20");
				int j = s4.lastIndexOf(".");
				String s3 = s4.substring(j + 1);
				if(fromimgsrc.equalsIgnoreCase("1")){
					//httpservletresponse.setContentType("image/" + getTag(s3.toLowerCase()));
					httpservletresponse.setContentType("image/jpeg");
					javax.servlet.ServletOutputStream servletoutputstream = httpservletresponse.getOutputStream();
					dumpFile((String)hashtable.get("dir") + s4, servletoutputstream, s3, s4, showlarge);
					servletoutputstream.flush();
					servletoutputstream.close();
					servletoutputstream = null;
					hashtable = null;
				}else{
					dumpMainFile((String)hashtable.get("dir") + s4, s3, httpservletrequest, httpservletresponse, s4);
				}
			}

		}else{

			printwriter = httpservletresponse.getWriter();
			httpservletresponse.setContentType("text/html");
            printwriter.println("<html>");
			printwriter.println("<b>You do not have access to this site.  Your IP Address of <font color='red'>" + (String)httpservletrequest.getRemoteAddr() + "</font> has been recorded. </b>");
			printwriter.println("</html>");
			printwriter = null;
		}

		if(printwriter != null){
			printwriter.flush();
			printwriter.close();
			printwriter = null;
		}

    }//end doPost

    private String getTag(String s)
    {
        if(s.equalsIgnoreCase("jpg"))
            return "jpeg";
        else
            return s;
    }

    private Hashtable readConfig()
    {
        Hashtable hashtable = new Hashtable();

        hashtable.put("dir", dir);
        hashtable.put("output_dir_path", outputdirectorypath);
        hashtable.put("header", header);
        hashtable.put("footer", footer);
        hashtable.put("bgcolor", bgcolor);
        hashtable.put("fgcolor", fgcolor);
        hashtable.put("fontface", fontface);
        hashtable.put("fontsize", fontsize);
        hashtable.put("col", columns);
        hashtable.put("height", height);
        hashtable.put("width", width);
        hashtable.put("names", names);
        hashtable.put("title", title);
        hashtable.put("target", target);
        hashtable.put("border", border);
        hashtable.put("space", space);
        hashtable.put("order", "1");

        return hashtable;
    }


    /*
    private String getFromQuery(String s, String s1)
    {
        if(s == null)
            return "";
        int i = s.indexOf(s1);
        if(i < 0)
            return "";
        String s2 = s.substring(i + s1.length());
        if((i = s2.indexOf("&")) < 0)
            return s2;
        else
            return s2.substring(0, i);
    }
    */
/*
    private int getInt(String s)
    {
        try
        {
            return Integer.parseInt(s);
        }
        catch(Exception exception)
        {
            return -1;
        }
    }

    private void dumpFile(String s, OutputStream outputstream, String type, String filename, boolean showlarge)
    {
        String s1 = s;
        byte abyte0[] = new byte[4096];
        try
        {
			ByteArrayOutputStream bout = new ByteArrayOutputStream();
			URL url = new URL(s1);
			Image image = Jimi.getImage(url);

			try{

				if(!showlarge){
					Image resizedImage = image.getScaledInstance(300, 350, Image.SCALE_SMOOTH);
					Jimi.putImage("image/jpeg",resizedImage,bout);
				}else{
					Jimi.putImage("image/jpeg",image,bout);
				}

			}catch (JimiException jimiException){
				throw new IOException(jimiException.getMessage());
			}

			byte[] data = bout.toByteArray();
			outputstream.write(data);
			outputstream.close();
			image.flush();
			outputstream = null;
			bout = null;
			url = null;
			image = null;
			//System.runFinalization();
			//System.gc();
        }
        catch(Exception exception) { }
    }


	private void dumpMainFile(String s, String type, HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse, String filename)
    {
        try
        {
			filename = URLEncoder.encode(filename);
			httpservletrequest.setAttribute("filename",filename);
			RequestDispatcher rd = httpservletrequest.getRequestDispatcher("/pages/patsymagazine/4hs7xhsjr.jsp");
			rd.forward(httpservletrequest, httpservletresponse);
        }
        catch(Exception exception) { }
    }

    private String showDirectory(Hashtable hashtable, String s, String s1)
    {
        boolean flag = false;
        int l = 0;
        int i1 = Integer.parseInt((String)hashtable.get("col"));
        StringBuffer stringbuffer = new StringBuffer("");
        boolean flag1 = ((String)hashtable.get("names")).equals("1");
        String s2 = (String)hashtable.get("dir");
        String s3 = (String)hashtable.get("border");
        String s4 = (String)hashtable.get("width");
        String s5 = (String)hashtable.get("height");
        String s6 = (String)hashtable.get("title");
        String s7 = getFont(hashtable);
        String s8 = (String)hashtable.get("header");
        String s9 = (String)hashtable.get("footer");
        String s10 = (String)hashtable.get("order");
        String s11 = "";
        String s12 = "";
        String s13 = "";
        //if(getInitParameter("config") == null)
        //    s11 = "config=" + s + "&";
        if(s6.length() != 0)
        {
            stringbuffer.append("<head>\n");
            stringbuffer.append("<title>");
            stringbuffer.append(s6);
            stringbuffer.append("</title>\n");
            stringbuffer.append("</head>\n");
        }
        stringbuffer.append("<body bgcolor=\"" + (String)hashtable.get("bgcolor") + "\">\n");
        stringbuffer.append(s7);
        stringbuffer.append(NEWLINE);
        if(s8 != null)
            stringbuffer.append(readTextFile(s8));
        if(s6.length() != 0)
        {
            stringbuffer.append("\n<br><center><h1>");
            stringbuffer.append(s6);
            stringbuffer.append("</h1></center>");
        }
        stringbuffer.append("\n<br><table cellspacing=\"");
        stringbuffer.append((String)hashtable.get("space"));
        stringbuffer.append("\" width=\"100%\">\n");

		ArrayList arraylist = new ArrayList();
		String token = "";
		StringTokenizer st = new StringTokenizer(filenames,",");
		while (st.hasMoreTokens()) {
			token = st.nextToken();
			//System.out.println("ImageServlet StringTokenizer, filename: " + token);
			arraylist.add(new WebFileBean(token));
		}

        Object aobj[] = arraylist.toArray();
        for(int j = 0; j < aobj.length;)
        {
            WebFileBean filebean = (WebFileBean)aobj[j];
            s12 = s12 + "<td nowrap align=\"center\">" + s7 + "<a href=\"" + s1 + "?show" + "=" + URLEncoder.encode(filebean.getName()) + "\" target=\"" + (String)hashtable.get("target") + "\">" + "<img src=\"" + s1 + "?fromimgsrc=1&show" + "=" + URLEncoder.encode(filebean.getName()) + "\" width=\"" + s4 + "\" height=\"" + s5 + "\" border=\"" + s3 + "\">" + "</a></font></td>";
            if(flag1)
                s13 = s13 + "<td nowrap align=\"center\">" + s7 + shortName(filebean.getName()) + "</font></td>";
            if(++l == i1)
            {
                stringbuffer.append("<tr>");
                stringbuffer.append(s12);
                stringbuffer.append("</tr>\n");
                if(flag1)
                {
                    stringbuffer.append("<tr>");
                    stringbuffer.append(s13);
                    stringbuffer.append("</tr>\n");
                }
                l = 0;
                s12 = "";
                s13 = "";
            }
            if(++j >= 150)
                break;

            filebean = null;
        }

        aobj = null;

        for(int k = l; k < i1; k++)
        {
            s12 = s12 + "<td align=\"center\">" + s7 + "&nbsp;</font></td>";
            if(flag1)
                s13 = s13 + "<td align=\"center\">" + s7 + "&nbsp;</font></td>";
        }

        stringbuffer.append("<tr>");
        stringbuffer.append(s12);
        stringbuffer.append("</tr>\n");
        if(flag1)
        {
            stringbuffer.append("<tr>");
            stringbuffer.append(s13);
            stringbuffer.append("</tr>\n");
        }
        stringbuffer.append("</table>\n");
        stringbuffer.append("<p><br>" + NEWLINE);
        if(s9 != null)
            stringbuffer.append(readTextFile(s9));
        stringbuffer.append("\n</font></body>\n");
        return stringbuffer.toString();
    }

    private String getFont(Hashtable hashtable)
    {
        String s = (String)hashtable.get("size");
        String s1 = (String)hashtable.get("face");
        String s2 = "<font color=\"" + (String)hashtable.get("fgcolor") + "\"";
        if(s != null)
            s2 = s2 + " size=\"" + s + "\"";
        if(s1 != null)
            s2 = s2 + " face=\"" + s1 + "\"";
        s2 = s2 + ">";
        return s2;
    }

    private String shortName(String s)
    {
        int i = s.lastIndexOf(".");
        if(i <= 0)
            return s;
        else
            return s.substring(0, i);
    }

    private String decode(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(0);
        for(int i = 0; i < s.length(); i++)
        {
            char c = s.charAt(i);
            if(c == '+')
                stringbuffer.append(' ');
            else
            if(c == '%')
            {
                char c1 = '\0';
                for(int j = 0; j < 2; j++)
                {
                    c1 *= '\020';
                    c = s.charAt(++i);
                    if(c >= '0' && c <= '9')
                    {
                        c1 += c - 48;
                        continue;
                    }
                    if((c < 'A' || c > 'F') && (c < 'a' || c > 'f'))
                        break;
                    switch(c)
                    {
                    case 65: // 'A'
                    case 97: // 'a'
                        c1 += '\n';
                        break;

                    case 66: // 'B'
                    case 98: // 'b'
                        c1 += '\013';
                        break;

                    case 67: // 'C'
                    case 99: // 'c'
                        c1 += '\f';
                        break;

                    case 68: // 'D'
                    case 100: // 'd'
                        c1 += '\r';
                        break;

                    case 69: // 'E'
                    case 101: // 'e'
                        c1 += '\016';
                        break;

                    case 70: // 'F'
                    case 102: // 'f'
                        c1 += '\017';
                        break;
                    }
                }

                stringbuffer.append(c1);
            } else
            {
                stringbuffer.append(c);
            }
        }

        return stringbuffer.toString();
    }

    private String readTextFile(String s)
    {
        StringBuffer stringbuffer = new StringBuffer("");
        try
        {
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(new FileInputStream(lookupFile(s))));
            String s1;
            while((s1 = bufferedreader.readLine()) != null)
            {
                stringbuffer.append(s1);
                stringbuffer.append(NEWLINE);
            }
            bufferedreader.close();
        }
        catch(Exception exception) { }
        return stringbuffer.toString();
    }

    public String getServletInfo()
    {
        return "Image Viewer";
    }

    private File lookupFile(String s)
    {
        File file = new File(s);
        return file.isAbsolute() ? file : new File(context.getRealPath("/"), s);
    }

	//simply jumbles the filename so the user in the web browser
	//will not know what the actual filename is.
    private String encryptdecrypt(String s) {

        StringBuffer stringbuffer = new StringBuffer(0);

        for(int i = 0; i < s.length(); i++)
        {
            char c = s.charAt(i);

            switch(c){
				case 'a': stringbuffer.append('Z'); break;
				case 'A': stringbuffer.append('z'); break;
				case 'b': stringbuffer.append('Y'); break;
				case 'B': stringbuffer.append('y'); break;
				case 'c': stringbuffer.append('X'); break;
				case 'C': stringbuffer.append('x'); break;
				case 'd': stringbuffer.append('W'); break;
				case 'D': stringbuffer.append('w'); break;
				case 'e': stringbuffer.append('V'); break;
				case 'E': stringbuffer.append('v'); break;
				case 'f': stringbuffer.append('U'); break;
				case 'F': stringbuffer.append('u'); break;
				case 'g': stringbuffer.append('T'); break;
				case 'G': stringbuffer.append('t'); break;
				case 'h': stringbuffer.append('S'); break;
				case 'H': stringbuffer.append('s'); break;
				case 'i': stringbuffer.append('R'); break;
				case 'I': stringbuffer.append('r'); break;
				case 'j': stringbuffer.append('Q'); break;
				case 'J': stringbuffer.append('q'); break;
				case 'k': stringbuffer.append('P'); break;
				case 'K': stringbuffer.append('p'); break;
				case 'l': stringbuffer.append('O'); break;
				case 'L': stringbuffer.append('o'); break;
				case 'm': stringbuffer.append('N'); break;
				case 'M': stringbuffer.append('n'); break;
				case 'n': stringbuffer.append('M'); break;
				case 'N': stringbuffer.append('m'); break;
				case 'o': stringbuffer.append('L'); break;
				case 'O': stringbuffer.append('l'); break;
				case 'p': stringbuffer.append('K'); break;
				case 'P': stringbuffer.append('k'); break;
				case 'q': stringbuffer.append('J'); break;
				case 'Q': stringbuffer.append('j'); break;
				case 'r': stringbuffer.append('I'); break;
				case 'R': stringbuffer.append('i'); break;
				case 's': stringbuffer.append('H'); break;
				case 'S': stringbuffer.append('h'); break;
				case 't': stringbuffer.append('G'); break;
				case 'T': stringbuffer.append('g'); break;
				case 'u': stringbuffer.append('F'); break;
				case 'U': stringbuffer.append('f'); break;
				case 'v': stringbuffer.append('E'); break;
				case 'V': stringbuffer.append('e'); break;
				case 'w': stringbuffer.append('D'); break;
				case 'W': stringbuffer.append('d'); break;
				case 'x': stringbuffer.append('C'); break;
				case 'X': stringbuffer.append('c'); break;
				case 'y': stringbuffer.append('B'); break;
				case 'Y': stringbuffer.append('b'); break;
				case 'z': stringbuffer.append('A'); break;
				case 'Z': stringbuffer.append('a'); break;
				case '0': stringbuffer.append('9'); break;
				case '1': stringbuffer.append('8'); break;
				case '2': stringbuffer.append('7'); break;
				case '3': stringbuffer.append('6'); break;
				case '4': stringbuffer.append('5'); break;
				case '5': stringbuffer.append('4'); break;
				case '6': stringbuffer.append('3'); break;
				case '7': stringbuffer.append('2'); break;
				case '8': stringbuffer.append('1'); break;
				case '9': stringbuffer.append('0'); break;
				default:  stringbuffer.append(c); break;
        	}
		}
        return stringbuffer.toString();
    }

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
*/

	/* Utility methods */
/*
	public static String nullToEmpty(String val){
        if(val == null) return "";
        if(val.equalsIgnoreCase("null")) return "";
        return val;
    }

	String dir = "";
	String outputdirectorypath = "";
	String title = "";
	String header = "";
	String footer = "";
	String bgcolor = "";
	String fgcolor = "";
	String fontface = "";
	String fontsize = "";
	String columns = "";
	String space = "";
	String width = "";
	String height = "";
	String border = "";
	String names = "";
	String target = "";
	String errormsg1 = "";
	String errormsg2 = "";
	String errormsg3 = "";
	boolean isError = false;
    static String NEWLINE = "\n";
    private ServletContext context;
    String filenames = "";

*/

}//the end.
