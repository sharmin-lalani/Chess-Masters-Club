package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class Userlist
 */
@WebServlet("/Game_userlist")
public class Game_userlist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Game_userlist() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession se =request.getSession(false);
		 
		String username=(String)se.getAttribute("username");
		            if(username==null)
		            {
		            	request.setAttribute("message", "You must be logged in to view this page");
		            	request.getRequestDispatcher("status.jsp").forward(request, response);	
		            }

		
		PrintWriter out=response.getWriter();
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		String val=request.getParameter("value");
		//out.println(val);
		HttpSession session=request.getSession(false);
		String me= (String) session.getAttribute("username");
		
		 try
		  {
			String query ="select username from user where username!=? and username like ? and is_verified=1";
			 
			 PreparedStatement stmt  = conn.prepareStatement(query) ; 
			 stmt.setString(1,me) ; 
			 stmt.setString(2,val+"%") ;
			
				ResultSet rs=stmt.executeQuery();
				
				while(rs.next())
				{
					String user=rs.getString("username");
					out.println(user);
				}
				
		   }
		  catch(Exception e)
		  {
			  e.getMessage();
			  e.printStackTrace();
			//out.print("Sorry could not connect to the database");
		  }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
	}

}
