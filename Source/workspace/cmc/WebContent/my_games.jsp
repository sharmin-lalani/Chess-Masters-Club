<jsp:include page="check_session.jsp" />

<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Chess Masters Club</title>
<link href="stylesheets/common.css" rel="stylesheet" type="text/css" />

</head>
<body>

	<!-- Start Header -->
	<div id="header">
    
		<div class="container">
            
	
    <jsp:include page="session.jsp" />
			<!-- top navigation -->
			<ul id="navigation">
				<li><a href="index.jsp">Home</a></li>
				<li  class="active"><a href="game_play.jsp" >Game Play</a></li>
				<li><a href="tutorial.jsp" >Tutorials</a></li>
				<li><a href="tournaments.jsp" >Tournaments</a></li>
				<li><a href="faq.jsp" >FAQs</a></li>   
			</ul>
            
			<!-- banner message and building background -->
			<div id="banner">
				<p>
                An Online Chess Club where game lovers can learn and play Chess games with their friends or other players. 
                </p>  
			</div>
			<hr />     
		</div>
	</div>


	<!-- Start Main Content -->
	<div id="main" class="container">

		<!-- main content area -->
		<div id="center" >
			<div class="article_wrapper"  style="min-height: 550px;" >
			<h2 style="padding:0px 0px 0px 80px;">My Games</h2>
			
			<%
			String user=(String)session.getAttribute("username");

		
			if(user==null) 
			{
				 request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			c3p0pooledconnection c = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			PreparedStatement ps =null,ps2=null;
			ResultSet rs=null,rs2=null;
			String query1="select game_id,XMLQUERY('$RECORD/game/lastmovedt/text()'),XMLQUERY('$RECORD/game/date/text()'),XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()'),XMLQUERY('$RECORD/game/isend/text()'),XMLQUERY('$RECORD/game/winner/text()') from chess_game order by game_id desc";
			String query2="select game_id,XMLQUERY('$RECORD/game/lastmovedt/text()'),XMLQUERY('$RECORD/game/date/text()'),XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()'),XMLQUERY('$RECORD/game/isend/text()'),XMLQUERY('$RECORD/game/winner/text()'),tournament_id from tournament_games order by game_id desc";
			Date date_time=new Date();
			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dtnow=dnow.format(date_time);
			try {
				   ps=conn.prepareStatement(query1);
			       rs=ps.executeQuery();	
			       
			       %>
			       
			       <table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">		
    			
	<tr style="font-size: 16px; font-weight: bold;">
		<td>White Player</td>
		<td>Black Player</td>
		<td>Started On</td>
		<td>Last Moved Date</td>
		<td>Status</td>
	</tr>
			       
			       <%
					
    			while(rs.next())
		        		{	
    						String game_id=rs.getString(1);
		     				String wp=rs.getString(4);
		     				String bp=rs.getString(5);
		     				String dt=rs.getString(3);
		     				String lmdt=rs.getString(2);
		     				String end=rs.getString(6);
		     				if(user.matches(wp) || user.matches(bp))
		     				{
		     				%>				
		     					
		     <tr>
				
				<td><a href="profile.jsp?username=<% out.print(wp); %>"><% out.print(wp); %></a></td>
				<td><a href="profile.jsp?username=<% out.print(bp); %>"><% out.print(bp); %></a></td>
				<td><% out.print(dt); %></td>
				<td><% out.print(lmdt); %></td>
				<td>
				<% if(end.equals("0"))out.print("Ongoing"); 
				else 
					{
					out.print("Completed:"); 
					String winner=rs.getString(7);
					if(winner.matches("White")) out.print("White won");
					else if(winner.matches("Black")) out.print("Black won");
						else out.print("Game draw");
					}
				%>
				</td>
				<td><a href="game.jsp?game_id=<% out.print(game_id); %>"><% if(end.equals("0"))out.print("Continue Playing"); else out.print("View Game"); %></a></td>
			</tr>
	 	
			
  		<%
		     				}
		        	}
		%>
		</table>
		<%
			
			}
				 
				
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
			%>
			<h2 style="padding:0px 0px 0px 80px;">My Tournaments</h2>
			<%
			try {
				   ps=conn.prepareStatement(query2);
			       rs=ps.executeQuery();	
			       
			       %>
			       
			       <table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">		
 			
	<tr style="font-size: 16px; font-weight: bold;">
		<td>Tournament Name</td>
		<td>White Player</td>
		<td>Black Player</td>
		<td>Last Moved Date</td>
		<td>Status</td>
	</tr>
			       
			       <%
			       
 			while(rs.next())
		        		{	
 						String game_id=rs.getString(1);
		     				String wp=rs.getString(4);
		     				String bp=rs.getString(5);
		     				String name="";
		     				String lmdt=rs.getString(2);
		     				String end=rs.getString(6);
		     				String tid=rs.getString(8);
		     				String query3="select name from tournament where tournament_id='"+tid+"'";
		 			        PreparedStatement s=conn.prepareStatement(query3);	
		 			        ResultSet r=s.executeQuery();
		 			        if(r.next())
		 			        {
		 			        	name=r.getString(1);
		 			        }
		     				if(user.matches(wp) || user.matches(bp))
		     				{
		     				%>				
		     					
		     <tr>
				<td><a href="tournament.jsp?t_id=<% out.print(tid); %>"><% out.print(name); %></a></td>
				<td><a href="profile.jsp?username=<% out.print(wp); %>"><% out.print(wp); %></a></td>
				<td><a href="profile.jsp?username=<% out.print(bp); %>"><% out.print(bp); %></a></td>
				
				<td><% out.print(lmdt); %></td>
				<td>
				<% if(end.equals("0"))out.print("Ongoing"); 
				else 
					{
					out.print("Completed:"); 
					String winner=rs.getString(7);
					if(winner.matches("White")) out.print("White won");
					else if(winner.matches("Black")) out.print("Black won");
						else out.print("Game draw");
					}
				%>
				</td>
				<td><a href="t_game.jsp?game_id=<% out.print(game_id); %>"><% if(end.equals("0"))out.print("Continue Playing"); else out.print("View Game"); %></a></td>
			</tr>
	 	
			
		<%
		     				}
		        	}
		%>
		</table>
		<%
			
			}
				 
				
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
			%>
			



		   </div>
		</div>
		
	<!-- right column -->
		<div id="rightcolumn" style="float: right;">
		<h3 class="leftbox"><a href="smartmatch.jsp">Smart Match</a></h3>
			  <hr />
			  <h3 class="leftbox"><a href="game_play.jsp">Search by Username</a></h3>
			<hr />
            <h3 class="leftbox"><a href="friend_game_req.jsp">Play With a Friend</a></h3>
			  <hr />
			 <h3 class="leftbox"><a href="pending_game_request.jsp">Pending Game Requests</a></h3>
			<hr />
			
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
