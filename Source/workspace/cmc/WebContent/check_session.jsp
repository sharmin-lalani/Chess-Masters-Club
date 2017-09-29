<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="databasepools.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date"%>

<%
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
%>