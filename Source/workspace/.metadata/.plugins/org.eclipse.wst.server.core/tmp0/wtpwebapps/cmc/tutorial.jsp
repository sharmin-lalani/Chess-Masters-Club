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
			<h3 class="leftbox">Tutorials</h3>
			<ul class="leftbox borderedlist">
				<li><a href="#history">History of Chess</a></li>
				<li><a href="#start">Starting a Game</a></li>
				<li><a href="#howtomove">How the pieces move</a></li>
				<li><a href="#special">Special Moves</a></li>
				<li><a href="#checkmate">Check and Checkmate</a></li>
				<li><a href="#draws">Draws and Repetition</a></li>
                <li><a href="#strategies">Basic Strategies and Openings</a></li>
				<li><a href="#getbetter">Getting Better at Chess</a></li>
				
			</ul>
			<hr />
		</div>
		<!-- main content area -->
		<div id="center" style="width:700px;">
			<div class="article_wrapper">
			<a name="history" id="history"></a>
			<h2>History of Chess</h2>
				<p>The origins of chess are not exactly clear, though most believe it evolved from earlier chess-like games played in India almost two thousand years ago.
					The game of chess we know today has been around since the 15th century where it became popular in Europe.
				</p>
				
				<h2>The Goal of Chess</h2>
				<p>Chess is a game played between two opponents on opposite sides of a board containing 64 squares of alternating colors. Each player has 16 pieces: 1 king, 1 queen, 2 rooks, 2 bishops, 2 knights, and 8 pawns. The goal of the game is to checkmate the other king. 
					Checkmate happens when the king is in a position to be captured (in check) and cannot escape from capture.
				</p>
			
			<hr />
				<a name="start" id="start"></a>
				<h2>Starting a Game</h2>
				<p>At the beginning of the game the chessboard is laid out so that each player has the white (or light) color square in the bottom right-hand side. The chess pieces are then arranged the same way each time. The second row (or rank) is filled with pawns. The rooks go in the corners, then the knights next to them, followed by the bishops, and finally the queen, who always goes on her own matching color (white queen on white, black queen on black), and the king on the remaining square. </p>
				<p>The player with the white pieces always moves first. Therefore, players generally decide who will get to be white by chance or luck such as flipping a coin or having one player guess the color of the hidden pawn in the other player's hand. White then makes a move, followed by black, then white again, then black and so on until the end of the game. </p>
				<p><a name="howtomove" id="howtomove"></a></p>
				<h2 class="module-title">How the Pieces Move</h2>
				<p>Each of the 6 different kinds of pieces moves differently. Pieces cannot move through other pieces (though the knight can jump over other pieces), and can never move onto a square with one of their own pieces. However, they can be moved to take the place of an opponent's piece which is then captured. Pieces are generally moved into positions where they can capture other pieces (by landing on their square and then replacing them), defend their own pieces in case of capture, or control important squares in the game. </p>
				<p><b>The King</b> <br /> <img src="images/king.jpg" height=100px width=80px /></p>
				<p>The king is the most important piece, but is one of the weakest. The king can only move one square in any direction - up, down, to the sides, and diagonally. The king may never move himself into check (where he could be captured).</p>
				<p><b>The Queen</b> <br /> <img src="images/queen.jpg" height=100px width=80px /></p>
				<p>The queen is the most powerful piece. She can move in any one straight direction - forward, backward, sideways, or diagonally - as far as possible as long as she does not move through any of her own pieces. And, like with all pieces, if the queen captures an opponent&#39;s piece her move is over. Click through the diagram below to see how the queens move. Notice how the white queen captures the black queen and then the black king is forced to move.</p>
				<p><b>The Rook</b> <br /> <img src="images/rook.jpg" height=100px width=80px /></p>
				<p>The rook may move as far as it wants, but only forward, backward, and to the sides. The rooks are particularly powerful pieces when they are protecting each other and working together!</p>
				<p><b>The Bishop</b> <br /> <img src="images/bishop.jpg" height=100px width=80px /></p>
				<p>The bishop may move as far as it wants, but only diagonally. Each bishop starts on one color (light or dark) and must always stay on that color. Bishops work well together because they cover up each other&rsquo;s weaknesses.</p>
				<p><b>The Knight</b> <br /> <img src="images/knight.jpg" height=100px width=80px /></p>
				<p>Knights move in a very different way from the other pieces &ndash; going two squares in one direction, and then one more move at a 90 degree angle, just like the shape of an &ldquo;L&rdquo;. Knights are also the only pieces that can move over other pieces.</p>
				<p><b>The Pawn</b> <br /> <img src="images/pawn.jpg" height=100px width=80px /></p>
				<p>Pawns are unusual because they move and capture in different ways: they move forward, but capture diagonally. Pawns can only move forward one square at a time, except for their very first move where they can move forward two squares. Pawns can only capture one square diagonally in front of them. They can never move or capture backwards. If there is another piece directly in front of a pawn he cannot move past or capture that piece.</p>
				<a name="special" id="special"></a>
				<h2>Promotion</h2>
				<p>Pawns have another special ability and that is that if a pawn reaches the other side of the board it can become any other chess piece (called promotion). A pawn may be promoted to any piece. [NOTE: A common misconception is that pawns may only be exchanged for a piece that has been captured. That is NOT true.] A pawn is usually promoted to a queen. Only pawns may be promoted.</p>
				<h2>En Passant</h2> <br /> <img src="images/enpassant.jpg" height=200px width=200px />
				<p>The last rule about pawns is called &ldquo;en passant,&rdquo; which is French for &ldquo;in passing&rdquo;. If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent&rsquo;s pawn (effectively jumping past the other pawn&rsquo;s ability to capture it), that other pawn has the option of capturing the first pawn as it passes by. This special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available. Click through the example below to better understand this odd, but important rule.</p>
				<h2>Castling</h2> <br /> <img src="images/castling.gif" height=200px width=200px />
				<p>One other special rule is called castling. This move allows you to do two important things all in one move: get your king to safety (hopefully), and get your rook out of the corner and into the game. On a player&rsquo;s turn he may move his king two squares over to one side and then move the rook from that side&rsquo;s corner to right next to the king on the opposite side. (See the example below.) However, in order to castle, the following conditions must be met: </p>
					<ol type="a" style="font-size:12px;list-style-type:disc;">
						<li>It must be that king&rsquo;s very first move</li>
						<li>It must be that rook&rsquo;s very first move</li>
						<li>There cannot be any pieces between the king and rook to move</li>
						<li>The king may not be in check or pass through check</li>
					</ol>
				<p>Notice that when you castle one direction the king is closer to the side of the board. That is called castling <span><b>kingside</b></span>. Castling to the other side, through where the queen sat, is called castling <span><b>queenside</b></span>. Regardless of which side, the king always moves only two squares when castling. </p>
				<a name="checkmate" id="checkmate"></a>
				<h2>Check &amp; Checkmate</h2>
				<p>As stated before, the purpose of the game is to checkmate the opponent&rsquo;s king. This happens when the king is put into check and cannot get out of check. There are only three ways a king can get out of check: move out of the way (though he cannot castle!), block the check with another piece, or capture the piece threatening the king. If a king cannot escape checkmate then the game is over. Customarily the king is not captured or removed from the board, the game is simply declared over.</p>
				<a name="draws" id="draws"></a>
				<h2>Draws</h2>
				<p>Occasionally chess games do not end with a winner, but with a draw.There are 5 reasons why a chess game may end in a draw:</p>
					<ul style="font-size:12px;list-style-type:disc;">
						<li>The position reaches a stalemate where it is one player&rsquo;s turn to move, but his king is NOT in check and yet he does not have another legal move</li>
						<li>The players may simply agree to a draw and stop playing</li>
						<li>There are not enough pieces on the board to force a checkmate (example: a king and a bishop vs.a king)</li>
						<li>A player declares a draw if the same exact position is repeated three times (though not necessarily three times in a row)</li>
						<li>Fifty consecutive moves have been played where neither player has moved a pawn or captured a piece.</li>
					</ul>
				<a name="strategies" id="strategies"></a>
				<h2> Basic Strategy  </h2>
				<p>
				There are four simple things that every chess player should know:
				</p>
				<p><b> #1 Protect your king </b> </p>
				<p>
				Get your king to the corner of the board where he is usually safer.
				Don&rsquo;t put off castling.
				You should usually castle as quickly as possible.
				Remember, it doesn&rsquo;t matter how close you are to checkmating your opponent if your own king is checkmated first!
				</p>
				<p><b>#2 Don&rsquo;t give pieces away </b> </p>
				<p>
				Don&rsquo;t carelessly lose your pieces!
				Each piece is valuable and you can&rsquo;t win a game without pieces to checkmate.
				There is an easy system that most players use to keep track of the relative value of each chess piece:
				</p>
				<ul style="font-size:12px;list-style-type:disc;">
						<li>A Pawn is worth 1</li>
						<li>A Bishop is worth 3</li>
						<li>A Knight is worth 3</li>
						<li>A Rook is worth 5</li>
						<li>The Queen is worth 9</li>
						<li>The King is infinitely valuable</li>
				</ul>
				<p><b>#3 Control the center </b> </p>
				<p>
				You should try and control the center of the board with your pieces and pawns.
				If you control the center, you will have more room to move your pieces and will make it harder for your opponent to find good squares for his pieces.
				In the example above white makes good moves to control the center while black plays bad moves.
				</p>
				<p><b>#4 Use all of your pieces </b> </p>
				<p>
				In the example above white got all of his pieces in the game!
				Your pieces don&rsquo;t do any good when they are sitting back on the first row.
				Try and develop all of your pieces so that you have more to use when you attack the king.
				Using one or two pieces to attack will not work against any decent opponent.
				</p>
				<a name="better" id="better"></a>
				<h2>Getting Better at Chess  </h2>
				<p>
				Knowing the rules and basic strategies is only the beginning - there is so much to learn in chess that you can never learn it all in a lifetime!
				To improve you need to do three things:
				</p>
				<p><b>#1 &ndash; Play  </b></p>
				<p>
				Just keep playing!
				Play as much as possible.
				You should learn from each game &ndash; those you win and those you lose.
				</p>
				<p><b>#2 &ndash; Study </b> </p>
				<p>
				If you really want to improve quickly then pick up a [recommended chess book].
				There are also many resources on Chess.com to help you study and improve.
				</p>
				<p><b>#3 Have fun  </b></p>
				<p>
				Don&rsquo;t get discouraged if you don&rsquo;t win all of your games right away.
				Everyone loses &ndash; even world champions.
				As long as you continue to have fun and learn from the games you lose then you can enjoy chess forever!
				</p>
			
			</div>
		</div>
        </div>
	
	<!-- Start Footer -->
	<jsp:include page="footer.html" />
    <!-- End Footer -->
</body>
</html>
