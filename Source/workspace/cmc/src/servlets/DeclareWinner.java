package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class DeclareWinner
 */
@WebServlet("/DeclareWinner")
public class DeclareWinner extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeclareWinner() {
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
		
		
		String q1="select max(points) from tournament_points where tournament_id=?";
		String q2="select username from tournament_points where points=? and tournament_id=?" ;
		String q3="insert into winners( tournament_id, winner) values(?,?)";
		String q4="update user set no_of_tour_won=no_of_tour_won + 1 where username=?";
		
		PreparedStatement ps1=null,ps2=null,ps3=null,ps4=null;
		ResultSet rs1=null,rs2=null;
		
		String id=request.getParameter("t_id");
		
		
		try
		{
			
			ps1=conn.prepareStatement(q1);
			ps1.setString(1,id);
			rs1=ps1.executeQuery();
			rs1.next();
			
		
				String p=rs1.getString(1);
				ps2=conn.prepareStatement(q2);
				ps2.setString(1,p);
				ps2.setString(2, id);
				rs2=ps2.executeQuery();
				int r3=0;
				
				while(rs2.next())
				{
					String winner=rs2.getString(1);
					ps3=conn.prepareStatement(q3);
					ps3.setString(1, id);
					ps3.setString(2,winner);
					r3=ps3.executeUpdate();
					ps4=conn.prepareStatement(q4);
					ps4.setString(1, winner);
					ps4.executeUpdate();
				}
				
				
			
			if(r3>0)
			{
				response.sendRedirect("admin_tournaments.jsp?t_id="+id);
			}
			else
			{
				response.sendRedirect("status.jsp");
			}
			
			
			
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
