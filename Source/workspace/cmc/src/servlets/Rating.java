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
 * Servlet implementation class Rating
 */
@WebServlet("/Rating")
public class Rating extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Rating() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("hi");
		//HttpSession s= request.getSession(false);
		//String username= (String) s.getAttribute("username");
		//System.out.println(username);
		c3p0pooledconnection c = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		String game_id=(String) request.getAttribute("game_id");
		String draw=(String) request.getAttribute("draw");
		String username=(String) request.getAttribute("winner");
		System.out.println(draw);
		
		String query="select XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()') from chess_game where game_id="+game_id;
		String query2="select rating from user where username=?";
		String white,black;
		
		 
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next())
			{
				white=rs.getString(1);
				black=rs.getString(2);
				
				ps = conn.prepareStatement(query2);
				ps.setString(1,white);
				ResultSet rs1=ps.executeQuery();
				
				ps = conn.prepareStatement(query2);
				ps.setString(1,black);
				ResultSet rs2=ps.executeQuery();
				
				if(rs1.next() && rs2.next())
				{
					int  rat_a=rs1.getInt(1);
					int  rat_b=rs2.getInt(1);
					
					int k,j ;
	
					
					 // expected chance of winning (1 = 100% and 0 = 0%) of player_a and player_b
		    		 float  a_exp = (float) (1/(1+Math.pow(10,((rat_b - rat_a)/400))));
		    		 float  b_exp = (float) (1/(1+Math.pow(10,((rat_a - rat_b)/400))));
		    		 
		    		 float final_rating_a ,final_rating_b;


		    		   // if player_a is a master player
		    		   if (rat_a > 2400)
		    		 	k = 16;
		    		   // if I'm not a master player
		    		   else 
		    		   	k = 32;
		    		   
		    		   // if player_b is a master player
		    		   if (rat_b > 2400)
		    		 	j = 16;
		    		   // if I'm not a master player
		    		   else 
		    		   	j = 32;
		    		   
		    		   String games_won="UPDATE user SET no_of_games_won=no_of_games_won+1 where username=?";
		    		   ps = conn.prepareStatement(games_won);
		    		   
		    		   
		    		   if(username.matches(white) && draw==null)
			    	   {

			    		   // final rating of player_a and player_b after the match
			    		   // 1 is for winning 0.5 draw and 0 loss
			    		   final_rating_a = rat_a + k * (1 - a_exp);
			    		   final_rating_b = rat_b + j * (0 - b_exp);
			    		   
			    		   
			    		   //update games won
			    		   ps.setString(1,white);
			    		   ps.executeUpdate();
			    	   }
			    	   else if(username.matches(black) && draw==null)
			    	   {

			    		   // final rating of player_a and player_b after the match
			    		   // 1 is for winning 0.5 draw and 0 loss
			    		   final_rating_a = rat_a + k * (0 - a_exp);
			    		   final_rating_b = rat_b + j * (1 - b_exp);
			    		   
			    		 //update games won
			    		   ps.setString(1,black);
			    		   ps.executeUpdate();
			    	   }
			    	   else
			    	   {
			    		   final_rating_a = (float) (rat_a + k * (0.5 - a_exp));
			    		   final_rating_b = (float) (rat_b + j * (0.5 - b_exp));
			    		   
			    		 //update games drawn
			    		   String games_drawn="UPDATE user SET no_of_games_drawn=no_of_games_drawn+1 where username=?";
			    		   ps = conn.prepareStatement(games_drawn);
			    		   
			    		   ps.setString(1,white);
			    		   ps.executeUpdate();
			    		   
			    		   ps.setString(1,black);
			    		   ps.executeUpdate();
			    	   }
		    		   
		    		   
		    		   String query3="UPDATE user SET rating=? where username=?";
		    		   String query4="UPDATE user SET no_of_games_played=no_of_games_played+1 where username=?";
		    		   
		    		   //update ratings
		    		   ps = conn.prepareStatement(query3);
		    		   ps.setFloat(1,final_rating_a);
		    		   ps.setString(2,white);
		    		   ps.executeUpdate();
		    		   
		    		   
		    		   ps.setFloat(1,final_rating_b);
		    		   ps.setString(2,black);
		    		   ps.executeUpdate();
		    		   
		    		  //update games played
		    		   ps = conn.prepareStatement(query4);
		    		   ps.setString(1,white);
		    		   ps.executeUpdate();
		    		   
		    		   ps.setString(1,black);
		    		   ps.executeUpdate();
		    		   
		    		   
			    	  System.out.println(final_rating_a);
			    	  System.out.println(final_rating_b);
				}
			}
	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
		
		
		
		
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
	}

}
