<jsp:include page="check_session.jsp" />
<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>

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
				<li class="active"><a href="index.jsp">Home</a></li>
				<li><a href="game_play.jsp" >Game Play</a></li>
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
			<div class="article_wrapper" >
				

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

			
			try {
				 ps=conn.prepareStatement("select * from game_req where user1=?");
			        ps.setString(1,user);
			     
					rs=ps.executeQuery();
					
				
				Boolean game1=false;
				
				
    			%>
        		<h2>Game Requests Sent</h2>
    			<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
    			
    			<%
		        		
    			
    			while(rs.next())
		        		{		
		     				game1=true;
		        			String u=rs.getString("user2");
		        			String rid=rs.getString("req_id");
		        			
		        			%>

			<tr>
				<td>Username</td>
				<td>:</td>
				<td><a href="profile.jsp?username=<% out.print(u); %>"><% out.print(u); %></a></td>
				<td>
				<form action="DeleteSentGameRequest" method="get" style="display: inline;">
				<input type="hidden" name="username" value="<% out.print(u); %>" /> 
				<input type="hidden" name="req_id" value="<% out.print(rid); %>" />
				<input type="submit" value="Delete Request" style="background-color:#fff;"/> 
				</form>
				</td>
			</tr>
	
			
  		<%
						}
		        		
		        		
				
				if(game1==false)
				{
					%>

					<tr>
						<td>There are no pending game requests to display right now.</td>
					
					</tr>
			
					
		  		<%
					
				}
				%>
		        </table>
		        
		        <%
			}
				 
				
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
			

			try {
				ps2=conn.prepareStatement("select * from game_req where user2=?");
			        ps2.setString(1,user);
			   
					rs2=ps2.executeQuery();
				
				Boolean game2=false;
				
				
   			%>
       		<h2>Game Requests Received</h2>
   			<table id="signup" cellpadding="15px;" style= "margin-bottom: 300px;">
   			
   			<%
		        		
   			
   			while(rs2.next())
		        		{		
		     				game2=true;
		        			String u=rs2.getString("user1");
		        			String rid=rs2.getString("req_id");
		        			        
		        			%>

			<tr>
				<td>Username</td>
				<td>:</td>
				<td><a href="profile.jsp?username=<% out.print(u); %>"><% out.print(u); %></a></td>
				<td>
				<form action="AcceptGameRequest" method="get" style="display: inline;">
				<input type="hidden" name="username" value="<% out.print(u); %>" /> 
				<input type="hidden" name="req_id" value="<% out.print(rid); %>" />
				<input type="submit" name="accept" value="accept" style="background-color:#fff;"/> 
				</form>
				<form action="RejectGameRequest" method="get" style="display: inline;">
				<input type="hidden" name="username" value="<% out.print(u); %>" /> 
				<input type="hidden" name="req_id" value="<% out.print(rid); %>" /> 
				<input type="submit" name="reject" value="reject" style="background-color:#fff;"/> 
				</form>
				</td>
			</tr>
	
			
 		<%
		        			
		        			
 			}
		        		
		        		
				
				if(game2==false)
				{	
					%>

					<tr>
						<td>There are no pending friend requests to display right now.</td>
					
					</tr>
			
					
		  		<%
					
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
			
			<hr />
		</div>
	<!-- right column -->
			<div id="rightcolumn" style="float: right;">
		<h3 class="leftbox"><a href="smartmatch.jsp">Smart Match</a></h3>
			  <hr />
            <h3 class="leftbox"><a href="friend_game_req.jsp">Play With a Friend</a></h3>
			  <hr />
			 <h3 class="leftbox"><a href="game_play.jsp">Search By Username</a></h3>
			<hr />
			<h3 class="leftbox"><a href="my_games.jsp">My Games</a></h3>
			<hr />
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
