<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="crHomePage.jsp">Go Back Home </a>
<h1 align = 'center'>Selected Question</h1>

<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
		
            
    	
			
			String answer = request.getParameter("get_answer");
    		String question_id = request.getParameter("question_id");
				String str = "update questions set answer = ? WHERE qid = ?";
				PreparedStatement pstmt2 = con.prepareStatement(str);
				pstmt2.setString(1, answer);
				pstmt2.setString(2, question_id);
				pstmt2.executeUpdate() ;
				response.sendRedirect("crHomePage.jsp");
				
				
			
			
			%>
	


					
			
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