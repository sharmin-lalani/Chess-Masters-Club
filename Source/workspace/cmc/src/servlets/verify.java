package servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import authentication.hash;
import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class for Servlet: verify
 *
 */
@WebServlet("/verify")
 public class verify extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   HttpSession session ;  

    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public verify() {
		super();
		 
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 doPost(request,response) ; 
		
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		session = request.getSession() ;
		c3p0pooledconnection c = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		//session.setAttribute("conn",conn) ;
		String name =  request.getParameter("user") ;
		String pw = request.getParameter("password") ;
		String is_admin = request.getParameter("admin") ;
		String pass;
		//PrintWriter out= response.getWriter();
		//out.print(name);
		//out.print(pw);
		try {
			pass = hash.hashme(pw);
			PreparedStatement ps =null, ps1=null, ps2=null;
			ResultSet rs=null, rs1=null;
			
			try {
				ps1=conn.prepareStatement("select * from admin where admin_id=? and admin_password=?  ");
						ps1.setString(1, name);
						ps1.setString(2, pass);
						
						if(is_admin!=null)rs1=ps1.executeQuery();
						
						
						
		        ps=conn.prepareStatement("select * from user where username=? and password=? and is_verified=?");
		        		ps.setString(1,name);
		        		ps.setString(2,pass);
		        		ps.setString(3,"1");
		        		rs=ps.executeQuery();
		        		//out.print(rs1.next());
		        		
		        		if(is_admin!=null && rs1.next())
		        		{		
		        			session.setAttribute("admin_id",name ) ;
		        			response.sendRedirect("admin.jsp");
		        																	
		        		}
		        			
		        		else if(rs.next())
		        		{		
		        			session.setAttribute("username",name ) ;
		        			/*ps=conn.prepareStatement("update user set is_logged_in = 1 where username=?");
		        			ps.setString(1,name);
		        			ps.executeUpdate();*/
		        			
		        			Date date_time=new Date();
		        			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		        			String dt=dnow.format(date_time);
		        			
		        			ps2=conn.prepareStatement("update user set last_request_timestamp = ? where username=?");
		        			ps2.setString(1,dt);
		        			ps2.setString(2,name);
		        			ps2.executeUpdate();
		        			PreparedStatement ps5 =null;
		        			ps5=conn.prepareStatement("update user set is_loggedin = '1' where username=?");
		        			ps5.setString(1, name);
		        			ps5.executeUpdate();
		        			if(ps2.executeUpdate()==1)
		        			response.sendRedirect("index.jsp");	
		        			else
		        			{
		        				request.setAttribute("message", "Problem while Logging in. Try again!");
			                	request.getRequestDispatcher("status.jsp").forward(request, response);	
		        			}
		        																	
		        		}
		        		else
		        			{
		        			request.setAttribute("message", "Incorrect username or password");
		                	request.getRequestDispatcher("status.jsp").forward(request, response);	
		        			}
		        		
		        		
				}
				 
				
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
		
		
		 
	}   	  	    
}