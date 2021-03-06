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
				<h2>My Friend List</h2>

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
		        ps=conn.prepareStatement("select friendname from friendship where username=? and status=?");
		        ps.setString(1,user);
		        ps.setString(2,"1");
				rs=ps.executeQuery();
				
				ps2=conn.prepareStatement("select username from friendship where friendname=? and status=?");
		        ps2.setString(1,user);
		        ps2.setString(2,"1");
				rs2=ps2.executeQuery();
				
				Boolean frnd=false;
				
				
    			%>
        		
    			<table id="signup" cellpadding="15px;" style= "margin-bottom: 350px;">
    			<%
		        		while(rs.next())
		        		{		
		     				frnd=true;
		        			String u=rs.getString(1);
		        			%>

			<tr>
				<td>Username</td>
				<td>:</td>
				<td><a href="profile.jsp?username=<% out.print(u); %>"><% out.print(u); %></a></td>
				<td>
				<form action="DeleteFriend" method="get">
				<input type="hidden" name="username" value="<% out.print(u); %>" /> 
				<input type="submit" value="Delete from list" style="background-color:#fff;"/> 
				</form>
				</td>
			</tr>
	
			
  		<%
						}
		        		
		        		while(rs2.next())
		        		{		
		        			frnd=true;
		        			String u=rs2.getString(1);
		        			
		        			%>

			<tr>
				<td>Username</td>
				<td>:</td>
				<td><a href="profile.jsp?username=<% out.print(u); %>"><% out.print(u); %></a></td>
				<td>
				<form action="DeleteFriend" method="get">
				<input type="hidden" name="username" value="<% out.print(u); %>" /> 
				<input type="submit" value="Delete from list" style="background-color:#fff;"/> 
				</form>
				</td>
			</tr>
			
  		<%
						}
		        
				
				if(frnd==false)
				{
					%>

					<tr>
						<td>There are no friends to display right now.</td>
					
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
			<h3 class="leftbox"><a href="add_friend.jsp">Add a Friend</a></h3>
			  <hr />
            <h3 class="leftbox"><a href="pending_friend_request.jsp">View Pending Requests</a></h3>
			  <hr />
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
