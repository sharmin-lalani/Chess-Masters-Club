package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TourMakeMove
 */
@WebServlet("/TourMakeMove")
public class TourMakeMove extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TourMakeMove() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		String gameid=request.getParameter("gameid");
		String san=request.getParameter("san");
		String player=request.getParameter("player");
		String counter=request.getParameter("counter");
		String end=request.getParameter("is_end");
		String draw=request.getParameter("draw");
		String move="",is_end="0";
		String pgn=" ",pgn1=" ";
		String white="w";
		Connection  conn=null;
		PreparedStatement ps =null, ps1=null, ps2=null;
		int rs=0;
		ResultSet rs1=null;
		Date date_time=new Date();
		SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dt=dnow.format(date_time);
		//System.out.print("1");
		if(end.matches("1"))
			is_end="1";
		
		
		
		try 
		{
			Class.forName("com.ibm.db2.jcc.DB2Driver");
			conn=DriverManager.getConnection("jdbc:db2://localhost:50000/CMC","db2admin","admin");
		
	
		if(player.matches(white))
		{
			move=counter+"."+san;
			
		}
		else
		{
			move=san;
		}
		
		String query1="xquery db2-fn:sqlquery(\"select record from db2admin.tournament_games  where game_id = '"+gameid+"'\")/game/pgn/text()";
		
		try 
		{
			ps1=conn.prepareStatement(query1);
			rs1=ps1.executeQuery();
			
			if(rs1.next())
			{
				//System.out.print(query1);
				pgn1=rs1.getString(1);
				pgn=pgn1+" "+move;
				
				String query="UPDATE tournament_games SET record = XMLQUERY('transform copy $c := $RECORD "
						+"modify do replace value of $c/game/pgn "
						+"with \""+pgn+"\""
						+" return $c') "
						+"WHERE game_id='"+gameid+"'";
				
				String query2="UPDATE tournament_games SET record = XMLQUERY('transform copy $c := $RECORD "
						+"modify do replace value of $c/game/lastmovedt "
						+"with \""+dt+"\""
						+" return $c') "
						+"WHERE game_id='"+gameid+"'";
				
				
				ps=conn.prepareStatement(query);
				rs=ps.executeUpdate();
				ps2=conn.prepareStatement(query2);
				ps2.executeUpdate();
				
				if(is_end=="1")
				{
					String query3="UPDATE tournament_games SET record = XMLQUERY('transform copy $c := $RECORD "
							+"modify do replace value of $c/game/isend "
							+"with \""+is_end+"\""
							+" return $c') "
							+"WHERE game_id='"+gameid+"'";
					
					ps2=conn.prepareStatement(query3);
					ps2.executeUpdate();
					String play="";
					if(player.matches("w") && draw.matches("0"))
					{
						 play="White";
						
					}
					else if(player.matches("b") && draw.matches("0")) play="Black";
						
					String query4="UPDATE tournament_games SET record = XMLQUERY('transform copy $c := $RECORD "
							+"modify do replace value of $c/game/winner "
							+"with \""+play+"\""
							+" return $c') "
							+"WHERE game_id='"+gameid+"'";
					
					
					ps2=conn.prepareStatement(query4);
					ps2.executeUpdate();
					
					request.setAttribute("game_id",gameid );
					if(draw.matches("1"))
					request.setAttribute("draw","1" );
					HttpSession s= request.getSession(false);
					String username= (String) s.getAttribute("username");
					request.setAttribute("winner",username );
					request.getRequestDispatcher("TourRating").forward(request, response);	
				}
				
				conn.close();
			}
			
			
			
		} catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	
		} 
		catch (ClassNotFoundException e1) 
		{
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SQLException e1) 
		{
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		if(rs>0)
			out.print("1");
		else
			out.print("0");
	}

}
