package servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class SaveGame
 */
@WebServlet("/SaveGame")
public class SaveGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveGame() {
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
	    PrintWriter out=response.getWriter();
	   		
			String game_id=(String)se.getAttribute("game_id");
			String pgn=request.getParameter("pgn");
			System.out.println(game_id);
			
			String filePath=("E:/eclipseworkspace/cmc/savedgames");  
			String f=game_id+".pgn";
			System.out.println(f);
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
		            	 out.println("done");
		            	 // response.sendRedirect("my_games.jsp");
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
