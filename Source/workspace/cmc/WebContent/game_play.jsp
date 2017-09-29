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

window.onload=function()
{
	table=document.getElementById("user");
    uname=document.getElementById("uname"); 
}

function getXmlHttpRequestObject() {
	if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		return new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		alert("Your Browser does not support ajax!");
	}
}

//Our XmlHttpRequest object to get the auto suggest
var searchReq = getXmlHttpRequestObject();

//Called from keyup on the search textbox.
//Starts the AJAX request.
function getlist() 
{
	if(uname.value.length<1)
	{
		//alert(uname.value.length);
		table.innerHTML="";
		return;
	}
	
	
	
	
	if (searchReq.readyState == 4 || searchReq.readyState == 0) 
	{
		searchReq.open("GET","Game_userlist?value="+uname.value,true);
		
		searchReq.onreadystatechange = addlist; 
		searchReq.send(null);
	}		
}



function addlist()
{
	if (searchReq.readyState == 4 && searchReq.status==200)
{
	var str =searchReq.responseText.split("\n");

	
	table.innerHTML="";
	for(i=0; i < str.length-1; i++) {
		//Build our element string. 
		/*var suggest = "<tr><td>" + "<a href=profile.jsp?username="+str[i]+">"+str[i] + "</a></td><td><a href=\"start_game.jsp?username="+str[i]+"\">&nbsp;&nbsp;&nbsp;Start a Game</a></td></tr>";
		table.innerHTML += suggest;*/
		var suggest = "<tr><td>" + "<a href=profile.jsp?username="+str[i]+">"+str[i] + "</a>&nbsp;&nbsp;&nbsp;</td>"+
		"<td><form method=\"get\" action=\"SendGameRequest\" >"+
		"<input type=\"hidden\" name=\"username\" value="+str[i]+" />"+
		"<input type=\"submit\" value=\"Start Game\" /></form></td></tr>";
		table.innerHTML += suggest;
	}
	if(str.length==1)
	table.innerHTML = "<tr><td>There are no results to display.</td></tr>";
}
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
				<li class="active"><a href="game_play.jsp" >Game Play</a></li>
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
			<div class="article_wrapper"  style="min-height: 550px;" >
				<h2>Search By Username</h2>
				
				<table style="font-size: 14px;">
				<tr>
				<td>Search by Username &nbsp;&nbsp;&nbsp;</td>
				<td><input id="uname" type="text" onkeyup="getlist()" autocomplete="off"/>&nbsp;&nbsp;&nbsp;</td>
				<td><input type="button" value="Search" id="button" onclick="getlist()"/></td>
				</tr>
				</table>
				<br />
				
				<table id="user" style="font-size: 14px;">
				</table>




		</div>
			
			<hr />
		</div>
	<!-- right column -->
		<div id="rightcolumn" style="float: right;">
		<h3 class="leftbox"><a href="smartmatch.jsp">Smart Match</a></h3>
			  <hr />
            <h3 class="leftbox"><a href="friend_game_req.jsp">Play With a Friend</a></h3>
			  <hr />
			 <h3 class="leftbox"><a href="pending_game_request.jsp">Pending Game Requests</a></h3>
			<hr />
			   <h3 class="leftbox"><a href="my_games.jsp">My Games</a></h3>
			<hr />
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
