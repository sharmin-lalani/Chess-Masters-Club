
<jsp:include page="check_session.jsp" />
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date"%>

<%@ page import="databasepools.*" %>
<%@ page import="java.sql.*" %>
<%

    String username=(String)session.getAttribute("username");
    c3p0pooledconnection c  = new c3p0pooledconnection() ;
	Connection conn = c.create() ;
	String game_id=request.getParameter("game_id");
	String t_id=request.getParameter("t_id");
	
	HttpSession se=request.getSession(false);
	se.setAttribute("tgame_id",game_id);
	se.setAttribute("t_id",t_id);
	
	String query1="xquery db2-fn:sqlquery(\"select record from db2admin.tournament_games  where game_id = '"+game_id+"'\")/game/whiteplayer/text()";
	String query2="xquery db2-fn:sqlquery(\"select record from db2admin.tournament_games  where game_id = '"+game_id+"'\")/game/blackplayer/text()";
	String query3="xquery db2-fn:sqlquery(\"select record from db2admin.tournament_games  where game_id = '"+game_id+"'\")/game/pgn/text()";
	String query4="select XMLQUERY('$RECORD/game/isend/text()') from tournament_games where game_id = '"+game_id+"'";
	String query5= " select end_date from tournament_games where game_id=? and tournament_id=?";
	PreparedStatement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	String white="",black="",pgn="",isend="";
	boolean is_white=false; 
	boolean is_black=false;
	String ed="";
	boolean allow=true;
	
	try {
		
        stmt1=conn.prepareStatement(query1);
        stmt2=conn.prepareStatement(query2);
        stmt3=conn.prepareStatement(query3);
        stmt4=conn.prepareStatement(query4);
        stmt5=conn.prepareStatement(query5);
        stmt5.setString(1,game_id);
        stmt5.setString(2,t_id);

        			
        		rs1=stmt1.executeQuery();
        		rs2=stmt2.executeQuery();
        		rs3=stmt3.executeQuery();
        		rs4=stmt4.executeQuery();
        		rs5=stmt5.executeQuery();
        		
        		rs3.next();
        		rs4.next();
        	
        						
        		if(!rs1.next() || !rs2.next() )
        		{	
        			
        			response.sendRedirect("status.jsp");	
        		}
        		else
        		{
        			white=rs1.getString(1);
        			black=rs2.getString(1);
        			pgn=rs3.getString(1);
        			isend=rs4.getString(1);
        			
        			
        			is_white=white.equals(username); 
        			is_black=black.equals(username);
						

        			if(!is_white && !is_black)
        			{
        				response.sendRedirect("status.jsp");
        			}
        			if(rs5.next())
        			{
        				ed=rs5.getString(1);
        				Date date_time=new Date();
        	            SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        	             String dt=dnow.format(date_time);
        	             
        	             if(ed.compareTo(dt)<0)
        	             {
        	            	 allow=false;
        	             }
        			}
        		}
        				
        		
		}
		 
		
	catch (Exception exc) {
		// TODO Auto-generated catch block
		exc.printStackTrace();
	}


    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Chess Masters Club</title>
<link href="stylesheets/common.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" media="all" href="stylesheets/blue.css" id="theme_css" />
<script src="javascript/chess.js" type="text/javascript"></script>
<script src="javascript/chess.min.js" type="text/javascript"></script>
<script src="javascript/jquery.min.js"></script>
<script src="javascript/t_game.js"></script>
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
<div id="gameid"  style="visibility:hidden;"><%= game_id %></div>
<div id="pgn"  style="visibility:hidden;"><%= pgn %></div>
<div id="wb"  style="visibility:hidden;">

<% 
if(is_white) out.print("w");
else if(is_black) out.print("b");
%>
</div>
<div id="allow"  style="visibility:hidden;"><%= allow %></div>
	
	<!-- Start Main Content -->
	<div id="main" class="container" >
	 
    
     <!-- left column -->
		<div style="float:left; font-size:14px; margin-right:40px;">
			
			<h2 style="font-size:16px;"> White Player:</h2>
			<div id="whiteplayer" align="center" style=" background-color:#eee;"><%= white %></div>
			<br /><br />
			<h2 style="font-size:16px;">Black Player:</h2>
			<div id="blackplayer" align="center" style=" background-color:#eee;"><%= black %></div>
			<br /><br />
			
			<h2 style="font-size:16px;">Customize Board:</h2>
			<input type="radio" name="theme" checked="checked"    value="blue" onclick="theme(this);" />Blue Theme<br />
			<input type="radio" name="theme" onclick="theme(this);" value="sand" />Sand Theme<br />
			<input type="radio" name="theme"   value="grey" onclick="theme(this);"/>Grey Theme<br />
			<input type="radio" name="theme"  value="green" onclick="theme(this);" />Green Theme<br />
			
			
			<br /><br />
			
			<h2 style="font-size:16px;"> Who's Turn:</h2>
			<div id="turn" align="center" style=" background-color:#eee;font-size:20px;">
			
			
			&#9812;
			</div>
			<br /><br />
			<h2 style="font-size:16px;" >Captures so far:</h2><br />
				
				
				<h3>Captures by Black:</h3>
				<div id="bcapturelist" style=" background-color:#eee;font-size:20px; ">
				</div>
				<br/>
				<h3>Captures by White: </h3>
				<div id="wcapturelist"  style=" background-color:#eee;font-size:20px; ">
             	</div>
		</div>

		<!-- main content area -->
		<div id="center">
		<div class="article_wrapper" style="margin-left:auto; margin-right:auto; margin-bottom:60px; ">
			<div id="status1" align="center" style="color:#900; margin-left:50px;font-weight:bold; font-size:25px;"></div>
			<br />	
<table id="chess_board">
	<tr>
		<td id="a8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b8" onclick="javascript:checkmove(this.id)"><div></div></td>
        <td id="c8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g8" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h8" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g7" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h7" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g6" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h6" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g5" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h5" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g4" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h4" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g3" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h3" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g2" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h2" onclick="javascript:checkmove(this.id)"><div></div></td>
	</tr>
	<tr>
		<td id="a1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="b1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="c1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="d1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="e1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="f1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="g1" onclick="javascript:checkmove(this.id)"><div></div></td>
		<td id="h1" onclick="javascript:checkmove(this.id)"><div></div></td>
		
	</tr>
</table>
<br />
<div id="status" align="center" style="color:#900; margin-left:50px;font-weight:bold; font-size:25px;"></div>
		</div>
		
        </div>
        
        
        <!-- right column -->
		<div style="float:right; font-size:14px; margin-left: 20px;">
		
		<br />
		
		<!-- <input type="checkbox" id="highlight" value="highlight" /> Prompt Moves
		<br />-->
		<br />
		<div id="possible" style="font-size:15px; color:#900; background-color:#eee; " ></div>	
		<br />
		Promote To:
			<select id="promotion" name="promotion">
			<option value='q'>Queen</option>
			<option value='n'>Knight</option>
			<option value='b'>Bishop</option>
			<option value='r'>Rook</option>		
			</select>
			<br />
			<br />
			
			<h3 style="font-size:16px; " >Moves so far:</h3><br />
			<div id="movelist" style="background-color:#eee;">
             </div>
             <br />
             <input id="button" type="button" value="Export to PGN" onclick="cmcpgn();" />
		</div>
        
     </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>