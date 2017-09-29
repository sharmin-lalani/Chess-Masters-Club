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
 * Servlet implementation class TourRating
 */
@WebServlet("/TourRating")
public class TourRating extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TourRating() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
    
    /**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		c3p0pooledconnection c = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		String game_id=(String) request.getAttribute("game_id");
		String draw=(String) request.getAttribute("draw");
		String username=(String) request.getAttribute("winner");
		
		String query="select XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()') from tournament_games where game_id='"+game_id+"'";
		String q="select tournament_id from tournament_games  where game_id='"+game_id+"'";
		//String query3="select points from tournament_points where username=? and tournament_id=?";
		//String query4="UPDATE user SET no_of_games_played=no_of_games_played+1 where username=?";
		String query5="select rating from user where username=?";
		
		String st1="select max";
		
		String white,black,tid="";
		
		//System.out.println("1");
		 
		PreparedStatement ps,ps1;
		ResultSet rs,r;
		try {
			ps = conn.prepareStatement(q);
			r=ps.executeQuery();
			//System.out.println("2");
			
			ps = conn.prepareStatement(query);
			rs=ps.executeQuery();
			//System.out.println("3");
			
			
			if(rs.next() && r.next())
			{
				
				//System.out.println("4");
				white=rs.getString(1);
				black=rs.getString(2);
				tid=r.getString(1);
				//System.out.println("5");
				
				ps = conn.prepareStatement(query5);
				ps.setString(1,white);
				ResultSet rs1=ps.executeQuery();
			//	System.out.println("6");
				
				ps = conn.prepareStatement(query5);
				ps.setString(1,black);
				ResultSet rs2=ps.executeQuery();
				//System.out.println("7");
				
				/*ps = conn.prepareStatement(query3);
				ps.setString(1,white);
				ResultSet rs3=ps.executeQuery();
				
				ps = conn.prepareStatement(query3);
				ps.setString(1,black);
				ResultSet rs4=ps.executeQuery();*/
				//System.out.println("8");
				
				if(rs1.next() && rs2.next() /*&& rs3.next() && rs4.next() */)
				{
					//System.out.println("9");
					
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
		    		   String query2="UPDATE tournament_points SET points=points + ? where username=? and tournament_id=?";
		    			
		    		   ps = conn.prepareStatement(games_won);
		    		   ps1 = conn.prepareStatement(query2);
		    		  // System.out.println("10");
		    			
		    		   if(username.matches(white) && draw==null)
			    	   {	//System.out.println("11");
			   		

			    		   // final rating of player_a and player_b after the match
			    		   // 1 is for winning 0.5 draw and 0 loss
			    		   final_rating_a = rat_a + k * (1 - a_exp);
			    		   final_rating_b = rat_b + j * (0 - b_exp);
			    		   
			    		   
			    		   //update games won
			    		   ps.setString(1,white);
			    		   ps.executeUpdate();
			    		   
			    		   ps1.setInt(1,2);
			    		   ps1.setString(2,white);
			    		   ps1.setString(3,tid);
			    		   ps1.executeUpdate();
			    		   //System.out.println("12");
			    			
			    	   }
			    	   else if(username.matches(black) && draw==null)
			    	   {
			    		   //System.out.println("13");
			    			
			    		   // final rating of player_a and player_b after the match
			    		   // 1 is for winning 0.5 draw and 0 loss
			    		   final_rating_a = rat_a + k * (0 - a_exp);
			    		   final_rating_b = rat_b + j * (1 - b_exp);
			    		   
			    		 //update games won
			    		   ps.setString(1,black);
			    		   ps.executeUpdate();
			    		   
			    		   ps1.setInt(1,2);
			    		   ps1.setString(2,black);
			    		   ps1.setString(3,tid);
			    		   ps1.executeUpdate();
			    		   //System.out.println("14");
			    			
			    	   }
			    	   else
			    	   {System.out.println("15");
			   		
			    		   final_rating_a = (float) (rat_a + k * (0.5 - a_exp));
			    		   final_rating_b = (float) (rat_b + j * (0.5 - b_exp));
			    		   
			    		 //update games drawn
			    		   String games_drawn="UPDATE user SET no_of_games_drawn=no_of_games_drawn+1 where username=?";
			    		   ps = conn.prepareStatement(games_drawn);
			    		   
			    		   ps.setString(1,white);
			    		   ps.executeUpdate();
			    		   
			    		   ps.setString(1,black);
			    		   ps.executeUpdate();
			    		   
			    		   ps1.setInt(1,1);
			    		   ps1.setString(2,white);
			    		   ps1.setString(3,tid);
			    		   ps1.executeUpdate();
			    		   
			    		   ps1.setInt(1,1);
			    		   ps1.setString(2,black);
			    		   ps1.setString(3,tid);
			    		   ps1.executeUpdate();
			    		   //System.out.println("16");
			    			
			    	   }
		    		   
		    		   
		    		   String query3="UPDATE user SET rating=? where username=?";
		    		   String query4="UPDATE user SET no_of_games_played=no_of_games_played+1 where username=?";
		    		   //System.out.println("17");
		    			
		    		   //update ratings
		    		   ps = conn.prepareStatement(query3);
		    		   ps.setFloat(1,final_rating_a);
		    		   ps.setString(2,white);
		    		   ps.executeUpdate();
		    		   //System.out.println("18");
		    			
		    		   
		    		   ps.setFloat(1,final_rating_b);
		    		   ps.setString(2,black);
		    		   ps.executeUpdate();
		    		   //System.out.println("19");
		    			
		    		  //update games played
		    		   ps = conn.prepareStatement(query4);
		    		   ps.setString(1,white);
		    		   ps.executeUpdate();
		    		   
		    		   ps.setString(1,black);
		    		   ps.executeUpdate();
		    		   //System.out.println("20");
		    			
					
					
					
				}
				
			}
			
			
			String s1="select max(points) from tournament_points where tournament_id=?";
			String s2="select username from tournament_points where points=? and tournament_id=? and group_id=?";
			String s3="update groups set leading_player=? where tournament_id=? and group_id=?";
			String s4="select groups.group_id from groups join group_members on groups.group_id=group_members.group_id where groups.tournament_id=? and group_members.member=? ";	
			PreparedStatement p1=null,p2=null,p3=null,ps4=null;
			ResultSet r1=null;
			
			p1=conn.prepareStatement(s1);
			p1.setString(1,tid);
			r1=p1.executeQuery();
			r1.next();
			int max=r1.getInt(1);
			
			ps4=conn.prepareStatement(s4);
			ps4.setString(1,tid );
			ps4.setString(2,username);
			r1=ps4.executeQuery();
			r1.next();
			 //System.out.println("23");
			int group_id=r1.getInt(1);
			
			
			 //System.out.println("21");
			p2=conn.prepareStatement(s2);
			p2.setInt(1,max );
			p2.setString(2, tid);
			p2.setInt(3,group_id);
			r1=p2.executeQuery();
			r1.next();
			String player_lead=r1.getString(1);
			
			 //System.out.println("22");
			
			
			
			p3=conn.prepareStatement(s3);
			p3.setString(1,player_lead);
			p3.setString(2,tid);
			p3.setInt(3,group_id);
			p3.executeUpdate();
		
	
			
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
