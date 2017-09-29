package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databasepools.c3p0pooledconnection;

/**
 * Servlet implementation class AddMembers
 */
@WebServlet("/AddMembers")
public class AddMembers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMembers() {
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
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		PreparedStatement ps1=null,ps2=null,ps3=null;
		PrintWriter out=response.getWriter();
		
		
		String id=request.getParameter("t_id");
		
		int counter=0;
		try {
		
		String q1="select * from groups where tournament_id=?";
		String q2="select username from tournament_req where t_id=? and status='0'";
		ps1=conn.prepareStatement(q1);
		ps1.setString(1,id);
		ps2=conn.prepareStatement(q2);
		ps2.setString(1,id);
		ResultSet rs1=ps1.executeQuery();
		ResultSet rs2=ps2.executeQuery();
		while(rs1.next())		
		{	
			
			String mem=rs1.getString("no_of_members");
			//out.println("in while");
			int memno=Integer.parseInt(mem);
			//out.println(memno);
			String gid=rs1.getString("group_id");
			int i=0;
			
			List<String> list = new ArrayList<String>();
			while (rs2.next()) {
			    list.add(rs2.getString(1));
			}   
			String list2[]=null;
			list2 = (String[]) list.toArray(new String[list.size()]);
			out.println(list2[0]);
			
		}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	}


