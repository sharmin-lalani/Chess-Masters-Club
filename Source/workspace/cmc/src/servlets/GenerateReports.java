package servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.text.SimpleDateFormat;


import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class GenerateReports
 */
@WebServlet("/GenerateReports")
public class GenerateReports extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateReports() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession se =request.getSession(false);
		String ad=(String)se.getAttribute("admin_id");
        if(ad==null)
        {	
        	request.setAttribute("message", "You must be logged in to view this page");
        	request.getRequestDispatcher("status.jsp").forward(request, response);	
        }
		
		
		
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		String no=request.getParameter("no");
		int num=Integer.parseInt(no);
		
		Calendar now = Calendar.getInstance();
		Calendar now1 = Calendar.getInstance();
		now.add(Calendar.DATE, -num);
		SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dt=dnow.format(now.getTime());
		String dtnow=dnow.format(now1.getTime());
		SimpleDateFormat dnow1=new SimpleDateFormat("yyyy-MM-dd");
		String dt1=dnow1.format(now.getTime());
		String dtnow1=dnow1.format(now1.getTime());
		
		
		PreparedStatement ps1=null;
		ResultSet rs1=null;
		String query1="select game_id,XMLQUERY('$RECORD/game/date/text()'),XMLQUERY('$RECORD/game/whiteplayer/text()') , XMLQUERY('$RECORD/game/blackplayer/text()'),XMLQUERY('$RECORD/game/isend/text()'),XMLQUERY('$RECORD/game/winner/text()') from chess_game order by game_id desc";
		String record="Game_id		Start Date			WhitePlayer		BlackPlayer		Winner\n\r";
		try
		{
			ps1=conn.prepareStatement(query1);
			rs1=ps1.executeQuery();
			while(rs1.next())
			{
				System.out.print("in while");
				String game_id=rs1.getString(1);
				String sd=rs1.getString(2);
				String wp=rs1.getString(3);
				String bp=rs1.getString(4);
				String isend=rs1.getString(5);
				String win=rs1.getString(6);
				if(sd.compareTo(dt)>=0)
					{
					System.out.print("in if");
					record+="\n\r"+game_id+"		"+sd+"		"+wp+"			"+bp+"			";
					if(isend.equals("1"))
						record+=win+"\n\r";
					else record+="\n\r";
					}
			}
		}
		catch (Exception exc) {
			// TODO Auto-generated catch block
			exc.printStackTrace();
		}
				  Writer output = null;
			   		
					
					String filePath=("C:/Users/db2admin/workspace/cmc/records");
				    String f="Report "+dt1+" to "+dtnow1+".txt";
					
				    File file = new File(filePath, f);  
				 
				    if (!file.getParentFile().exists())
				    {		
				            System.out.println(String.format("Creating folder %s...", file.getParentFile().getAbsolutePath()));
				            if (file.getParentFile().mkdirs())
				            	System.out.println("Done");
				            else
				            	System.out.println("Unable to create folder");
				     }
				        
				      if (!file.exists())
				      {
				        	System.out.println(String.format("Creating file %s...", file.getAbsolutePath()));
				            if (file.createNewFile())
				            	
				            {
				            	System.out.print("in if create new file");
				                  output = new BufferedWriter(new FileWriter(file));
				            	  output.write(record);
				            	  output.close();
				            	  
				            	  response.setContentType("application.txt");
				            	  response.setHeader("Content-disposition","attachment; filename=Report "+dt1+" to "+dtnow1+".txt");
				 		       
				 		         File my_file = new File("C:/Users/db2admin/workspace/cmc/records/Report "+dt1+" to "+dtnow1+".txt");
				 		         
				 		        
				 		         OutputStream fout = response.getOutputStream();
				 		         FileInputStream in = new FileInputStream(my_file);
				 		         byte[] buffer = new byte[4096];
				 		         int length;
				 		         while ((length = in.read(buffer)) > 0){
				 		            fout.write(buffer, 0, length);
				 		         }
				 		        System.out.println(record);
				 		         
				 		         in.close();
				 		         fout.flush();
				 		         
				 		        File deleteFile = new File("C:/Users/db2admin/workspace/cmc/records/Report "+dt1+" to "+dtnow1+".txt") ;
				 		    // check if the file is present or not
				 		        if( deleteFile.exists() )
				 		        	{
				 		        	deleteFile.delete() ;
				 		        	System.out.println("deleted");
				 		        	}
				      
				            }
				            else
				                response.sendRedirect("status.jsp");
				        }
				        else
				        	response.sendRedirect("status.jsp");
				        	//System.out.println(String.format("File %s already exists!", file.getAbsolutePath()));
			
			
			
			
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
