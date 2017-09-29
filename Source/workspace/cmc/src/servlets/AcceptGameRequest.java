package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class AcceptFriendRequest
 */
@WebServlet("/AcceptGameRequest")
public class AcceptGameRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AcceptGameRequest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//PrintWriter out=response.getWriter();
		
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
		
		String u1=request.getParameter("username");
		String u2=(String)session.getAttribute("username");
		
		String req_id=request.getParameter("req_id");
		
		
		String query1="select * from game_req where user1=? and user2=? and req_id=?";
		
		String query3="delete from game_req where user1=? and user2=? and req_id=?";
		PreparedStatement stmt1=null, stmt2=null, stmt3=null;
		ResultSet rs=null;
		String white,black; 
		
		
		try {
	        stmt1=conn.prepareStatement(query1);
	        stmt1.setString(1,u1);
	        stmt1.setString(2,u2);
	        stmt1.setString(3,req_id);
	        			
	        		rs=stmt1.executeQuery();
	        		if(rs.next())
	        		{		
	        			
        				
	        			int player=(int)(10*Math.random());
	        			if(player>5)
	        			{
	        				white=u1; 
	        				black =u2 ;
	        			}
	        			else
	        			{
	        				white=u2 ; 
	        				black =u1 ;
	        			}
	        			
	        			Date date_time=new Date();
	        			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	        			String dt=dnow.format(date_time);
	        			
	        			String query4 = "INSERT INTO chess_game(record)"
	        			  +"VALUES(XMLPARSE(document"
	        			  +"'<game><whiteplayer>"+white+"</whiteplayer><blackplayer>"+black+"</blackplayer><date>"+dt+"</date><isend>0</isend><lastmovedt></lastmovedt><pgn> </pgn><winner></winner></game>'"
	        			  +"preserve whitespace ))";
	   
        				
        				//String query2="insert into chess_game(record) values('<game><whiteplayer>"+white+"</whiteplayer><blackplayer>"+black+"</blackplayer><date>"+dt+"</date><isend>0</isend><lastmovedt></lastmovedt><pgn> </pgn></game>')";
        		
        				
	        			stmt2  = conn.prepareStatement(query4, Statement.RETURN_GENERATED_KEYS) ;
        				
        				int rs2=stmt2.executeUpdate();
        		
        				
        				ResultSet r=stmt2.getGeneratedKeys();
        			if(r.next())
        				{
        					
        					BigDecimal am;
        					am=r.getBigDecimal(1);
        				
        				
        				if(rs2>0)        				
        				{ 
        					stmt3  = conn.prepareStatement(query3) ;
	        				stmt3.setString(1,u1) ; 
	        				stmt3.setString(2,u2) ;
	        				stmt3.setString(3,req_id);
	        				
	        				int rs3=stmt3.executeUpdate();
	        				
	        				if(rs3>0)
	        				{
	        					//out.println("deleting req");
	        					response.sendRedirect("game.jsp?game_id="+am);
	        				}
        				}
        				}
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
