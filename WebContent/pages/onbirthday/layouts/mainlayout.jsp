<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-nested" prefix="nested"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<html:html>

<head>

<TITLE><tiles:getAsString name="title" /></TITLE>

<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="content-language" content="en" />
<meta name="keywords" content="free birthday dinner lunch breakfast dessert meal meals deal deals search engine restaurant restaurants dining eating eat cheap business advertising advertise gifts gift golf carwash club discount discounted special specials" />
<meta name="description" content="Search for free and discounted deals offered on your birthday.  Deals are not limited to meals such as breakfast, lunch, dinner, and dessert.  Deals are not limited to free offers only.  Deals are special offers you can get on your birthday, ANYTHING." />

<LINK REL="SHORTCUT ICON" HREF="/favicon.ico">

<%
	boolean ishost = false;

	String referrer = (String)request.getHeader("Referer");
	if(referrer == null){
		referrer = "";
		ishost = true;
	}

	boolean host_is_bday = false;
	boolean host_is_goodday = false;

	host_is_bday = referrer.toLowerCase().indexOf("onbirthday") > 0;
	host_is_goodday = referrer.toLowerCase().indexOf("gooddaytampabay") > 0;

	if(host_is_bday){
		ishost = true;
	}else if(host_is_goodday){
		ishost = true;
	}

	//ishost = true;
%>

<style>
#search-text
{
    height: 15px;
    border: 1px solid #A6A8A8;
    font-family: Trebuchet MS, Arial;
    width: 115px;
}

#search-text-small
{
    height: 15px;
    border: 1px solid #A6A8A8;
    font-family: Trebuchet MS, Arial;
    width: 65px;
}

body
{
    padding: 0px;
    margin: 0px;
    color: black;
    background-color: White;
}


td
{
    font-family: Verdana, Arial, Helvetica;
    font-size: 11px;
}

form
{
    display: inline;
}

.body-font
{
    font-size: 12px;
    line-height: 18px;
}
</style>

</head>

<%if(ishost){%>

	<script language="JavaScript" type="text/javascript">
	</script>

	<body background="" bgcolor="#ffffff" text="#000000" link="#0000cc" vlink="#551a8b" alink="#ff0000" >

	<tiles:insert attribute="header" />
	<tiles:insert attribute="adheader" />
	<table width="100%">
		<tr>
			<td valign="top" width="10%" bgcolor="#FFFFFF"><tiles:insert attribute="navright" /></td>
			<td width="1" bgcolor="#c9d7f1"><img width=1 height=1 alt=""></td>
			<td style="padding:15px" valign="top" width="90%"><tiles:insert attribute="body" /></td>
		</tr>
	</table>
	<tiles:insert attribute="adfooter" />

<%}else{%>

	<SCRIPT LANGUAGE="JavaScript">
		location.replace("http://www.onbirthday.com/index.jsp");
	</SCRIPT>

	<body>

<%}%>

</body>
</html:html>
