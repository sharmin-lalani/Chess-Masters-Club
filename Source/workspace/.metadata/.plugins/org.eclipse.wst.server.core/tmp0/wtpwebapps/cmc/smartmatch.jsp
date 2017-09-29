<jsp:include page="check_session.jsp" />

<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
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
			<div class="article_wrapper"  style="min-height: 550px;" >
				<h2>Smart Match Results</h2>
				<% 
				HttpSession s= request.getSession(false);
				String username = (String) session.getAttribute("username");
				
				c3p0pooledconnection c  = new c3p0pooledconnection() ;
				Connection conn = c.create() ;
				String query1="select rating from user where username='"+username+"'";
				PreparedStatement ps =null;
				int counter=0;
				int r=20;
				int rat=1200;
				int op_rat=0;
				int flag=0;
				
				Calendar now = Calendar.getInstance();
    			now.add(Calendar.MINUTE, -30);
    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				String n=df.format(now.getTime());
				try {
					ps=conn.prepareStatement(query1);
					ResultSet rs1=ps.executeQuery();
					if(rs1.next())
					{
						rat=rs1.getInt("rating");
					}
					
				while(counter<=20)
				{
				
				int low=rat-r;
				int high=rat+r;
	
				ResultSet rs=null;
				String query= "select username, rating from user where last_request_timestamp>'"+n+"' and rating between '"+low+"' and '"+high+"'";
				
		        ps=conn.prepareStatement(query);
			        		//ps.setString(1,l);
			        		//ps.setString(2,h);
			        		rs=ps.executeQuery();
			        		
			        		while(rs.next())
			        		{		
			        			String user=rs.getString("username");
			        			if(!username.equals(user))
			        				
			        			{
			        				op_rat=rs.getInt("rating");
			        			
			        			%>
			        			<table style="font-size:14px;">
			        			<tr><td><a href="profile.jsp?username=<%= user %>"><%= user %></a>&nbsp;&nbsp;&nbsp;</td>
			        			<td>Rating:&nbsp;&nbsp;&nbsp;</td>
			        			<td><%= op_rat %>&nbsp;&nbsp;&nbsp;</td>
		<td><form method="get" action="SendGameRequest" >
		<input type="hidden" name="username" value="<%= user %>" />
		<input type="submit" value="Start Game" /></form></td></tr>
			        			
			        			</table>
			        			<%
			        			flag=1;
								break;
			        			}
			        			
			        		}
			        		if(flag==1)
			        			break;
							counter=counter+1;
							r=r+20;

				}
				if(counter==21)
				{
					%>  
					<p style="font-size:14px;"> Sorry, No match found. Try again in some time!</p>
					<%
				}
				}
				 catch(Exception ex)
    			 {
    				 ex.printStackTrace() ;
    			 }
			        		
			
				%>



		</div>
			
			<hr />
		</div>
	<!-- right column -->
		<div id="rightcolumn" style="float: right;">
		<h3 class="leftbox"><a href="smartmatch.jsp">Smart Match</a></h3>
			  <hr />
           
			  <h3 class="leftbox"><a href="game_play.jsp">Search By Username</a></h3>
			<hr />
			  <h3 class="leftbox"><a href="pending_game_request.jsp">Pending Game Requests</a></h3>
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
