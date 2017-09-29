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
		me.value="Request sent";
		
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
				<li ><a href="index.jsp">Home</a></li>
				<li><a href="game_play.jsp" >Game Play</a></li>
				<li><a href="tutorial.jsp" >Tutorials</a></li>
				<li class="active"><a href="tournaments.jsp" >Tournaments</a></li>
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
			<h2 style="padding:0px 0px 0px 80px;">Upcoming Tournaments</h2>	
			<%
			
			c3p0pooledconnection c  = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			response.setContentType("text/html");
			HttpSession se =request.getSession(false);
			String username=(String)se.getAttribute("username");
			Date date_time=new Date();
			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dt=dnow.format(date_time);
			
			
			String query="select * from tournament";
			PreparedStatement ps=conn.prepareStatement(query);
			
			ResultSet rs=ps.executeQuery();
			%>
			<form id="reg" action="Participate" method="get">
			<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
			
			<tr>
			
				<td>Tournament Name</td>
				<td>Start Date</td>
				<td>End Date</td>
				
			</tr>
			<%
			
			rs=ps.executeQuery();
			
			while(rs.next())
			{
				String id=rs.getString(1);
				String name=rs.getString(2);
				String sd=rs.getString(3);
							
				String ed=rs.getString(4);
				//String dt2=dnow.format(ed);
				
				if(sd.compareTo(dt)>0)
				{	
									
			%>
			
			<tr>
				
				<td><a href="tournament.jsp?t_id=<% out.print(id); %>"><% out.print(name); %></a></td>
				<td><% out.print(sd); %></td>
				<td><% out.print(ed); %></td>
				
			
				<div id="t_id"  style="visibility:hidden;"><%= id %></div>
				
							
			</tr>
			
	 	
			<%
				}
			
			}
		
				%>
			
				</table>
				</form>
		
			
			<h2 style="padding:0px 0px 0px 80px;">Ongoing Tournaments</h2>	
			<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
			<tr>
			
				<td>Tournament Name</td>
				<td>Start Date</td>
				<td>End Date</td>
				
			</tr>
			<%
			
			rs=ps.executeQuery();
			
			while(rs.next())
			{
				String id=rs.getString(1);
				String name=rs.getString(2);
				String sd=rs.getString(3);
							
				String ed=rs.getString(4);
				//String dt2=dnow.format(ed);
				
				if(sd.compareTo(dt)<0 && ed.compareTo(dt)>0)
				{	
					
			%>
			<tr>
				
				<td><a href="tournament.jsp?t_id=<% out.print(id); %>"><% out.print(name); %></a></td>
				<td><% out.print(sd); %></td>
				<td><% out.print(ed); %></td>
				
			</tr>
	 	
			<%
				}
			
			}
			
			%>	
			</table>
			
			
			
			<h2 style="padding:0px 0px 0px 80px;">Finished Tournaments</h2>	
			<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
			<tr>
			
			<td>Tournament Name</td>
			<td>Start Date</td>
			<td>End Date</td>
			
		</tr>
		
			<%
			rs=ps.executeQuery();
			while(rs.next())
			{
				String id=rs.getString(1);
				String name=rs.getString(2);
				String sd=rs.getString(3);
							
				String ed=rs.getString(4);
				
								
				if(ed.compareTo(dt)<0)
				{	
					
			%>
			<tr>
				
				<td><a href="tournament.jsp?t_id=<% out.print(id); %>"><% out.print(name); %></a></td>
				<td><% out.print(sd); %></td>
				<td><% out.print(ed); %></td>
			</tr>
	 	
			<%
				}
			
			}
			
			%>
			</table>
			
		   </div>
			
			<hr />
		</div>
	
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
