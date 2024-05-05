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
<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String user = (String)session.getAttribute("username");
			if(user == null){
				response.sendRedirect("userLogin.jsp");
			}

			
            String query = "SELECT * FROM Questions WHERE question LIKE CONCAT('%',?,'%') ";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, request.getParameter("search_question"));
			ResultSet result = pstmt.executeQuery();
			

			%>
	
		<!--  Make an HTML table to show the results in: -->
			<table align = "center" border = '1'>
		<tr>    
			<th>Question</th>
			<th>Answer</th>
			</tr>
				<%while(result.next()){ %>
					<tr>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(3) %></td>
			
				<%} %>	
				
	</table>
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