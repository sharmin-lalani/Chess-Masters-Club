package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession se =request.getSession(false);
		 
		String username=(String)se.getAttribute("username");
		            if(username==null)
		            {
		            	request.setAttribute("message", "You must be logged in to view this page");
		            	request.getRequestDispatcher("status.jsp").forward(request, response);	
		            }

		
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		
		String u=request.getParameter("uname");
		String f=request.getParameter("fname");
		String l=request.getParameter("lname");
		String ph=request.getParameter("phone");
		String cy=request.getParameter("country");
		String s=request.getParameter("sex");
		String d=request.getParameter("desc");
		String dob1=request.getParameter("dob1");
		String dob2=request.getParameter("dob2");
		String dob3=request.getParameter("dob3");
		String dob=dob1+"-"+dob2+"-"+dob3;
		if(dob1=="" || dob2=="" || dob3 =="") dob=null;
		
		
		String query1="update user set fname=?, lname=?, mobile_no=? ,country=?, gender=?,dob=?, desc=? where username=?";
		 try {
				PreparedStatement stmt  = conn.prepareStatement(query1) ;
				stmt.setString(1,f) ; 
				stmt.setString(2,l) ;
				stmt.setString(3,ph) ;
				stmt.setString(4,cy) ;
				stmt.setString(5,s) ;
				stmt.setString(6,dob) ;
				stmt.setString(7,d) ;
				stmt.setString(8,u) ;
				
				
				int rs=stmt.executeUpdate();
				if(rs>0)
					request.setAttribute("edit_success", "true");
				
				request.getRequestDispatcher("/profile.jsp?username="+u).forward(request, response);
			
		 	}
			 catch(Exception ex)
			 {
				 ex.printStackTrace() ;
			 }
			 
		
	}

}
