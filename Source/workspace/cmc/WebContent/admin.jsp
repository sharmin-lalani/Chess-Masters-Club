<%@ page import="java.sql.*" %>
<%@ page import="databasepools.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>

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
            
	
    <jsp:include page="admin_session.jsp" />
			<!-- top navigation -->
			<ul id="navigation">
				<li class="active"><a href="admin.jsp">Home</a></li>
				<li><a href="manage_users.jsp">Manage Users</a></li>
				<li><a href="manage_tournaments.jsp" >Manage Tournaments</a></li>
				<li><a href="generate_reports.jsp" >Generate Reports</a></li>
				   
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

<%
Date date_time=new Date();
SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd");
String dt=dnow.format(date_time);
String query="select * from tournament where start_date>'"+dt+"'";
String query1="select username,rating from user order by rating desc limit 8";
c3p0pooledconnection c = new c3p0pooledconnection() ;
Connection conn = c.create() ;
PreparedStatement ps=null;
ResultSet rs=null;
%>


	<!-- Start Main Content -->
	<div id="main" class="container">
		<!-- left column -->
		<div id="leftcolumn">
			<h3 class="leftbox">Top Players</h3>
			<ul class="leftbox borderedlist">
			  <%
			  ps=conn.prepareStatement(query1);
		      rs=ps.executeQuery();
		while(rs.next())
		{
			String player=rs.getString(1);
			String rating=rs.getString(2);
			  %>
			  
				<li style="margin-bottom: 15px; font-size: 12px;">
				<a href="profile.jsp?username=<%= player %>" style="color : #000; font-size: 15px;"><%= player %></a>
				Rating : <%= rating %>
				</li>
				
				<%
		}
				%>
              </ul>
			  <hr />
		</div>
		<!-- main content area -->
		<div id="center">
			<div class="article_wrapper">
				<h2>Chess is the Gymnasium of the Mind</h2>
				<p>

Chess is variously described as a science, an art and a sport. It has the virtue of being completely free of the element of luck: the result of each game depends entirely upon the skill of the players. 
</p>

<p>
Chess helps develop critical thinking; logic, reasoning and problem solving abilities; memory, concentration and visualization skills; confidence; patience; determination and good sportsmanship. </p>

<p>
Memory Improvement-

The nature of the game is such that the visual aspects of the game (positional 
configurations, anticipated piece movements, diagonals, ranks, files, etc.) 
make deep impressions on that area of the mind which is responsible for 
memory. It should also be noted that recall is 
also improved. Chess is definitely an 
excellent memory exerciser the effects of which are transferable to other 
subjects where memory is necessary. 
</p>

<p>
Logic- 

The kind of logic 
employed in chess is based largely upon the rule schema, but not entirely. 
Player "A" may choose a move not because it is most logical, 
but because he believes that player "B" will not see the reason behind it. 
Many chess players have asserted that chess either 
sharpened or created a unique sense of logic which they have applied to 
other aspects of life successfully. 
</p>

<p>
 
Chess is a marvelous game. It teaches skills that can help in various facets of life.
</p>




			</div>
			
			<hr />
		</div>
	<!-- right column -->
		<div id="rightcolumn" >
			<h3 class="leftbox">Upcoming Tournaments</h3>
			<ul class="leftbox borderedlist">
			<%
			  ps=conn.prepareStatement(query);
		      rs=ps.executeQuery();
		int flag=0;
		while(rs.next())
		{
			flag=1;
			String id=rs.getString(1);
			String name=rs.getString(2);
			String sd=rs.getString(3);				
			String ed=rs.getString(4);
			  %>
				<li style="margin-bottom: 15px; font-size: 12px;">
				<a href="tournament.jsp?t_id=<% out.print(id); %>" style="color : #000; font-size: 15px;"><% out.print(name); %></a>
				Start Date : <% out.print(sd); %><br />
				End Date : <% out.print(ed); %>
				</li>
				<%
		}
				if(flag==0)
		{
			 %>
				<li>There are no upcoming Tournaments.</li>
				<%
		}
				%>
           </ul>
			  <hr />
              
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
