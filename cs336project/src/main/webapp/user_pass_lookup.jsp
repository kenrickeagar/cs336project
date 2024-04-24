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
			
			String username = request.getParameter("user");
			String password = request.getParameter("pass");
		
			
            String query = "SELECT * FROM Users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, request.getParameter("user"));
            pstmt.setString(2, request.getParameter("pass"));
			ResultSet result = pstmt.executeQuery();
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>
				<%if (result.next()) {
					
					session.setAttribute("username", username);
					//out.print("<h1>Login Succesful</h1>");
					//out.print("<a href='userLogin.jsp'>Logout</a>");
					response.sendRedirect("HomePage.jsp");
				}
				else {
					// if login fails, redirect back to login page
					response.sendRedirect("userLogin.jsp");
				}
				%>
			</td>
		</tr>	
			<%
			con.close();
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
</body>
</html>