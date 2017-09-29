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
import javax.servlet.http.HttpSession;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class ResignGame
 */
@WebServlet("/ResignGame")
public class ResignGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResignGame() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.print("hi");
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
	
		String gid=request.getParameter("gameid");
		System.out.print(gid);
		PreparedStatement ps =null;
		ResultSet rs=null;
		
		String q="select XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()'), XMLQUERY('$RECORD/game/isend/text()') from chess_game where game_id='"+gid+"'";
		try {
			ps=conn.prepareStatement(q);
			
			rs=ps.executeQuery();
			String play,player="White";
			
			if(rs.next())
			{
				String white=rs.getString(1);
				String black=rs.getString(2);
				String isend=rs.getString(3);
				
				if(isend.matches("0"))
				{
				
				if(username.matches(white)) 
					{
					play=black;
					player="Black";
					}
				else play=white;
				
				String query="UPDATE chess_game SET record = XMLQUERY('transform copy $c := $RECORD "
						+"modify do replace value of $c/game/isend "
						+"with \"1\""
						+" return $c') "
						+"WHERE game_id='"+gid+"'";
				
				ps=conn.prepareStatement(query);
				ps.executeUpdate();
				
				String query2="UPDATE chess_game SET record = XMLQUERY('transform copy $c := $RECORD "
						+"modify do replace value of $c/game/winner "
						+"with \""+player+"\""
						+" return $c') "
						+"WHERE game_id='"+gid+"'";
				
				ps=conn.prepareStatement(query2);
				ps.executeUpdate();
				
				request.setAttribute("game_id",gid );
				request.setAttribute("winner",play);
				request.getRequestDispatcher("Rating").include(request, response);
				
				}
				request.getRequestDispatcher("my_games.jsp").forward(request, response);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
}
