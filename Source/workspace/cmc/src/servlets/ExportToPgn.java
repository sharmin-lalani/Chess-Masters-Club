package servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ExportToPgn
 */
@WebServlet("/ExportToPgn")
public class ExportToPgn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExportToPgn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession se =request.getSession(false);
		 
		String username=(String)se.getAttribute("username");
		            if(username==null)
		            {
		            	request.setAttribute("message", "You must be logged in to view this page");
		            	request.getRequestDispatcher("status.jsp").forward(request, response);	
		            }

		
		//PrintWriter out=response.getWriter();
		
		response.setContentType("text/html");
	   
	    Writer output = null;
	   		
			String game_id=(String)se.getAttribute("game_id");
			String pgn=request.getParameter("pgn");
			System.out.println(game_id);
			
			String filePath=("C:/Users/db2admin/workspace/cmc/games");  
			String f=game_id+".pgn";
			
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
		                  output = new BufferedWriter(new FileWriter(file));
		            	  output.write(pgn);
		            	  output.close();
		            	  
		            	  response.setContentType("text/html");
		            	  response.setHeader("Content-disposition","attachment; filename="+game_id+".pgn");
		 		       
		 		         File my_file = new File("C:/Users/db2admin/workspace/cmc/games/"+game_id+".pgn");
		 		        
		 		         OutputStream fout = response.getOutputStream();
		 		         FileInputStream in = new FileInputStream(my_file);
		 		         byte[] buffer = new byte[4096];
		 		         int length;
		 		         while ((length = in.read(buffer)) > 0){
		 		            fout.write(buffer, 0, length);
		 		         }
		 		         
		 		         in.close();
		 		         fout.flush();
		 		         
		 		        File deleteFile = new File("C:/Users/db2admin/workspace/cmc/games/"+game_id+".pgn") ;
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
