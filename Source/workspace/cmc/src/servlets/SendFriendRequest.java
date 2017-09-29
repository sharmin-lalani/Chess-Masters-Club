package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class SendFriendRequest
 */
@WebServlet("/SendFriendRequest")
public class SendFriendRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendFriendRequest() {
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

		
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		HttpSession session = request.getSession(false) ;
		
		String f=request.getParameter("username");
		String u=(String)session.getAttribute("username");
		
		
		String query="insert into friendship (username,friendname) values(?,?)";
		PreparedStatement ps =null;
		int rs=0;
		
		try {
	        ps=conn.prepareStatement(query);
	        		ps.setString(1,u);
	        		ps.setString(2,f);
	        			
	        		rs=ps.executeUpdate();
	        		if(rs>0)
	        		{		
	        			response.sendRedirect("pending_friend_request.jsp");													
	        		}
	        		else
	        	
	        			response.sendRedirect("status.jsp");	
			}
			 
			
		catch (Exception exc) {
			// TODO Auto-generated catch block
			exc.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
