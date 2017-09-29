package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class DeleteTournament
 */
@WebServlet("/DeleteTournament")
public class DeleteTournament extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTournament() {
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
		// TODO Auto-generated method stub
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		String t_id=request.getParameter("t_id");
		
		String q1="delete from tournament where tournament_id='"+t_id+"'";
		try
		{
			PreparedStatement ps=conn.prepareStatement(q1);
		
			int rs=ps.executeUpdate();
			
			if(rs>0)
				response.sendRedirect("manage_tournaments.jsp");
			else
				response.sendRedirect("status.jsp");
			
		}
		catch(SQLException e)
		{
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
	}

}
