package servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import authentication.hash;
import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class ResetPassword
 */
@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession se =request.getSession(false);
		 
		String username=(String)se.getAttribute("username");
		
		            if(username==null)
		            {
		            	request.setAttribute("message", "You must be logged in to view this page");
		            	request.getRequestDispatcher("status.jsp").forward(request, response);	
		            }

		
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		
		String u=request.getParameter("username");
		String cp=request.getParameter("cp");
		String np=request.getParameter("pass");
		String pass,newpass;

		
		try {
			pass = hash.hashme(cp);
			newpass = hash.hashme(np);
			PreparedStatement ps =null;
			ResultSet rs=null;
			

			String query1="select password from user where username=? and password=?";
			String query2="update user set password=? where username=?";
			
			try {
		        ps=conn.prepareStatement(query1);
		        		ps.setString(1,u);
		        		ps.setString(2,pass);
		        			
		        		rs=ps.executeQuery();
		        		if(rs.next())
		        		{		
		        			try {
		        				PreparedStatement stmt  = conn.prepareStatement(query2) ;
		        				stmt.setString(1,newpass) ; 
		        				stmt.setString(2,u) ;
		        				
		        				int res=stmt.executeUpdate();
		        				if(res>0)
		        					request.setAttribute("edit_success", "true");
		        				
		        				request.getRequestDispatcher("/profile.jsp?username="+u).forward(request, response);
		        			
		        		 	}
		        			 catch(Exception ex)
		        			 {
		        				 ex.printStackTrace() ;
		        			 }
		        																	
		        		}
		        		request.setAttribute("ErrorMessage","Password is incorrect");
		        		request.getRequestDispatcher("status.jsp").forward(request, response);	
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
