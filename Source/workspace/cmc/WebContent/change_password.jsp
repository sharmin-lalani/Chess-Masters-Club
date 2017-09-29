<jsp:include page="check_session.jsp" />

<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Chess Masters Club</title>
<link href="stylesheets/common.css" rel="stylesheet" type="text/css" />

<script language="javascript">
function check()
{
var pass=document.getElementById("mypassword");
var repass=document.getElementById("repassword");


if(pass.value.length<5)
{
alert("Password should be of atleast 5 characters!");
return false;
}

if(pass.value.length>20)
{
alert("Password should not be more than 20 characters!");
return false;
}

if(pass.value!=repass.value)
{
alert("Enter the same password in both the fields!");
return false;
}
return true;
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
		<div id="center">
			<div class="article_wrapper">
			<%
			String s_user=(String)session.getAttribute("username");

			if((s_user)!=null) 
			{
			%>
			
		     <h2><% out.print(s_user); %></h2>
		     <form action="ResetPassword" method="post" onsubmit="return check();" style="height: 300px; margin-bottom: 220px;">
		        				
		        				
		    <table id="signup" cellpadding="15px;" >
			<tr>
				<td>Current Password</td>
				<td>:</td>
				<td><input type="password" name="cp" /></td>
			</tr>
			
			<tr>
				<td>New Password</td>
				<td>:</td>
				<td><input type="password" name="pass" /></td>
			</tr>
			
			<tr>
				<td>Retype New Password</td>
				<td>:</td>
				<td><input type="password" name="repass" /></td>
			</tr>

			
			</table>
			<input type="hidden" name="username" value="<% out.print(s_user); %>" />
		    <input type="submit" id="button" style="padding:5px 10px; margin-right: 50px; margin-top: 20px;" value="Save changes"/>
		      </form>
		        			
		   <%
		    }
		
			else
			{
				request.getRequestDispatcher("index.jsp").forward(request, response);
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
