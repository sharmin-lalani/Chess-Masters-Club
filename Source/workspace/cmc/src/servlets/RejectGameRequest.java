package servlets;

import java.io.IOException;
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
 * Servlet implementation class RejectFriendRequest
 */
@WebServlet("/RejectGameRequest")
public class RejectGameRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RejectGameRequest() {
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
		
		String u=request.getParameter("username");
		String f=(String)session.getAttribute("username");
		String req_id=request.getParameter("req_id");
		
		String query1="select user2 from game_req where user1=? and user2=? and req_id=?";
		String query2="delete from game_req where user1=? and user2=? and req_id=?";
		PreparedStatement ps =null;
		ResultSet rs=null;
		
		try {
	        ps=conn.prepareStatement(query1);
	        		ps.setString(1,u);
	        		ps.setString(2,f);
	        		ps.setString(3,req_id);
	        			
	        		rs=ps.executeQuery();
	        		if(rs.next())
	        		{		
	        			
	        			try {
	        				PreparedStatement stmt  = conn.prepareStatement(query2) ;
	        				stmt.setString(1,u) ; 
	        				stmt.setString(2,f) ;
	        				stmt.setString(3,req_id);
	        				stmt.executeUpdate();
	        				
	        				
	        				response.sendRedirect("pending_game_request.jsp");
	        			
	        		 	}
	        			 catch(Exception ex)
	        			 {
	        				 ex.printStackTrace() ;
	        			 }
	        																	
	        		}
	        		else
	        	
	        		request.getRequestDispatcher("status.jsp").forward(request, response);	
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
