
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="databasepools.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
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

<%
Date date_time=new Date();
SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd");
String dt=dnow.format(date_time);

Calendar now = Calendar.getInstance();
now.add(Calendar.MINUTE, -30);
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String n=df.format(now.getTime());

String username=(String)session.getAttribute("username");
String query="select * from tournament where start_date>'"+dt+"'";
String query1="select username,rating from user order by rating desc limit 8";
String query2="select f.friendname from friendship as f inner join user as u on f.friendname=u.username "
				+"where f.username='"+username+"' and f.status='1' and u.is_loggedin='1' and u.last_request_timestamp>'"+n+"'"
				+"union "
				+"select f.username from friendship as f inner join user as u on f.username=u.username "
				+"where f.friendname='"+username+"' and f.status='1' and u.is_loggedin='1' and u.last_request_timestamp>'"+n+"'";
c3p0pooledconnection c = new c3p0pooledconnection() ;
Connection conn = c.create() ;
PreparedStatement ps=null;
ResultSet rs=null;
%>


	<!-- Start Main Content -->
	<div id="main" class="container">
		<!-- left column -->
		<div id="leftcolumn">
			<h3 class="leftbox">Online Friends</h3>
			<ul class="leftbox borderedlist">
			 <%
			 
			  ps=conn.prepareStatement(query2);
			 // ps.setString(1, username);
			 // ps.setString(2, username);
			  rs=ps.executeQuery();
			  //System.out.println(query2);
			  int flag=0;
		while(rs.next())
		{
			
			String friend=rs.getString(1);
			flag=1;
			 %>
				<li><a href="profile.jsp?username=<%= friend %>" ><%= friend %></a></li>
				<%
		}
		if(flag==0)
		{
			 %>
				<li>No online friends found.</li>
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
Observation and Analysis-

Chess has the unique ability of teaching the player to become aware of details 
and the nuances of every position. The player learns to observe the whole 
board and recognize both the important and unimportant aspects of the position 
</p>

<p>
 
Chess is a marvelous game. It teaches skills that can help in various facets of life.
</p>

<p>
We learn by chess the habit of not being discouraged by present bad appearances in the state of our affairs, the habit of hoping for a favorable change, and that of persevering in search of resources. - Benjamin Franklin
</p>

<p>

So have fun with chess and persevere to be a great chess player, for

"Every Chess master was once a beginner."  -  Irving Chernev
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
		flag=0;
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
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
