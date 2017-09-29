package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;


/**
 * Servlet implementation class MakeGroups
 */
@WebServlet("/MakeGroups")
public class MakeGroups extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeGroups() {
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
		PreparedStatement ps=null, ps1=null,ps2=null,ps3=null,ps4=null,ps5=null,ps6=null,ps7=null,p=null,p1=null,p2=null,p3=null,ps8=null;
		ResultSet rs1=null,rs2=null,rs4=null,r1=null,r2=null,r=null;
		
		PrintWriter out=response.getWriter();
		Date date_time=new Date();
		SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dt=dnow.format(date_time);

		String white="";
		String black="";
		
		String no=request.getParameter("num");
		String id=request.getParameter("t_id");
		String rd=request.getParameter("round");
		String ed1=request.getParameter("ed1");
		String ed2=request.getParameter("ed2");
		String ed3=request.getParameter("ed3");
		String ed=ed1+"-"+ed2+"-"+ed3;
		
		int num=Integer.parseInt(no);
		int counter=0;
		
		if(ed.compareTo(dt)>0)
		{
		try {
			String query="insert into groups(tournament_id) values(?)";
			
			
		while(counter!=num)
		{
			ps=conn.prepareStatement(query);
			ps.setString(1,id);
				
				ps.executeUpdate();
				
			counter++;
		} 
		
		
		
		String sql="select max_players from tournament where tournament_id=?";
		p=conn.prepareStatement(sql);
		p.setString(1,id);
		r=p.executeQuery();
		r.next();
		String max=r.getString(1);
		
		
		int rs6=0;
		
		String q1="select * from groups where tournament_id=?";
		String q2="select  user.username from tournament_req,user where tournament_req.username=user.username and t_id=? and status='0' order by rating desc limit "+max;
		String q3="insert into group_members values(?,?)";
		String q8="insert into tournament_points(tournament_id,username,group_id) values(?,?,?)";
	
		String q6="update tournament_req set status=? where t_id=? and username=?";
		String q7="update user set no_of_tour_played=no_of_tour_played+1 where username=?";
			
			ps1=conn.prepareStatement(q1);
			ps1.setString(1, id);
			rs1=ps1.executeQuery();
			
			List<String> list = new ArrayList<String>();
				while (rs1.next()) {
				list.add(rs1.getString("group_id"));
				}
			String list2[]=null;
			list2 = (String[]) list.toArray(new String[list.size()]);
			
			int size=list2.length;
			
		
				
				ps2=conn.prepareStatement(q2);
				
				ps2.setString(1, id);
				
				rs2=ps2.executeQuery();
				
				int gcount=0;
					while(rs2.next())
					{
						
						String name=rs2.getString("username");
						ps3=conn.prepareStatement(q3);
						
						ps3.setString(1,list2[gcount]);
						ps3.setString(2,name);
						
						ps3.executeUpdate();
						ps8=conn.prepareStatement(q8);
						ps8.setString(1, id);
						ps8.setString(2, name);
						ps8.setString(3, list2[gcount]);
						ps8.executeUpdate();
						
						
						ps6=conn.prepareStatement(q6);
						ps6.setInt(1,1);
						ps6.setString(2,id);
						ps6.setString(3, name);
						rs6=ps6.executeUpdate();
						
						ps7=conn.prepareStatement(q7);
						ps7.setString(1,name);
						ps7.executeUpdate();
						
						gcount++;
						if(gcount==size)
							gcount=0;
						
					}
				
		
		
		
		String q4="select count(member) from group_members where group_id=?";
		String q5="update groups set no_of_members=? where group_id=?";
		
		
			int ct=0;
		
			while(ct!=size)
			{
				ps4=conn.prepareStatement(q4);
				
				ps4.setString(1, list2[ct]);
				rs4=ps4.executeQuery();
				rs4.next();
				String nom=rs4.getString(1);
				
				ps5=conn.prepareStatement(q5);
				ps5.setString(1, nom);
				ps5.setString(2, list2[ct]);
				ps5.executeUpdate();
								
				ct++;
				
			}
			
			
			if(rs6>0)
				response.sendRedirect("manage_tournaments.jsp");
			else
				response.sendRedirect("status.jsp");
				
	}	catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String s1="select group_id from groups where tournament_id=?";
		String s2="select member from group_members where group_id=?";
	
		
		
		try
		
		{
			p1=conn.prepareStatement(s1);
			p1.setString(1,id);
			r1=p1.executeQuery();
			while(r1.next())
			{
				int g=r1.getInt("group_id");
				p2=conn.prepareStatement(s2);
				p2.setInt(1,g);
				r2=p2.executeQuery();
				List<String> list = new ArrayList<String>();
				while(r2.next())
				{
					list.add(r2.getString("member"));
				
				}
				
				String list2[]=null;
				list2 = (String[]) list.toArray(new String[list.size()]);
				
				int l=list2.length;
				
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
	        			
	        			String s3="INSERT INTO tournament_games(tournament_id,group_id,end_date,round,record)"
	        		  			  +"VALUES(?,?,?,?,XMLPARSE(document"
	        		  			  +"'<game><whiteplayer>"+white+"</whiteplayer><blackplayer>"+black+"</blackplayer><isend>0</isend><lastmovedt></lastmovedt><pgn> </pgn><winner></winner></game>'"
	        		  			  +"preserve whitespace ))";
	        			
	        			p3=conn.prepareStatement(s3);
	        			p3.setString(1, id);
	        			p3.setInt(2, g);
	        			p3.setString(3, ed);
	        			p3.setString(4, rd);
	        			
	        			p3.executeUpdate();
	        			
	   				}
				
				
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		else
		{
			out.println("please enter a valid end date for round 1");
		}
	
	}
}


