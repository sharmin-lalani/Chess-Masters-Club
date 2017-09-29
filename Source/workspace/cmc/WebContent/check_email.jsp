<%@page import="java.sql.*"%>
  <%@include file="connection.jsp"%>
  
  <% 
 try
  {
	String val=request.getParameter("value");
    Statement stm=con.createStatement();
    String query="select * from user where email="+"'"+val+"'";
    ResultSet rs = stm.executeQuery(query);
    if (rs.next()) out.print("0");
	else out.print("1");
    stm.close();
    con.close();

   }
  catch(Exception e)
  {
	  out.print("Sorry could not connect to the database");
  }

     %>