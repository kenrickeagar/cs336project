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
			
			String item_alert = request.getParameter("item_alert");
			
		
			
            String query = "INSERT INTO Item_Alert (id, item_description) VALUES (?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            String currentUser = (String)session.getAttribute("username");
            if(currentUser == null){
				response.sendRedirect("userLogin.jsp");
		}
			
			//Query to get id based off username
			String getIDquery = "SELECT id from users where username = ?";
			PreparedStatement idstmt = con.prepareStatement(getIDquery);
			idstmt.setString(1, currentUser);
			ResultSet resultid = idstmt.executeQuery();
			resultid.next();
			String currentID = resultid.getString(1);
			
			
            pstmt.setString(1, currentID );
            pstmt.setString(2, item_alert);
			pstmt.executeUpdate();
			out.print("<h1>Alert Successfully Set</h1>");
			 out.print("<a href='HomePage.jsp'>Go Back Home</a>");
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