<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Adder</title>
</head>
<body>
<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String query2 = "SELECT id from Users WHERE username = ?";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			String user = (String)session.getAttribute("username");
			if(user == null){
				response.sendRedirect("userLogin.jsp");
			}
			pstmt2.setString(1, user);
			ResultSet result1 = pstmt2.executeQuery();
			result1.next();
			String curr_id = result1.getString(1);
			
            String query = "INSERT INTO Questions(question,id) VALUES (?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, request.getParameter("question"));
            pstmt.setString(2, curr_id);
			pstmt.executeUpdate();
			
			out.print("<h1>Question Submitted!</h1>");
			out.print("<a href='listQuestions.jsp'>See Other Questions</a>");
			out.println("\n<a href='HomePage.jsp'>Return Home</a>");
			%>
	
		<!--  Make an HTML table to show the results in: -->

			<%
			con.close();
			//close the connection.
			db.closeConnection(con);
			%>
		

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>