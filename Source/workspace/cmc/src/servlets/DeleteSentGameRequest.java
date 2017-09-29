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
 * Servlet implementation class DeleteSentGameRequest
 */
@WebServlet("/DeleteSentGameRequest")
public class DeleteSentGameRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSentGameRequest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
	
		
		String f=request.getParameter("username");
		String rid=request.getParameter("req_id");
		
	
		
		/*PrintWriter out=response.getWriter();
		out.print(u);
		out.print(f);
		
		*/
		
		
		String query1="delete from game_req where user1=? and user2=? and req_id=?";
		PreparedStatement ps =null;
		int rs=0;
		
		try {
					ps=conn.prepareStatement(query1);
	        		ps.setString(1,username);
	        		ps.setString(2,f);
	        		ps.setString(3,rid);
	        		
	        		rs=ps.executeUpdate();
	        	
	        		
	        		if(rs>0)
	        		{		
	        			

	        				response.sendRedirect("pending_game_request.jsp");
													
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
