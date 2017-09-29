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
<script language="javascript">


function sendreq(me)
{
		me.onclick="";
		me.value="request sent";
		
		t_id1=document.getElementById("t_id");
		t_id=t_id1.innerHTML;
		document.location.href = "Participate?t_id="+t_id; 
		
}

</script>

</head>
<body>

	<!-- Start Header -->
	<div id="header">
    
		<div class="container">
            
	
    <jsp:include page="session.jsp" />
			<!-- top navigation -->
			<ul id="navigation">
				<li><a href="index.jsp">Home</a></li>
				<li><a href="game_play.jsp" >Game Play</a></li>
				<li><a href="tutorial.jsp" >Tutorials</a></li>
				<li  class="active"><a href="tournaments.jsp" >Tournaments</a></li>
				<li><a href="faq.jsp" >FAQs</a></li>   
			</ul>
            
            
			<!-- banner message and building background -->
			<div id="banner">
				<p>
                An Online Chess Club where game lovers can learn and play Chess games by different means like Chess tutorial, puzzle, 		game with computer or other player. 
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
				<%
			
			c3p0pooledconnection c  = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			response.setContentType("text/html");
			HttpSession se =request.getSession(false);
			 
			String username=(String)se.getAttribute("username");
	          if(username==null)
	            {
	            	request.setAttribute("message", "You must be logged in to view this page");
	            	request.getRequestDispatcher("status.jsp").forward(request, response);	
	            }
			
			String t_id=request.getParameter("t_id");
			Date date_time=new Date();
			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dt=dnow.format(date_time);
			
			String query="select * from tournament where tournament_id="+t_id;
			
			
			
			try{
				
			PreparedStatement ps=conn.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			
			
		
			
			
			
			while(rs.next())
			{
				
				String name=rs.getString(2);
				String sd=rs.getString(3);
				String ed=rs.getString(4);
				String max=rs.getString(5);
			
				String cp=rs.getString(6);
				
				
				
				%>
				
				
				
			<h2><%out.print(name); %></h2>
			<div id="tour" style="font-size: 11px">
				<p>Start date : <%out.print(sd); %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; End date : <%out.print(ed); %></p>
				
				<p>Maximum no of players : <%out.print(max); %></p>
				
			
				
			<%
			if(cp!=null)
			{
			%>	
				<p>Cash prize: Rs.<%out.print(cp); %></p>
			<%
			
			
			}
			%>	
				<p>Members are:</p></br>
				
				
				
			</div>	 	
			<div id="t_id"  style="visibility:hidden;"><%= t_id %></div>
			<form id="reg" action="Participate" method="get">
			<input type="hidden" name="t_id" value=<%out.print(t_id); %> />
			
	
			<%
			String q1="select * from tournament_req where t_id=? and username=?";
			String query2="select group_id from groups where tournament_id=?";
			String query4="select member from group_members where group_id=?";	
			
			try
				{
				
					PreparedStatement ps2=conn.prepareStatement(query2);
					ps2.setString(1,t_id);
					ResultSet rs2=ps2.executeQuery();
					
					PreparedStatement ps1=conn.prepareStatement(q1);
					ps1.setString(1,t_id);
					ps1.setString(2,username);
					ResultSet rs1=ps1.executeQuery();
					while(rs2.next())
					{
						
					String gid=rs2.getString("group_id");
					
					PreparedStatement ps4=conn.prepareStatement(query4);
					
					ps4.setString(1,gid);
					
					%>
					<table id="signup">
						<tr>
						<td>Group ID</td>
						<td>Members</td>
						</tr>
					<%
					ResultSet rs4=ps4.executeQuery();
					while(rs4.next())
					{
						
						String mem=rs4.getString("member");
						%>
						<tr>
						<td><%=gid %></td>
						<td><a href="profile.jsp?username=<%= mem %>" ><%= mem %></a></td>
						</tr>
					<%
					}
					}
					%>
					</table>
				<%	
				if(!rs1.next())
				{
					if(sd.compareTo(dt)>0)
					{
						
					%>
						<input type="submit" id="button" value="Register"  onclick="sendreq(this);"/>
					<%	
					
						
					}
					if(sd.compareTo(dt)<0 && ed.compareTo(dt)>0)
					{
						%>
						<p>The tournament has already started.</p>
					<%
					}
					if(sd.compareTo(dt)<0 && ed.compareTo(dt)<0)
					{
						%>
							<p>The tournament has already ended.</p>
						<%
					}
				}
				else
				{
				%>
				<p>The request has been sent.Thank you!!</p>
				<%
				}
				
				
				
				String s5="select winner from winners where tournament_id='"+t_id+"'";
				PreparedStatement p5=conn.prepareStatement(s5);
				
				
				ResultSet r5=p5.executeQuery();
				while(r5.next())
				{
				
				%>
				<h2>Winner</h2>
				<%
				
				
					String winner=r5.getString("winner");
				%>
				
				<p><a href="profile.jsp?username="<%= winner %>><%= winner %></a></p>
				
				<%
				}
				
				
				}
				catch (Exception exc) {
					// TODO Auto-generated catch block
					exc.printStackTrace();
					
				}
				%>			
			
			</form>
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
	
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
