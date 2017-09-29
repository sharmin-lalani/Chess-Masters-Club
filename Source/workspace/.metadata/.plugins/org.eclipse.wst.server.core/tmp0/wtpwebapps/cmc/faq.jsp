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
		<!-- left column (products and features) -->
		<div id="leftcolumn">
			<h3 class="leftbox">F.A.Q.</h3>
			<ul class="leftbox borderedlist">
				<li><a href="#rating">Rating system</a></li>
				<!--li><a href="#mode">Game Modes</a></li-->	
                <li><a href="#tour">Tournaments</a></li>
			</ul>
			<hr />
		</div>
        
		<!-- main content area -->
		<div id="center" style="width:700px;">
			<div class="article_wrapper">

                <a id="rating"></a>
			<h2>Which Rating System is used?</h2>
				<p>
                There are 2 types of rating systems generally used for rating chess games: Elo system and glicko system.
                <br /><br />
                <b>Elo system:</b> <br />
                The idea is this: given two chess players of different strengths, we should be able to calculate the % chance that the better player will win the game. For example, Garry Kasparov has ~100% chance of beating a 4-year-old. But he may only have a ~60% chance of beating another Grandmaster. So when playing that other Grandmaster, if he wins 6 games out of 10, his rating would stay the same. If he won 7 or more, it would go up, and 5 or less, his rating would go down. Basically, the wider the spread of the ratings, the higher percentage of games the higher rated player is expected to win. 
                <br /><br />
                <b>Glicko system:</b> <br />
                 It is a more modern approach that builds on some of the concepts above, but uses a more complicated formula. With the Elo system you have to assume that everyone's rating is just as sure as everyone else's rating. But that is just not true. For example, if this is your first game on our site and you start at 1200, how do we really know what your rating is? We don't. But if I have played 1,000 games on this site, you would be much more sure that my current rating is accurate. So the Glicko system gives everyone not only a rating, but an "RD", called a Rating Deviation. Basically what that number means is "I AM 95% SURE YOUR RATING IS BETWEEN X and Y." If this if your first game on this site I might say, "I am 95% sure that your rating is somewhere between 400 and 2400". Well that is a REALLY big range! And that is represented by a really big RD, or Rating Deviation. If you have played 1,000 games and your rating is currently 1600 I might say "I am 95% sure your rating is between 1550 and 1650". So you would have a low RD. As you play more games, your RD gets lower. Also, the more recent your games, the lower your RD. Your RD gets bigger over time (because maybe you have gotten better or worse over time). Now, how does this affect ratings? Well, if you have a big RD, then your rating can move up and down more drastically because your rating is less accurate.
                 <br /><br />
                 
                 We use the <b>Elo rating system</b> for rating games on our site.
				</p>
                <br />
                
                
                <!--a id="mode"></a>
			<h2>What are the various Game Modes?</h2>
				<p>
                There are 2 game modes: <b>normal/untimed game</b> and <b>fast chess</b>. <br /><br />
                Normal game is untimed, however if a player takes too long to make a move(1 week), then he/she is considered to be forfeiting the game. Fast chess includes a time limit for every move(range: 3 minutes to 24 hours). The player who fails to make the move within the time limit loses the game.
				</p>
                 <br /-->
                
               <a id="tour"></a>
			<h2>Who can take part in a Tournament?</h2>
				<p>A regiestered user who opts for tournaments can take part in online tournaments. The tournament director will announce the start date for a tournament, the last date for registration and the maximum number of players that can take part. A tournament can either be open for all registered players or user rankings maybe used as a cut-off.The tournaments may affect the player ratings. Some tournaments may also have cash prizes.
				</p>
                <br />
				
				<h2>What is the Tournament format?</h2>
				<p>For a small group size, a round robin format is used.Players are placed into groups starting with the highest rated player sequentially down to the lowest rated player. For example, in a 25-player tournament with 5 groups and 5 players in each group, the top rated player goes into Group #1, 2nd highest rated player into Group #2, 3rd highest rated player into Group #3, and so on. After all groups have one player, it starts all over again at Group #1. This is done to try and ensure that in the final round, the best players will be left playing for the tournament win. A knock-out takes place when there are too many players to play a single round Round-Robin. In a knock-out the players are put into smaller groups and then the winner(s) of that group are combined with winners of other groups to form a new group. The winner(s) of the final group are the winner(s) of the entire tournament.If two or more players have the same score at the end of a tournament, all of them are declared as winners. 
				</p>
                
			<br />
			<hr />

				
               
                
         </div>

		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
