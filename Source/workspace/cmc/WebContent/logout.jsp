

<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>
<%
Boolean is_admin=false;
String admin_id=(String)session.getAttribute("admin_id");
if(admin_id!=null)
	is_admin=true;
else
{
	String user=(String)session.getAttribute("username");
	c3p0pooledconnection c = new c3p0pooledconnection() ;
	Connection conn = c.create() ;
	PreparedStatement ps =null;
	ps=conn.prepareStatement("update user set is_loggedin = '0' where username=?");
	ps.setString(1, user);
	ps.executeUpdate();

}
	session.invalidate();
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);

if(is_admin)response.sendRedirect("admin.jsp");
else response.sendRedirect("index.jsp");

%>
