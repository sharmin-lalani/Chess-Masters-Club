/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.37
 * Generated at: 2013-04-16 16:20:07 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import databasepools.*;
import java.sql.*;

public final class game_005fplay_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "check_session.jsp", out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\r\n");
      out.write("<title>Chess Masters Club</title>\r\n");
      out.write("<link href=\"stylesheets/common.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("\r\n");
      out.write("window.onload=function()\r\n");
      out.write("{\r\n");
      out.write("\ttable=document.getElementById(\"user\");\r\n");
      out.write("    uname=document.getElementById(\"uname\"); \r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function getXmlHttpRequestObject() {\r\n");
      out.write("\tif (window.XMLHttpRequest) {\r\n");
      out.write("\t\treturn new XMLHttpRequest();\r\n");
      out.write("\t} else if(window.ActiveXObject) {\r\n");
      out.write("\t\treturn new ActiveXObject(\"Microsoft.XMLHTTP\");\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\talert(\"Your Browser does not support ajax!\");\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("//Our XmlHttpRequest object to get the auto suggest\r\n");
      out.write("var searchReq = getXmlHttpRequestObject();\r\n");
      out.write("\r\n");
      out.write("//Called from keyup on the search textbox.\r\n");
      out.write("//Starts the AJAX request.\r\n");
      out.write("function getlist() \r\n");
      out.write("{\r\n");
      out.write("\tif(uname.value.length<1)\r\n");
      out.write("\t{\r\n");
      out.write("\t\t//alert(uname.value.length);\r\n");
      out.write("\t\ttable.innerHTML=\"\";\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tif (searchReq.readyState == 4 || searchReq.readyState == 0) \r\n");
      out.write("\t{\r\n");
      out.write("\t\tsearchReq.open(\"GET\",\"Game_userlist?value=\"+uname.value,true);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tsearchReq.onreadystatechange = addlist; \r\n");
      out.write("\t\tsearchReq.send(null);\r\n");
      out.write("\t}\t\t\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function addlist()\r\n");
      out.write("{\r\n");
      out.write("\tif (searchReq.readyState == 4 && searchReq.status==200)\r\n");
      out.write("{\r\n");
      out.write("\tvar str =searchReq.responseText.split(\"\\n\");\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\ttable.innerHTML=\"\";\r\n");
      out.write("\tfor(i=0; i < str.length-1; i++) {\r\n");
      out.write("\t\t//Build our element string. \r\n");
      out.write("\t\t/*var suggest = \"<tr><td>\" + \"<a href=profile.jsp?username=\"+str[i]+\">\"+str[i] + \"</a></td><td><a href=\\\"start_game.jsp?username=\"+str[i]+\"\\\">&nbsp;&nbsp;&nbsp;Start a Game</a></td></tr>\";\r\n");
      out.write("\t\ttable.innerHTML += suggest;*/\r\n");
      out.write("\t\tvar suggest = \"<tr><td>\" + \"<a href=profile.jsp?username=\"+str[i]+\">\"+str[i] + \"</a>&nbsp;&nbsp;&nbsp;</td>\"+\r\n");
      out.write("\t\t\"<td><form method=\\\"get\\\" action=\\\"SendGameRequest\\\" >\"+\r\n");
      out.write("\t\t\"<input type=\\\"hidden\\\" name=\\\"username\\\" value=\"+str[i]+\" />\"+\r\n");
      out.write("\t\t\"<input type=\\\"submit\\\" value=\\\"Start Game\\\" /></form></td></tr>\";\r\n");
      out.write("\t\ttable.innerHTML += suggest;\r\n");
      out.write("\t}\r\n");
      out.write("\tif(str.length==1)\r\n");
      out.write("\ttable.innerHTML = \"<tr><td>There are no results to display.</td></tr>\";\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("\t<!-- Start Header -->\r\n");
      out.write("\t<div id=\"header\">\r\n");
      out.write("    \r\n");
      out.write("\t\t<div class=\"container\">\r\n");
      out.write("            \r\n");
      out.write("\t\r\n");
      out.write("    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "session.jsp", out, false);
      out.write("\r\n");
      out.write("\t\t\t<!-- top navigation -->\r\n");
      out.write("\t\t\t<ul id=\"navigation\">\r\n");
      out.write("\t\t\t\t<li><a href=\"index.jsp\">Home</a></li>\r\n");
      out.write("\t\t\t\t<li class=\"active\"><a href=\"game_play.jsp\" >Game Play</a></li>\r\n");
      out.write("\t\t\t\t<li><a href=\"tutorial.jsp\" >Tutorials</a></li>\r\n");
      out.write("\t\t\t\t<li><a href=\"tournaments.jsp\" >Tournaments</a></li>\r\n");
      out.write("\t\t\t\t<li><a href=\"faq.jsp\" >FAQs</a></li>   \r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("\t\t\t<!-- banner message and building background -->\r\n");
      out.write("\t\t\t<div id=\"banner\">\r\n");
      out.write("\t\t\t\t<p>\r\n");
      out.write("                An Online Chess Club where game lovers can learn and play Chess games with their friends or other players. \r\n");
      out.write("                </p>  \r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<hr />     \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<!-- Start Main Content -->\r\n");
      out.write("\t<div id=\"main\" class=\"container\">\r\n");
      out.write("\r\n");
      out.write("\t\t<!-- main content area -->\r\n");
      out.write("\t\t<div id=\"center\" >\r\n");
      out.write("\t\t\t<div class=\"article_wrapper\"  style=\"min-height: 550px;\" >\r\n");
      out.write("\t\t\t\t<h2>Search By Username</h2>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<table style=\"font-size: 14px;\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td>Search by Username &nbsp;&nbsp;&nbsp;</td>\r\n");
      out.write("\t\t\t\t<td><input id=\"uname\" type=\"text\" onkeyup=\"getlist()\" autocomplete=\"off\"/>&nbsp;&nbsp;&nbsp;</td>\r\n");
      out.write("\t\t\t\t<td><input type=\"button\" value=\"Search\" id=\"button\" onclick=\"getlist()\"/></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t<br />\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<table id=\"user\" style=\"font-size: 14px;\">\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<hr />\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t<!-- right column -->\r\n");
      out.write("\t\t<div id=\"rightcolumn\" style=\"float: right;\">\r\n");
      out.write("\t\t<h3 class=\"leftbox\"><a href=\"smartmatch.jsp\">Smart Match</a></h3>\r\n");
      out.write("\t\t\t  <hr />\r\n");
      out.write("            <h3 class=\"leftbox\"><a href=\"friend_game_req.jsp\">Play With a Friend</a></h3>\r\n");
      out.write("\t\t\t  <hr />\r\n");
      out.write("\t\t\t <h3 class=\"leftbox\"><a href=\"pending_game_request.jsp\">Pending Game Requests</a></h3>\r\n");
      out.write("\t\t\t<hr />\r\n");
      out.write("\t\t\t   <h3 class=\"leftbox\"><a href=\"my_games.jsp\">My Games</a></h3>\r\n");
      out.write("\t\t\t<hr />\r\n");
      out.write("\t\t</div>\r\n");
      out.write("        </div>\r\n");
      out.write("\t\r\n");
      out.write("\t<!-- Start Footer -->\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "footer.html", out, false);
      out.write("\r\n");
      out.write("    <!-- End Footer -->\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
