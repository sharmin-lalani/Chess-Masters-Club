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
import java.sql.*;
import databasepools.*;
import java.util.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class check_005fsession_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

HttpSession se =request.getSession(false);
 
String username=(String)se.getAttribute("username");
String admin_id=(String)se.getAttribute("admin_id");
            if(username==null && admin_id==null)
            {
            	request.setAttribute("message", "You must be logged in to view this page");
            	request.getRequestDispatcher("status.jsp").forward(request, response);
            	
            	response.setHeader("Pragma", "no-cache");
            	response.setHeader("Cache-Control", "no-store");
            	response.setHeader("Expires", "0");
            	response.setDateHeader("Expires",-1);
            	
            }
            else if(username!=null)
            {
    			
    			Calendar now = Calendar.getInstance();
    			now.add(Calendar.MINUTE, -30);
    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				String n=df.format(now.getTime());
	
            	String query="select last_request_timestamp from user where username='"+username+"'and last_request_timestamp>'"+n+"'";

            	c3p0pooledconnection c  = new c3p0pooledconnection() ;
        		Connection conn = c.create() ;
        		try 
        		{
            	PreparedStatement stmt=conn.prepareStatement(query);;
        		ResultSet rs=stmt.executeQuery();
        		
        		//System.out.print(rs.next());
        		
        		if(rs.next())
        		{
        			//update user timestamp
        			Date date_time=new Date();
					SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					String dt=dnow.format(date_time);
        			
        			PreparedStatement ps=conn.prepareStatement("update user set last_request_timestamp=? where username=?");
        			ps.setString(1, dt);
        			ps.setString(2, username);
        			ps.executeUpdate();
        		}
        	
        		else
        		{	
        			
        			//if the user has not requested anything in the last 30 minutes, log him out
        			
        			se.invalidate();
        			response.setHeader("Pragma", "No-cache");
        			response.setHeader("Cache-Control", "no-cache");
        			response.setHeader("Cache-Control", "must-revalidate");
        			response.setDateHeader("Expires",0);

        			response.sendRedirect("index.jsp"); 
        			
        		}
        		
        		}
        		catch (Exception exc) {
    				// TODO Auto-generated catch block
    				exc.printStackTrace();
    			}
        		
            	
            }

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
