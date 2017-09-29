<jsp:include page="check_session.jsp" />
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
		<div id="center">
			<div class="article_wrapper">
			<div id="main" align="center" >
	
					<p>*Required Fields</p>
	<center>
	
	<form name="create_tournament" action="CreateTournament" method="post" onsubmit="return check();">
		<table id="signup" cellpadding="15px;">
			<tr>
				<td>Name*</td>
				<td>:</td>
				<td><input type="text" name="name" id="name" required="required" autocomplete="off" /></td>
				
			</tr>
			<tr>
				<td>Start Date*</td>
				<td>:</td>
				<td>
				<input type="text" size="4" name="sd1" pattern=[0-9]{4} placeholder="YYYY"required="required"/>-
				<input type="text" size="2" name="sd2" pattern=[0-9]* placeholder="MM" required="required"/>-
				<input type="text" size="2" name="sd3" pattern=[0-9]* placeholder="DD" required="required"/>
				</td>
			</tr>
			<tr>
				<td>End Date*</td>
				<td>:</td>
				<td>
				<input type="text" size="4" name="ed1" pattern=[0-9]{4} placeholder="YYYY" required="required" />-
				<input type="text" size="2" name="ed2" pattern=[0-9]* placeholder="MM" required="required"/>-
				<input type="text" size="2" name="ed3" pattern=[0-9]* placeholder="DD" required="required"/>
				</td>
			</tr>
			<tr>
				<td>Maximum no of players*</td>
				<td>:</td>
				<td><input type="text" name="max" id="max" required="required" /></td>
			</tr>
			<tr>
				<td>Cash Prize</td>
				<td>:</td>
				<td><input type="text" name="cp" id="cp" /></td>
			</tr>
		
		</table>
		
		<div>
			<input type="submit" id="button" name="submit" style="padding:5px 10px;" value="Create"  />
		</div>
		</form>
</center>
</div>

			</div>
			
			<hr />
		</div>
	
		
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
