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
				<li><a href="manage_tournaments.jsp" >Manage Tournaments</a></li>
				<li class="active"><a href="generate_reports.jsp" >Generate Reports</a></li>
				   
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
			<h2>Generate User Reports for games</h2>
	
		<form name="reports" action="GenerateReports" method="get">
			<table id="signup">
			<tr>
				<td>Select the number of days:</td>
				<td><input type="text" id="no" name="no" required="required" /></td>
			</tr>
			<tr>
				<td><input type="submit" id="report" value="Generate Report" /></td>
			</tr>
	
		</table>
		</form>
		
		
		   </div>
			
			<hr />
		</div>
	
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
