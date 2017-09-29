package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class Activate
 */
@WebServlet("/Activate")
public class Activate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Activate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=(String)request.getParameter("username");
		String key=(String)request.getParameter("key");
		//PrintWriter out = response.getWriter();
		if(username==null || username=="" || key==null || key=="" )
			request.getRequestDispatcher("index.jsp").forward(request, response);
		else
		{
			PreparedStatement ps =null;
			ResultSet rs=null;
			int res=0,res1=0;
			
			try {
				c3p0pooledconnection c = new c3p0pooledconnection() ;
				Connection conn = c.create() ;
		        ps=conn.prepareStatement("select * from activation where username=? and activation=?");
		        		ps.setString(1,username);
		        		ps.setString(2,key);
		        			
		        		rs=ps.executeQuery();
		        		if(rs.next())
		        		{		
		        			String q="update user set is_verified='1' where username='"+username+"'";
		        	        try {
		        				Statement stmt  = conn.createStatement() ;
		        				res  = stmt.executeUpdate(q);
		        				if(res>0)
		        				{
		        					q="delete from activation where username='"+username+"'";
				        	        try {
				        				stmt  = conn.createStatement() ;
				        				res1  = stmt.executeUpdate(q);
				        				if(res1>0)
				        				{
				        					String message="You have successfully verified your account.\n"
				        							+"You can now log in.";
									        request.setAttribute("message", message);
				        				}
				        				
				        				}
				        	        catch (SQLException e) {
				        				// TODO Auto-generated catch block
				        				e.printStackTrace();
				        			//	System.out.println("username incorrect");
				        			}
		        				}
		        				
		        				}
		        	        catch (SQLException e) {
		        				// TODO Auto-generated catch block
		        				e.printStackTrace();
		        			//	System.out.println("username incorrect");
		        			}
		        																	
		        		}
		        		request.getRequestDispatcher("status.jsp").forward(request, response);	
				}
				 
				
			catch (Exception exc) 
			{
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
