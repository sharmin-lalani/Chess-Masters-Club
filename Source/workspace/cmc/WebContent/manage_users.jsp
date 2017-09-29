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
            
	
    <jsp:include page="admin_session.jsp" />
			<!-- top navigation -->
			<ul id="navigation">
				<li><a href="admin.jsp">Home</a></li>
				<li  class="active"><a href="manage_users.jsp">Manage Users</a></li>
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
	
	<!-- Start Main Content -->
	<div id="main" class="container">
		<!-- left column -->
		<!--<div id="leftcolumn">
			<h3 class="leftbox"></h3>
			
		</div>-->
		<!-- main content area -->
		<div id="center">
			<div class="article_wrapper">
				<% 
			c3p0pooledconnection c = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			PreparedStatement ps =null;
			ResultSet rs=null;

			
			try {
				 ps=conn.prepareStatement("select fname,lname,username from user");
			     rs=ps.executeQuery();
	%>
			     
			    <h2 style="margin-right: 300px">Users</h2>
		   		<table id="signup" cellpadding="15px;" style= "margin-bottom: 300px;">
		   		<tr>
		   			<td>Username</td>
		   			<td>First Name</td>
		   			<td>Last Name</td>
		   		</tr>
		   			
		   			
		   			<%
				        		
		   			while(rs.next())
				        {		
				    		String f=rs.getString(1);
				    		String l=rs.getString(2);
				    		String u=rs.getString(3);
				    		
				        			
				       %>

					<tr>
						<td><a href="profile.jsp?username=<% out.print(u); %>"><% out.print(u); %></a></td>
						<td><% out.print(f); %></td>
						<td><% out.print(l); %></td>
						<td><form action="DeleteUser" method="get">
							<input type="hidden" name="username" value="<% out.print(u); %>" /> 
							<input type="submit" value="Delete User" style="background-color:#fff;"/> 
							</form>
						</td>
					</tr>
					<%  }//while
		   			  }//try
						catch (Exception exc) 
		   			  {
							// TODO Auto-generated catch block
							exc.printStackTrace();
						}
					%>
					
				
				</table>
				
			</div>
			
			<hr />
		</div>
	<!-- right column 
		<div id="rightcolumn" >
			<h3 class="leftbox"></h3>
			
             <h3 class="leftbox"></h3>
			
		</div>-->
      </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
