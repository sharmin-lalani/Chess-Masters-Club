
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
Class.forName("com.ibm.db2.jcc.DB2Driver");
Connection  con=DriverManager.getConnection("jdbc:db2://localhost:50000/CMC","db2admin","admin");
%>
