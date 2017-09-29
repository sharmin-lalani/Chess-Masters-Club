file=['a','b','c','d','e','f','g','h'];
wcaptured=0;
bcaptured=0;
flag=0;
cmcmoveno=0;
highlight_color="#aadbe6";


//initialize the board

function cmcfen (fenstr1)
{
		
	i=0;j=8,k=0;
	while(i<64 && j>0)
		{
		fenstr=fenstr1.split("");
		ch=fenstr[k];
		k=k+1;
		
		c2=i%8;
		c1=file[c2];
		c3=c1+j;
		i=i+1;
		
		var obj= document.getElementById(c3);
		
			switch(ch)
			{
				case 'R':
					
					obj.innerHTML="<div>&#9814;</div>";
					break;
					
				case 'B':
					
					obj.innerHTML="<div>&#9815;</div>";
					break;
					
				case 'N':
					
					obj.innerHTML="<div>&#9816;</div>";
					break;
					
				case 'K':
					
					obj.innerHTML="<div>&#9812;</div>";
					break;
					
				case 'Q':
					
					obj.innerHTML="<div>&#9813;</div>";
					break;
					
				case 'P':
					
					obj.innerHTML="<div>&#9817;</div>";	
					break;
					
				case 'r':

					obj.innerHTML="<div>&#9820;</div>";
					break;
					
				case 'b':
					
					obj.innerHTML="<div>&#9821;</div>";
					break;
					
				case 'n':
					
					obj.innerHTML="<div>&#9822;</div>";
					break;
					
				case 'k':
					
					obj.innerHTML="<div>&#9818;</div>";
					break;
					
				case 'q':
					
					obj.innerHTML="<div>&#9819;</div>";
					break;
					
				case 'p':
					
					obj.innerHTML="<div>&#9823;</div>";
					break;
					
				case '8':
					i=i+7;
					break;
					
				case '7':
					i=i+6;
					break;
					
				case '6':
					i=i+5;
					break;
					
				case '5':
					i=i+4;
					break;
					
				case '4':
					i=i+3;
					break;
					
				case '3':
					i=i+2;
					break;
					
				case '2':
					i=i+1;
					break;
					
				case '1':
					i=i+0;
					break;
					
				case '/':
					j=j-1;
					i=i-1;

			}
					
			}
		}
	

function status_display()
{
	
	if(chess.in_check()==true )
	{
			if(turn=='b')
			{
			stat.innerHTML="Black in Check";
			stat1.innerHTML="Black in Check";
			}
			else
			{stat.innerHTML="White in Check";
			stat1.innerHTML="White in Check";
			}
		
	}
	
	
//display message when game ends
if(chess.game_over()==true)
	{
	
		if(chess.in_checkmate()==true)
			{
			if(turn=='b')
				{
				stat.innerHTML="Checkmate! White won";
				stat1.innerHTML="Checkmate! White won";
				
				}
			else
				{
				stat.innerHTML="Checkmate! Black won";
				stat1.innerHTML="Checkmate! Black won";
				
				}
			}
		else 
			if(chess.in_threefold_repetition()==true)
			{
			stat.innerHTML="Three Fold Repetition! Draw";
			stat1.innerHTML="Three Fold Repetition! Draw";
			
			}
		else if(chess.insufficient_material()==true)
			{
			stat.innerHTML="Insufficient Material! Draw";
			stat1.innerHTML="Insufficient Material! Draw";
			}
		
		else	
			if(chess.in_stalemate()==true)
					{
					stat.innerHTML="Stalemate! Draw";
					stat1.innerHTML="Stalemate! Draw";
					}
			else 	
				if(chess.in_draw()==true)
							{
							stat.innerHTML="No pawn Advancement or captures since last fifty moves! Draw";
							stat1.innerHTML="No pawn Advancement or captures since last fifty moves! Draw";
							}
		
	
	}
	
}


//keep polling the database to check if the opponent has made a move
function poll()
{
   
    $.ajax
	({
		url:"TourCheckMove",
		method: 'POST',
		data: "gameid="+gameid+"&player="+wb.trim(),
		success:function(result)
		{
      		//alert(result);
			if(result!=null)
				{
				move=chess.move(result.trim());
				//alert(move);
				
				if(move!=null)
				{	
					//location.reload();
				
					from=move.from;
					to=move.to;
				
					
					fromelem=document.getElementById(from);
					toelem=document.getElementById(to);
					
					var a=fromelem.innerHTML;
					
					
					fromelem.innerHTML="<div></div>";
					toelem.innerHTML=a;
					
					//display the moves in the move list
					var newmove=move.san;
					turn=chess.turn();
					mf=move.flags;
	
					if(mf=="cp")
						location.reload();
					
					if(mf=="np")
						{
							display_prom(mf,move.piece,move);
						
						}
	
					else
					display_capture(mf,move.captured);
					
					
					if(turn=='b')
						{
						cmcmoveno++;
						movelist.innerHTML +=cmcmoveno +'. '  + newmove;
						}
					else
						movelist.innerHTML += '  ' + newmove + '<br />';
						
						
				//display whose turn to play
						if(turn=='b')
							{
							turndiv.innerHTML="&#9818;";
							}
						else turndiv.innerHTML="&#9812;";
						
						status_display();
						
						myturn="1";
				
				}
				
				}
			
			/*if(move==null){setTimeout(
                    poll, // Request next message 
                    5000 // ..after 5 seconds 
                );
			}*/
    	},
		
		complete:function(result)
		{
			if(move==null) poll();
		},
		timeout:10000
    	
                
		
	});
}



window.onload=function()
{
	
chess=new Chess();
movelist=document.getElementById("movelist");
wcapturelist=document.getElementById("wcapturelist");
bcapturelist=document.getElementById("bcapturelist");
turndiv=document.getElementById("turn");
stat = document.getElementById("status");
stat1 = document.getElementById("status1");
//high = document.getElementById("highlight");
//poss_moves = document.getElementById("possible");


pgn2 = document.getElementById("pgn");
pgn=pgn2.innerHTML;
pgn1 = [pgn];
chess.load_pgn(pgn1.join('\n')); 


myturn="0";
wb=" "+$("#wb").text();
gameid=$("#gameid").text();


fenstring=chess.fen();
cmcfen(fenstring);

//initialize moves and captures so far
var history=chess.history({verbose: true});
var l=history.length;
var white=1;
for(var i=0;i<l;i++)
	if(white==1)
		{
			cmcmoveno++;
			movelist.innerHTML +=cmcmoveno +'. '  + history[i].san;
			//alert(history[i].san);
			turn='b';
			hf=history[i].flags;
			if(hf!="np" && hf!="cp")
				display_capture(history[i].flags,history[i].captured);
			else if(hf=="cp")
			{
			cp_piece=history[i].captured;
			
			switch(cp_piece)
			{
			case 'p': 
				wcapturelist.innerHTML += "&#9823;" ;
				wcaptured++;
				break;
			case 'n':
				wcapturelist.innerHTML += "&#9822;"  ;
				wcaptured++;
				break;
			case 'b':
				wcapturelist.innerHTML += "&#9821;"  ;
				wcaptured++;
				break;
			case 'r':
				wcapturelist.innerHTML += "&#9820;"  ;
				wcaptured++;
				break;
			case 'q':
				wcapturelist.innerHTML += "&#9819;"  ;
				wcaptured++;
				break;
			case 'k':
				wcapturelist.innerHTML += "&#9818;"  ;
				wcaptured++;
				break;
			
			}
			
			if(wcaptured%5==0)
				wcapturelist.innerHTML += '<br />' ;
				
			
			}
			
			
			
			white=0;
		}
	else
		{
			movelist.innerHTML += '  ' + history[i].san + '<br />';
			turn='w';
			hf=history[i].flags;
			if(hf!="np" && hf!="cp")
				display_capture(history[i].flags,history[i].captured);
			else if(hf=="cp")
			{
			cp_piece=history[i].captured;
			
			switch(cp_piece)
			{
			case 'p': 
				bcapturelist.innerHTML += "&#9817;" ;
				bcaptured++;
				break;
			case 'n':
				bcapturelist.innerHTML += "&#9816;"  ;
				bcaptured++;
				break;
			case 'b':
				bcapturelist.innerHTML += "&#9815;"  ;
				bcaptured++;
				break;
			case 'r':
				bcapturelist.innerHTML += "&#9814;"  ;
				bcaptured++;
				break;
			case 'q':
				bcapturelist.innerHTML += "&#9813;"  ;
				bcaptured++;
				break;
			case 'k':
				bcapturelist.innerHTML += "&#9812;"  ;
				bcaptured++;
				break;
			
			}
			
			if(bcaptured%5==0)
				bcapturelist.innerHTML += '<br />' ;
			
			
			}
			white=1;
		}



status_display();


//initialize whose turn to play
	turn=chess.turn();

	if(turn=='b')
			{
				turndiv.innerHTML="&#9818;";;
				if(wb.match(/b/)) myturn="1";
			}
	else 
		{
			turndiv.innerHTML="&#9812;";
			if(wb.match(/w/)) myturn="1";		
		 
		}
	
	if(myturn=="0") poll();

//initialize other variables

src=0;
to="",from="";


// const b_p = "&#9823;";
//const b_b = "&#9821;";
// const b_n = "&#9822;";
// const b_r = "&#9820;";
// const b_q = "&#9819;";
// const w_p = "&#9817;";
// const w_b = "&#9815;";
// const w_n = "&#9816;";
// const w_rook = "&#9814;";
// const w_q = "&#9813;";



};


function theme(me)
{
	var theme_color=me.value;
	
	switch(theme_color)
	{
	case "grey":
		document.getElementById('theme_css').href = 'stylesheets/grey.css';
		highlight_color="#ccc";
		break;
	case "blue":
		document.getElementById('theme_css').href = 'stylesheets/blue.css';
		highlight_color="#aadbe6";
		break;
	case "green":
		document.getElementById('theme_css').href = 'stylesheets/green.css';
		highlight_color="#e5d57b";
		break;
	case "sand":
		document.getElementById('theme_css').href = 'stylesheets/default.css';
		highlight_color="#4c483f";
		break;
	
	}
}



//display captures and castling and promotion and en passant
function display_capture(c,piece)
{

	switch(c)
	{
	case 'c':
		flag=1;
		break;
		
	case 'e':
		if(turn=='b')
			{

			 var ento=move.to;
			 var entolist=ento.split("");
			 var a=entolist[1]-1;
			 
			 var b=entolist[0]+a;
			 
			 var elem=document.getElementById(b);
			 elem.innerHTML="<div></div>";

			flag=1;
			
			}
		else
		
			{
				 var ento=move.to;
				 var entolist=ento.split("");
				 var a=parseInt(entolist[1]);
		
			     a=a+1;
				 var b=entolist[0]+a;
				 var elem=document.getElementById(b);
				 elem.innerHTML="";

				flag=1;
				
			}
		break;
		
	case 'k':
		if(turn=='b')
			{
			h1.innerHTML="<div></div>";
			f1.innerHTML="<div>&#9814;</div>";
			}
		else
			{
			h8.innerHTML="<div></div>";
			f8.innerHTML="<div>&#9820;</div>";
			
			}
		break;
		
	case 'q':
		if(turn=='b')
		{
		a1.innerHTML="<div></div>";
		d1.innerHTML="<div>&#9814;</div>";
		}
	else
		{
		a8.innerHTML="<div></div>";
		d8.innerHTML="<div>&#9820;</div>";
		
		}
	break;
		
	case 'np':
		
		to_p=document.getElementById(move.to);
														
		if(turn=='b')
		{
			if(prom=='q')
				to_p.innerHTML="<div>&#9813;</div>";
				
			else if(prom=='r')
				to_p.innerHTML="<div>&#9814;</div>";
		
			else if(prom=='b')
				to_p.innerHTML="<div>&#9815;</div>";
		
			else 
				to_p.innerHTML="<div>&#9816;</div>";
			
		}
		else
			{
			switch(prom)
			
			{
			
			case 'q':
				to_p.innerHTML="<div>&#9819;</div>";
				break;
			case 'r':
				to_p.innerHTML="<div>&#9820;</div>";
				break;
			case 'b':
				to_p.innerHTML="<div>&#9821;</div>";
				break;
			case 'n':
				to_p.innerHTML="<div>&#9822;</div>";
			}
			}
		break;
		
		case 'cp':
		
		to_p=document.getElementById(move.to);
														
		if(turn=='b')
		{
			flag=1;
			if(prom=='q')
				to_p.innerHTML="<div>&#9813;</div>";
				
			else if(prom=='r')
				to_p.innerHTML="<div>&#9814;</div>";
		
			else if(prom=='b')
				to_p.innerHTML="<div>&#9815;</div>";
		
			else 
				to_p.innerHTML="<div>&#9816;</div>";
			
		}
		else
			{
			flag=1;
			switch(prom)
			
			{
			
			case 'q':
				to_p.innerHTML="<div>&#9819;</div>";
				break;
			case 'r':
				to_p.innerHTML="<div>&#9820;</div>";
				break;
			case 'b':
				to_p.innerHTML="<div>&#9821;</div>";
				break;
			case 'n':
				to_p.innerHTML="<div>&#9822;</div>";
			}
			}
		break;
	}
	
	if(flag==1)
		{
		if(turn=='b')
		{
		switch(piece)
		{
		case 'p': 
			wcapturelist.innerHTML += "&#9823;" ;
			wcaptured++;
			break;
		case 'n':
			wcapturelist.innerHTML += "&#9822;"  ;
			wcaptured++;
			break;
		case 'b':
			wcapturelist.innerHTML += "&#9821;"  ;
			wcaptured++;
			break;
		case 'r':
			wcapturelist.innerHTML += "&#9820;"  ;
			wcaptured++;
			break;
		case 'q':
			wcapturelist.innerHTML += "&#9819;"  ;
			wcaptured++;
			break;
		case 'k':
			wcapturelist.innerHTML += "&#9818;"  ;
			wcaptured++;
			break;
		
		}
		
		if(wcaptured%5==0)
			wcapturelist.innerHTML += '<br />' ;
			
		}
	else
		{
		switch(piece)
		{
		case 'p': 
			bcapturelist.innerHTML += "&#9817;" ;
			bcaptured++;
			break;
		case 'n':
			bcapturelist.innerHTML += "&#9816;"  ;
			bcaptured++;
			break;
		case 'b':
			bcapturelist.innerHTML += "&#9815;"  ;
			bcaptured++;
			break;
		case 'r':
			bcapturelist.innerHTML += "&#9814;"  ;
			bcaptured++;
			break;
		case 'q':
			bcapturelist.innerHTML += "&#9813;"  ;
			bcaptured++;
			break;
		case 'k':
			bcapturelist.innerHTML += "&#9812;"  ;
			bcaptured++;
			break;
		
		}
		
		if(bcaptured%5==0)
			bcapturelist.innerHTML += '<br />' ;
		}
		flag=0;
		}
	
}










//display promotion 
function display_prom(c,prom,move)
{

	switch(c)
	{
		
	case 'np':
		to_p=document.getElementById(move.to);
														
		if(turn=='b')
		{
			if(prom=='q')
				to_p.innerHTML="<div>&#9813;</div>";
				
			else if(prom=='r')
				to_p.innerHTML="<div>&#9814;</div>";
		
			else if(prom=='b')
				to_p.innerHTML="<div>&#9815;</div>";
		
			else 
				to_p.innerHTML="<div>&#9816;</div>";
			
		}
		else
			{
			switch(prom)
			
			{
			
			case 'q':
				to_p.innerHTML="<div>&#9819;</div>";
				break;
			case 'r':
				to_p.innerHTML="<div>&#9820;</div>";
				break;
			case 'b':
				to_p.innerHTML="<div>&#9821;</div>";
				break;
			case 'n':
				to_p.innerHTML="<div>&#9822;</div>";
			}
			}
		break;
		
		case 'cp':
		
		to_p=document.getElementById(move.to);
														
		if(turn=='b')
		{
			flag=1;
			if(prom=='q')
				to_p.innerHTML="<div>&#9813;</div>";
				
			else if(prom=='r')
				to_p.innerHTML="<div>&#9814;</div>";
		
			else if(prom=='b')
				to_p.innerHTML="<div>&#9815;</div>";
		
			else 
				to_p.innerHTML="<div>&#9816;</div>";
			
		}
		else
			{
			flag=1;
			switch(prom)
			
			{
			
			case 'q':
				to_p.innerHTML="<div>&#9819;</div>";
				break;
			case 'r':
				to_p.innerHTML="<div>&#9820;</div>";
				break;
			case 'b':
				to_p.innerHTML="<div>&#9821;</div>";
				break;
			case 'n':
				to_p.innerHTML="<div>&#9822;</div>";
			}
			}
		
	}

	if(flag==1)
		{
		if(turn=='b')
		{
		switch(piece)
		{
		case 'p': 
			wcapturelist.innerHTML += "&#9823;" ;
			wcaptured++;
			break;
		case 'n':
			wcapturelist.innerHTML += "&#9822;"  ;
			wcaptured++;
			break;
		case 'b':
			wcapturelist.innerHTML += "&#9821;"  ;
			wcaptured++;
			break;
		case 'r':
			wcapturelist.innerHTML += "&#9820;"  ;
			wcaptured++;
			break;
		case 'q':
			wcapturelist.innerHTML += "&#9819;"  ;
			wcaptured++;
			break;
		case 'k':
			wcapturelist.innerHTML += "&#9818;"  ;
			wcaptured++;
			break;
		
		}
		
		if(wcaptured%5==0)
			wcapturelist.innerHTML += '<br />' ;
			
		}
	else
		{
		switch(piece)
		{
		case 'p': 
			bcapturelist.innerHTML += "&#9817;" ;
			bcaptured++;
			break;
		case 'n':
			bcapturelist.innerHTML += "&#9816;"  ;
			bcaptured++;
			break;
		case 'b':
			bcapturelist.innerHTML += "&#9815;"  ;
			bcaptured++;
			break;
		case 'r':
			bcapturelist.innerHTML += "&#9814;"  ;
			bcaptured++;
			break;
		case 'q':
			bcapturelist.innerHTML += "&#9813;"  ;
			bcaptured++;
			break;
		case 'k':
			bcapturelist.innerHTML += "&#9812;"  ;
			bcaptured++;
			break;
		
		}
		
		if(bcaptured%5==0)
			bcapturelist.innerHTML += '<br />' ;
		}
		flag=0;
		}
	
}

function checkmove(me)
{
	

	if(myturn=="1")
		{
		
		if(src==0) 
		{
			
			stat.innerHTML="";
			stat1.innerHTML="";
			//poss_moves.innerHTML="";
			src=1;
			from=me;
		
			//alert(from);
		/*	if(high.checked==true)
			{
				possible=chess.moves({square: from});
			var len=possible.length;
			if(len>0)
				poss_moves.innerHTML="Possible Moves: "+'<br />';
			var i=0;
			for(i=0; i<len;i++)
				{
				poss_moves.innerHTML+=possible[i]+" , ";
				if((i+1)%4==0)
					{
					poss_moves.innerHTML+='<br />';
					}
				
				}
			}
			else
				poss_moves.innerHTML="";
				*/
			fromelem=document.getElementById(from);
			fromcolor=fromelem.style.backgroundColor;
			fromelem.style.backgroundColor=highlight_color;
			
		}
		else 
			{
			stat.innerHTML="";
			stat1.innerHTML="";
			//poss_moves.innerHTML="";
				src=0;
				to=me;
				toelem=document.getElementById(to);
				tocolor=toelem.style.backgroundColor;
				toelem.style.backgroundColor=highlight_color;
				promote=document.getElementById("promotion");
				prom=promote.value;
				
				move=chess.move({from:from, to: to, promotion: prom});
				
				
			
				if(move!=null)
				{	counter=cmcmoveno+1;
					if(chess.game_over()==false) game_end=0;
					else game_end=1;
					draw="0";
					if(chess.game_over()==true && chess.in_checkmate()==false) draw="1";
					else draw="0";
					
					
					//update the database
					   
				    $.ajax
					({
						url:"TourMakeMove",
						method: 'POST',
						data: "gameid="+gameid+"&san="+move.san+"&player="+wb.trim()+"&counter="+counter+"&is_end="+game_end+"&draw="+draw,
						success:function(result)
						{
							
							//database was successfully updated
							if(result=="1")
								{
								
								myturn="0";
								
								var a=fromelem.innerHTML;
								
								fromelem.innerHTML="<div></div>";
								toelem.innerHTML=a;
								
								fromelem.style.backgroundColor=fromcolor;
								toelem.style.backgroundColor=tocolor;
								
								//display the moves in the move list
								var newmove=move.san;
								turn=chess.turn();
								
								mf=move.flags;
								var piece="";
								if(mf=="np")
								piece=move.piece;
								else piece=move.captured;
								
								if(turn=='b')
									{
									cmcmoveno++;
									movelist.innerHTML +=cmcmoveno +'. '  + newmove;
									}
								else
									movelist.innerHTML += '  ' + newmove + '<br />';
									var c=move.flags;
								
								
								//display captures in the capture list	
								display_capture(c,piece);
									
									
								//display whose turn to play
								if(turn=='b')
									{
									turndiv.innerHTML="&#9818;";
									}
								else turndiv.innerHTML="&#9812;";
								
								status_display();
								
								poll();
								
								}
							
							//database could not be updated
							else
								{
								chess.undo();
								
								toelem.style.backgroundColor=tocolor;
								fromelem.style.backgroundColor=fromcolor;
								location.reload();
								//stat.innerHTML="There was an error updating the database.Try later.1";
								//stat1.innerHTML="There was an error updating the database.Try later.1";
								
								}
							
				    	},
				    	error: function(XMLHttpRequest, textStatus, errorThrown)
						{
				    		chess.undo();
							
							toelem.style.backgroundColor=tocolor;
							fromelem.style.backgroundColor=fromcolor;
							stat.innerHTML="There was an error updating the database.Try later.";
							stat1.innerHTML="There was an error updating the database.Try later.";
						}
					});
				
					
					
					
				
				}
				else 
				{
					toelem.style.backgroundColor=tocolor;
					fromelem.style.backgroundColor=fromcolor;
					stat.innerHTML="Invalid Move";
					stat1.innerHTML="Invalid Move";
					
				}
				
				status_display();
				
			}
		
		}
	else if(chess.game_over()==false && myturn=="0")
		{
		stat.innerHTML="You must wait for your turn.";
		stat1.innerHTML="You must wait for your turn.";
		}
	
	
	
}


function cmcpgn()
{
	 var m=chess.pgn({ max_width: 5 });
	  
	  white1 = document.getElementById("whiteplayer");
	  black1 = document.getElementById("blackplayer");
	  white2=white1.innerHTML;
	  black2=black1.innerHTML;
	  pgn="[White \""+white2+"\"]  [ Black  \""+black2+"\" ]  "+m;
	document.location.href = "ExportToPgn?pgn="+pgn; 
	
}