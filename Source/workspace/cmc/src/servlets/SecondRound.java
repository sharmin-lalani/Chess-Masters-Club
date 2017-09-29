package servlets;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class SecondRound
 */
@WebServlet("/SecondRound")
public class SecondRound extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SecondRound() {
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
		
		PreparedStatement ps1=null,ps2=null,ps3=null;
		ResultSet rs1=null,rs3=null;
		
		
		String white="";
		String black="";
		
		String id=request.getParameter("t_id");
		String rd=request.getParameter("round");
		
		String q1="select leading_player from groups where tournament_id=?";
		String q3="select end_date from tournament where tournament_id=?";
				
		try
		{	
			ps3=conn.prepareStatement(q3);
			ps3.setString(1,id);
			rs3=ps3.executeQuery();
			rs3.next();
			String ed=rs3.getString(1);
			
			
			ps1=conn.prepareStatement(q1);
			ps1.setString(1,id);
			rs1=ps1.executeQuery();
			
			List<String> list = new ArrayList<String>();
			while(rs1.next())
			{
				list.add(rs1.getString("leading_player"));
				
			}	
			String list2[]=null;
			list2 = (String[]) list.toArray(new String[list.size()]);
			//out.println(list2[0]);
			int l=list2.length;
			int r2=0;
		
			for(int i=0; i<l-1;i++)
				for(int j=i+1;j<l;j++)
				{
					int player=(int)(10*Math.random());
        			if(player>5)
        			{
        				white=list2[i]; 
        				black =list2[j] ;
        			}
        			else
        			{
        				white=list2[j]; 
        				black =list2[i] ;
        			}
        			
        			String q2="INSERT INTO tournament_games(tournament_id,end_date,round,record)"
        		  			  +"VALUES(?,?,?,XMLPARSE(document"
        		  			  +"'<game><whiteplayer>"+white+"</whiteplayer><blackplayer>"+black+"</blackplayer><isend>0</isend><lastmovedt></lastmovedt><pgn> </pgn><winner></winner></game>'"
        		  			  +"preserve whitespace ))";
        			
        			ps2=conn.prepareStatement(q2);
        			ps2.setString(1, id);
        			
        			ps2.setString(2, ed);
        			ps2.setString(3, rd);
        			
        			r2=ps2.executeUpdate();
        			
   				}
			if(r2>0)
				response.sendRedirect("manage_tournaments.jsp");
			
			
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
