package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class CreateTournament
 */
@WebServlet("/CreateTournament")
public class CreateTournament extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateTournament() {
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
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		
		String n=request.getParameter("name");
		String sd1=request.getParameter("sd1");
		String sd2=request.getParameter("sd2");
		String sd3=request.getParameter("sd3");
		String ed1=request.getParameter("ed1");
		String ed2=request.getParameter("ed2");
		String ed3=request.getParameter("ed3");
		String max=request.getParameter("max");
		String cp=request.getParameter("cp");
		
		String sd=sd1+"-"+sd2+"-"+sd3;
		String ed=ed1+"-"+ed2+"-"+ed3;
		
		if(cp=="")
			cp=null;
		Date date_time=new Date();
		SimpleDateFormat dnow=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String dt=dnow.format(date_time);
				
		String s="select * from tournament where name=?";
		try
		{
			PreparedStatement p=conn.prepareStatement(s);
			p.setString(1, n);
			ResultSet r=p.executeQuery();
		if(!r.next())
		{
			if(sd.compareTo(dt)>=0 &&  sd.compareTo(ed)<0)
			{
		
				String query="insert into tournament(name,start_date, end_date, max_players, cashprize) values(?,?,?,?,?)";
		
				PreparedStatement ps=conn.prepareStatement(query);
		
			
				ps.setString(1,n);
				ps.setString(2,sd);
				ps.setString(3,ed);
				ps.setString(4,max);
				ps.setString(5,cp);
				
				int rs=ps.executeUpdate();
			
				if(rs>0)
					response.sendRedirect("manage_tournaments.jsp");
				else
					response.sendRedirect("status.jsp");
			
			} 
			else
			{
				out.println("please enter valid start and end dates for the tournament.");
			}
		
		}
		else
		{
			out.println("Please provide a unique name for the tournament.");
		}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

}
