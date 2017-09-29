package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class SendGameRequest
 */
@WebServlet("/SendGameRequest")
public class SendGameRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendGameRequest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	PrintWriter out=response.getWriter();
	out.println("in doget");
	
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
		
		String u1=(String)session.getAttribute("username");
		String u2=request.getParameter("username");
		//String is_timed=request.getParameter("is_timed");
		//String timer=request.getParameter("timer");
		
		String query="insert into game_req(user1,user2) values(?,?)";
		PreparedStatement ps =null;
		int rs=0;
		
		try {
			out.println("in try");
	        ps=conn.prepareStatement(query);
	        		ps.setString(1,u1);
	        		ps.setString(2,u2);
	        		//ps.setString(3,is_timed);
	        		//ps.setString(4,timer);
	        		  	        		
	        		rs=ps.executeUpdate();
	        		
	        		if(rs>0)
	        		{		
	        			response.sendRedirect("pending_game_request.jsp");												
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
		PrintWriter out=response.getWriter();
		doGet(request,response);
		out.println("in do post");
		
	}

}
