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
function check()
{
	var num= document.getElementById("num");
	if(num.value<2)
		{
		alert("There has to be atleast 2 groups.");
		return false;
		}
	else return true;
}


</script>

</head>
<body>

	<!-- Start Header -->
	<div id="header">
    
		<div class="container">
            
	
    <jsp:include page="admin_session.jsp" />
			<!-- top navigation -->
			<ul id="navigation">
				<li ><a href="admin.jsp">Home</a></li>
				<li><a href="manage_users.jsp">Manage Users</a></li>
				<li class="active"><a href="manage_tournaments.jsp" >Manage Tournaments</a></li>
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

		<!-- main content area -->
		<div id="center" >
			<div class="article_wrapper"  style="min-height: 550px;" >
	
			<%
			
			c3p0pooledconnection c  = new c3p0pooledconnection() ;
			Connection conn = c.create() ;
			response.setContentType("text/html");
			HttpSession se =request.getSession(false);
			String username=(String)se.getAttribute("username");
			Date date_time=new Date();
			SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dt=dnow.format(date_time);
			
			String t_id=request.getParameter("t_id");
			String query="select * from tournament_req,tournament,user where tournament.tournament_id=? and tournament.tournament_id=tournament_req.t_id  and tournament_req.username=user.username";
			try
			{
			PreparedStatement ps=conn.prepareStatement(query);
			ps.setString(1,t_id);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{	
				int counter=0;
				rs=ps.executeQuery();
			%>
			<h2>Entries for tournament</h2>
			
			<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
			<tr>
				<td>Serial No</td>
				<td>Username</td>
				<td>Rating</td>
			</tr>
			<%
			
			while(rs.next())
			{
				counter++;
				String id=rs.getString("req_id");
				String name=rs.getString("username");
				String rating=rs.getString("rating");
					
			%>
			
			<tr>
				<td><%out.print(counter); %></td>
				<td><a href="profile.jsp?username=<% out.print(name); %>"><% out.print(name); %></a></td>
				<td><%out.print(rating); %></td>
				<div id="t_id"  style="visibility:hidden;"><%= id %></div>
				<%
				}
			
			}
			else
			{%>
				<p>There are no entries for this tournament yet.</p>
		<%	}
			}
				catch (Exception exc) {
					// TODO Auto-generated catch block
					exc.printStackTrace();
					//out.println("hi");
				}
				%>
							
			</tr>
	
		</table>
		<%
			String query2="select * from groups where tournament_id=?";
			String query3="select count(username) from tournament_req where t_id=? ";
			try
			{
				//System.out.println("1");
				PreparedStatement p3=conn.prepareStatement(query3);
				p3.setString(1,t_id);
				ResultSet rs3=p3.executeQuery();
				//System.out.println("2");
				PreparedStatement p2=conn.prepareStatement(query2);
				p2.setString(1,t_id);
				ResultSet rs2=p2.executeQuery();
				rs3.next();
				int count=rs3.getInt(1);
				//System.out.println("3");
				if(count>3)
				{
					//System.out.println("4");
				if(!rs2.next())
				{
					//System.out.println("5");
		%>
		<form name="divide"  action="MakeGroups" method="post" onsubmit="return check();">
		<table id="signup">
		<tr>
			<td>No of Groups</td>
			<td>:</td>
			<td><input type="text" id="num" name="num" /></td>
		</tr>
		<tr>
			<td>End date</td>
			<td>:</td>
			<td>
				<input type="text" size="4" name="ed1" pattern=[0-9]{4} placeholder="YYYY" required="required" />-
				<input type="text" size="2" name="ed2" pattern=[0-9]* placeholder="MM" required="required"/>-
				<input type="text" size="2" name="ed3" pattern=[0-9]* placeholder="DD" required="required"/>
			</td>
		</tr>
		<tr>
			<td>Round</td>
			<td>:</td>
			<td><input type="text" name="round" /></td>
		</tr>
		</table>
	
			<input type="submit" id="button" value="Divide into groups" />
			<input type="hidden" name="t_id" value="<%= t_id%>"/>
		</form>
				
		<%
			}
			else
			{
				//System.out.println("6");
				String s1="select end_date from tournament_games where tournament_id=? and round='1'";
				PreparedStatement p1=conn.prepareStatement(s1);
				p1.setString(1,t_id);
				
				ResultSet r1=p1.executeQuery();
				r1.next();
				String ed=r1.getString(1);
				if(ed.compareTo(dt)<0)
				{
					//System.out.println("7");
					
					
					
				%>	
				<h2>Results for Round 1</h2>
					<table id="signup" cellpadding="15px;" style= "margin-bottom: 70px;">
				<tr>
					<td>Group</td>
					<td>Winner</td>
				</tr>
					
				<%
					int wcount=0;
					
					ResultSet r2=p2.executeQuery();
					//System.out.println("8");
					while(r2.next())
					{
						//System.out.println("9");
						String g=r2.getString("group_id");
						String s3="select leading_player from groups where group_id='"+g+"'";
						PreparedStatement stmt3=conn.prepareStatement(s3);
						
						//System.out.println(g);
						ResultSet r3=stmt3.executeQuery();
					
						r3.next();
						String winner=r3.getString(1);
						wcount++;
						//System.out.println(winner);
					%>
						<tr>
						<td><% out.print(wcount); %></td>
						<td><% out.print(winner); %></td>
						</tr>
						
					<%	
					}
					%>	
					</table>
					
					<%
					String s4="select * from tournament_games where tournament_id=? and round='2'";
					
					String s5="select winner from winners where tournament_id='"+t_id+"'";
					String st1="select end_date from tournament where tournament_id=?";
					
					PreparedStatement p4=conn.prepareStatement(s4);
					p4.setString(1, t_id);
					ResultSet r4=p4.executeQuery();
					//System.out.println("10");
					PreparedStatement p5=conn.prepareStatement(s5);
					//p5.setString(1, t_id);
					ResultSet r5=p5.executeQuery();
					//System.out.println(s5);
					if(!r4.next())
					{
						//System.out.println("11");
					%>
					
					<form action="SecondRound" method="post">
					<input type="hidden" name="t_id" value="<%= t_id%>"/>
					<input type="hidden" name="round" value="<%= 2%>"/>
					<input type="submit" id="button" value="Start Round 2" />
					</form>
					
					<%
					}
					else
					{
						
						PreparedStatement pt1=conn.prepareStatement(st1);
						pt1.setString(1, t_id);
						ResultSet rt1=pt1.executeQuery();
						
						rt1.next();
						
						String ted=rt1.getString(1);
						//System.out.println(ted);
						//System.out.println("27");
						String ed1=r4.getString("end_date");
						
						String winner="";
						if(r5.next())
						//System.out.println("28");
							 winner=r5.getString("winner");
						//System.out.println("winner"+winner);
						if(ted.compareTo(dt)<0)
						{
							//System.out.println("winner="+winner);
							if(winner=="")
							{
								//System.out.println("13");
				
					%>
					
					<form action="DeclareWinner" method="post">
						<input type="hidden" name="t_id" value="<%= t_id%>"/>
						<input type="hidden" name="round" value="<%= 2%>"/>
						<input type="submit" id="button" value="Declare Winner" />
					</form>
					<%
							}
							else
							{
								//System.out.println("14");
								r5=p5.executeQuery();
								%>
								<h2>Winner</h2>
								<%
								
								while(r5.next())
								{
								%>
								
								<p><a href="profile.jsp?username="<%= winner %>><%= winner %></a></p>
								
								<%
								}
								
							}
							
						}
							else
							{
								//System.out.println("15");
							%>
							<p>Round 2 ongoing.</p>
							
							<%
							}
						}
							
						
					}
				
			
				
			}
		}
				else {
		%>  
		<p>There have to be atleast four tournament requests to make group.</p>
					<form action="DeleteTournament" method="post">
						<input type="hidden" name="t_id" value="<%= t_id%>"/>
						<input type="submit" id="button" value="Delete Tournament" />
					</form>
		
		<%
				}
			
			
			}
			catch (Exception exc) {
				// TODO Auto-generated catch block
				exc.printStackTrace();
				//out.println("hi");
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
