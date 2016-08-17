<%
  com.sun.syndication.feed.synd.SyndFeed feed = (com.sun.syndication.feed.synd.SyndFeed)request.getAttribute("thefeed");
  String feedurl = (String)request.getAttribute("feedurl");
  if(feedurl==null) feedurl="http://";
  int x = 1;
%>

<table width="100%" cellpadding="8">
	<tr valign=top><td valign="top">
			<form method="post" action="/loadfeeds.do">
				<b>Enter URL of the Feed:</b><br/>
				<input type="text" name="feed" value="<%=feedurl%>" size="75"/>
				<br/><br/>
				<input type="submit" name="submit" value="Submit" />
			</form>

			<br/><br/>
			<hr>
			<br/>

			<%if(feed != null){%>
			<b>Here is the feed you requested:</b>
			<br/><br/>
			<%
				java.util.List entries = (java.util.List)feed.getEntries();
				java.util.Iterator iterator = entries.iterator();
				int size = entries.size();
				x = 1;
				while (iterator.hasNext()) {
					com.sun.syndication.feed.synd.SyndEntryImpl entry =
						(com.sun.syndication.feed.synd.SyndEntryImpl) iterator.next();
					String etitle = entry.getTitle();
					String elink = entry.getLink();
			%>
				<a href="<%=elink%>" target="new"><%=x%>. <%=etitle%></a><br/>
				<%
					x++;
				}%>
			<%}%>
		</td>
	</tr>
</table>
