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
            
	<%  String admin_id=(String)session.getAttribute("admin_id");
            if(admin_id!=null){
            	
     %>
    <jsp:include page="admin_session.jsp" />
    <!-- top navigation -->
			<ul id="navigation">
				<li class="active"><a href="admin.jsp">Home</a></li>
				<li><a href="manage_users.jsp">Manage Users</a></li>
				<li><a href="manage_tournaments.jsp" >Manage Tournaments</a></li>
				<li><a href="generate_reports.jsp" >Generate Reports</a></li>
				   
			</ul>
    <% }else{ %>
     <jsp:include page="session.jsp" /> 
			<!-- top navigation -->
			<ul id="navigation">
				<li class="active"><a href="index.jsp">Home</a></li>
				<li><a href="game_play.jsp" >Game Play</a></li>
				<li><a href="tutorial.jsp" >Tutorials</a></li>
				<li><a href="tournaments.jsp" >Tournaments</a></li>
				<li><a href="faq.jsp" >FAQs</a></li>   
			</ul>
		<% } %>
            
            
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
		<div id="center">
			<div class="article_wrapper">
			<%
			String username=(String)request.getParameter("username");
			String s_user=(String)session.getAttribute("username");
			if(s_user==null && admin_id==null) 
			{
				 request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			boolean edit=false;
			boolean admin=false;
		
			if(username.equals(s_user)) 
			{
				edit=true;
			}
			c3p0pooledconnection c = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			PreparedStatement ps =null,ps1=null;
			ResultSet rs=null,rs1=null;

			
			try {
		        ps=conn.prepareStatement("select * from user where username=?");
		        		ps.setString(1,username);
		        		rs=ps.executeQuery();
		        ps1=conn.prepareStatement("select admin_id from admin where admin_id=?");
		        		ps1.setString(1,admin_id);
		        		rs1=ps1.executeQuery();
		        		if(rs1.next())
		        		{
		        			
		        			admin=true;
		        		}
		        			
		        		
		        		if(rs.next())
		        		{		
		     
		        			String f=rs.getString("fname");
		        			String l=rs.getString("lname");
		        			String cy=rs.getString("country");
		        			String dob=rs.getString("dob");
		        			String g=rs.getString("gender");
		        			String gp=rs.getString("no_of_games_played");
		        			String gw=rs.getString("no_of_games_won");
		        			String gd=rs.getString("no_of_games_drawn");
		        			String tp=rs.getString("no_of_tour_played");
		        			String tw=rs.getString("no_of_tour_won");
		        			String r=rs.getString("rating");
		        			String d=rs.getString("desc");
		        			
		        			String change=(String)request.getAttribute("edit_success");
		        			if(change!=null)
		        				out.println("All changes were saved.");
		        			%>
		        			<h2><% out.print(username); %></h2>
		        			<table id="signup" cellpadding="15px;" style="height: 550px;">
			<tr>
				<td>First Name</td>
				<td>:</td>
				<td><% out.print(f); %></td>
			</tr>
			
			<tr>
				<td>Last Name</td>
				<td>:</td>
				<td><% out.print(l); %></td>
			</tr>
			
			<tr>
				<td>Country</td>
				<td>:</td>
				<td><% if(cy!=null)out.print(cy); %></td>
			</tr>
			
			<tr>
				<td>Date of birth</td>
				<td>:</td>
				<td><% if(dob!=null)out.print(dob); %></td>
			</tr>
			
			<tr>
				<td>Gender</td>
				<td>:</td>
				<td><% if(g!=null)out.print(g); %></td>
			</tr>
			
			<tr>
				<td>Description</td>
				<td>:</td>
				<td><% if(d!=null)out.print(d); %></td>
			</tr>
			
			<tr>
				<td>No. of games played</td>
				<td>:</td>
				<td><% out.print(gp); %></td>
			</tr>
			
			<tr>
				<td>No. of games won</td>
				<td>:</td>
				<td><% out.print(gw); %></td>
			</tr>
			
			<tr>
				<td>No. of games drawn</td>
				<td>:</td>
				<td><% out.print(gd); %></td>
			</tr>
			
			<tr>
				<td>No. of tournaments played</td>
				<td>:</td>
				<td><% out.print(tp); %></td>
			</tr>
			
			<tr>
				<td>No. of tournaments won</td>
				<td>:</td>
				<td><% out.print(tw); %></td>
			</tr>
			
			<tr>
				<td>Rating</td>
				<td>:</td>
				<td><% out.print(r); %></td>
			</tr>
			
			</table>
		        			
		        			<%
		        			if(edit)
		        			{
		        				%>
		        				<div style="margin-top: 20px;">
		        				<form style="display:inline;" action="edit_profile.jsp" method="get">
		        				<input type="hidden" name="username" value="<% out.print(username); %>" />
		        				<input type="submit" id="button" style="padding:5px 10px; margin-right: 50px;" value="Edit Profile"/>
		        				</form>
		        				<form style="display:inline;" action="change_password.jsp" method="get">
		        				<input type="submit" id="button" style="padding:5px 10px;" value="Change Password"  />
		        				</form>
		        				</div>
		        				<%
		        			}
		        			
		        			else if(admin)
		        			{
		        				%>
		        				<div style="margin-top: 20px;">
		        				<form style="display:inline;" action="DeleteUser" method="get">
		        				<input type="hidden" name="username" value="<% out.print(username); %>" />
		        				<input type="submit" id="button" style="padding:5px 10px; margin-right: 50px;" value="Delete this User"/>
		        				</form>
		        				</div>
		        				
		        			<%}
		        			
		        			else if(!edit && !admin)
		        			{
		        				%>
		        				<div style="margin-top: 20px;">
		        				<form style="display:inline;" action="SendGameRequest" method="get">
		        				<input type="hidden" name="username" value="<% out.print(username); %>" />
		        				<input type="submit" id="button" style="padding:5px 10px;" value="Send Game Request"  />
		        				</form>
		        				</div>
		        				<%	
		        			}
		        		}
		        		else
		        		{
		        		%>
		        		<h2><% out.print("User does not exist"); %></h2>
		        		<%	
		        		}
		        		
				}
				 
				
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
			}
			%>
				

			</div>
			
			<hr />
		</div>
		<%if(!admin) 
		{
		%>
		<!-- right column -->
		<div id="rightcolumn" style="float: right;">
			<h3 class="leftbox"><a href="add_friend.jsp">Add a Friend</a></h3>
			  <hr />
			  <h3 class="leftbox"><a href="friend_list.jsp">My Friend List</a></h3>
			  <hr />
            <h3 class="leftbox"><a href="pending_friend_request.jsp">Pending Friend Requests</a></h3>
			  <hr />
			<h3 class="leftbox"><a href="my_games.jsp">My Games</a></h3>
			<hr />
		</div>
		<%
		}
		%>
		
    </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
